@tool
extends Node

var server = TCPServer.new()
var port = 8080
var client_peer: StreamPeerTCP = null

func _ready():
	if server.listen(port) == OK:
		print("DEBUG: MCP Editor Autoload HTTP server started on ", port)
	else:
		printerr("DEBUG: MCP Editor Autoload failed to start server on ", port)

func _process(_delta):
	# Handle new connection
	if not client_peer:
		if server.is_connection_available():
			client_peer = server.take_connection()
	# Handle data on existing connection
	elif client_peer.get_status() == StreamPeerTCP.STATUS_CONNECTED:
		if client_peer.get_available_bytes() > 0:
			handle_request(client_peer)
			client_peer = null # Reset for next request
	else:
		client_peer = null

func handle_request(peer: StreamPeerTCP):
	var request = peer.get_utf8_string(peer.get_available_bytes())
	var response = "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n\r\n"
	
	if "GET /ping" in request:
		response += JSON.stringify({"status": "ok"})
	
	elif "GET /get_selected_node" in request:
		var selected = EditorInterface.get_selection().get_selected_nodes()
		var node_names = []
		for node in selected:
			node_names.append(node.name)
		response += JSON.stringify({"nodes": node_names})
	
	elif "GET /create_scene" in request:
		var params = _parse_params(request)
		var scene_path = params.get("scenePath", "res://new_scene.tscn")
		var root_node_type = params.get("rootNodeType", "Node2D")
		
		var root = ClassDB.instantiate(root_node_type)
		root.name = "Root"
		var packed = PackedScene.new()
		packed.pack(root)
		ResourceSaver.save(packed, scene_path)
		EditorInterface.open_scene_from_path(scene_path)
		response += JSON.stringify({"status": "created", "path": scene_path})
		
	elif "GET /add_node" in request:
		var params = _parse_params(request)
		var node_type = params.get("nodeType", "Node2D")
		var node_name = params.get("nodeName", "NewNode")
		var parent_path = params.get("parentNodePath", "root")
		
		var edited_root = EditorInterface.get_edited_scene_root()
		if edited_root:
			var parent = edited_root
			if parent_path != "root":
				var path_to_parent = parent_path.replace("root/", "")
				if edited_root.has_node(path_to_parent):
					parent = edited_root.get_node(path_to_parent)
				else:
					response += JSON.stringify({"status": "error", "message": "Parent node not found"})
					peer.put_data(response.to_utf8_buffer())
					peer.disconnect_from_host()
					return
			
			var new_node = ClassDB.instantiate(node_type)
			new_node.name = node_name
			parent.add_child(new_node)
			new_node.set_owner(edited_root)
			EditorInterface.save_all_scenes()
			response += JSON.stringify({"status": "added", "name": node_name, "parent": parent_path})
		else:
			response += JSON.stringify({"status": "error", "message": "No scene open"})
			
	elif "GET /remove_node" in request:
		var params = _parse_params(request)
		var node_path = params.get("nodePath", "")
		
		var edited_root = EditorInterface.get_edited_scene_root()
		if edited_root and node_path != "":
			var target_node = null
			if node_path == "root":
				target_node = edited_root
			else:
				var path_to_node = node_path.replace("root/", "")
				if edited_root.has_node(path_to_node):
					target_node = edited_root.get_node(path_to_node)
			
			if target_node == edited_root:
				response += JSON.stringify({"status": "error", "message": "Cannot remove root node"})
			elif target_node:
				var parent = target_node.get_parent()
				parent.remove_child(target_node)
				target_node.free() # Using free() for immediate deletion
				EditorInterface.save_all_scenes()
				response += JSON.stringify({"status": "removed", "node": node_path})
			else:
				response += JSON.stringify({"status": "error", "message": "Node not found"})
		else:
			response += JSON.stringify({"status": "error", "message": "No scene open or node path missing"})

	elif "GET /rename_node" in request:
		var params = _parse_params(request)
		var node_path = params.get("nodePath", "")
		var new_name = params.get("newName", "")
		
		var edited_root = EditorInterface.get_edited_scene_root()
		if edited_root and node_path != "" and new_name != "":
			var target_node = null
			if node_path == "root":
				target_node = edited_root
			else:
				var path_to_node = node_path.replace("root/", "")
				if edited_root.has_node(path_to_node):
					target_node = edited_root.get_node(path_to_node)
			
			if target_node:
				target_node.name = new_name
				EditorInterface.save_all_scenes()
				response += JSON.stringify({"status": "renamed", "node": node_path, "newName": new_name})
			else:
				response += JSON.stringify({"status": "error", "message": "Node not found"})
		else:
			response += JSON.stringify({"status": "error", "message": "Invalid arguments"})

	elif "GET /reparent_node" in request:
		var params = _parse_params(request)
		var node_path = params.get("nodePath", "")
		var new_parent_path = params.get("newParentPath", "root")
		
		var edited_root = EditorInterface.get_edited_scene_root()
		if edited_root and node_path != "":
			var target_node = null
			var new_parent = edited_root
			
			# Find target
			if node_path == "root":
				target_node = edited_root
			else:
				var path_to_node = node_path.replace("root/", "")
				if edited_root.has_node(path_to_node):
					target_node = edited_root.get_node(path_to_node)
			
			# Find new parent
			if new_parent_path != "root":
				var path_to_parent = new_parent_path.replace("root/", "")
				if edited_root.has_node(path_to_parent):
					new_parent = edited_root.get_node(path_to_parent)
				else:
					response += JSON.stringify({"status": "error", "message": "New parent node not found"})
					peer.put_data(response.to_utf8_buffer())
					peer.disconnect_from_host()
					return
			
			if target_node and target_node != edited_root:
				var old_parent = target_node.get_parent()
				old_parent.remove_child(target_node)
				new_parent.add_child(target_node)
				target_node.set_owner(edited_root)
				EditorInterface.save_all_scenes()
				response += JSON.stringify({"status": "reparented", "node": node_path, "newParent": new_parent_path})
			elif target_node == edited_root:
				response += JSON.stringify({"status": "error", "message": "Cannot reparent root node"})
			else:
				response += JSON.stringify({"status": "error", "message": "Node not found"})
		else:
			response += JSON.stringify({"status": "error", "message": "Invalid arguments"})
	
	elif "GET /attach_script" in request:
		var params = _parse_params(request)
		var node_path = params.get("nodePath", "")
		var script_path = params.get("scriptPath", "")
		
		var edited_root = EditorInterface.get_edited_scene_root()
		if edited_root and node_path != "" and script_path != "":
			var target_node = null
			if node_path == "root":
				target_node = edited_root
			else:
				var path_to_node = node_path.replace("root/", "")
				if edited_root.has_node(path_to_node):
					target_node = edited_root.get_node(path_to_node)
			
			if target_node:
				var script = load(script_path)
				if script is Script:
					target_node.set_script(script)
					EditorInterface.save_all_scenes()
					response += JSON.stringify({"status": "attached", "node": node_path, "script": script_path})
				else:
					response += JSON.stringify({"status": "error", "message": "Invalid script path or not a script resource"})
			else:
				response += JSON.stringify({"status": "error", "message": "Node not found"})
		else:
			response += JSON.stringify({"status": "error", "message": "Invalid arguments"})

	elif "GET /detach_script" in request:
		var params = _parse_params(request)
		var node_path = params.get("nodePath", "")
		
		var edited_root = EditorInterface.get_edited_scene_root()
		if edited_root and node_path != "":
			var target_node = null
			if node_path == "root":
				target_node = edited_root
			else:
				var path_to_node = node_path.replace("root/", "")
				if edited_root.has_node(path_to_node):
					target_node = edited_root.get_node(path_to_node)
			
			if target_node:
				target_node.set_script(null)
				EditorInterface.save_all_scenes()
				response += JSON.stringify({"status": "detached", "node": node_path})
			else:
				response += JSON.stringify({"status": "error", "message": "Node not found"})
		else:
			response += JSON.stringify({"status": "error", "message": "Invalid arguments"})

	elif "GET /get_project_info" in request:
		var info = {
			"name": ProjectSettings.get_setting("application/config/name"),
			"path": ProjectSettings.globalize_path("res://"),
			"godotVersion": Engine.get_version_info(),
			"structure": _scan_project_structure("res://")
		}
		response += JSON.stringify(info)

	elif "GET /get_uid" in request:
		var params = _parse_params(request)
		var file_path = params.get("filePath", "")
		var uid = ""
		if file_path != "":
			if ResourceLoader.exists(file_path):
				var id = ResourceLoader.get_resource_uid(file_path)
				if id != -1:
					uid = ResourceUID.id_to_text(id)
				else:
					print("DEBUG: get_resource_uid returned -1 for ", file_path)
			else:
				print("DEBUG: ResourceLoader.exists failed for ", file_path)
		response += JSON.stringify({"uid": uid})
		
	elif "GET /list_scene_nodes" in request:
		var edited_root = EditorInterface.get_edited_scene_root()
		if edited_root:
			var node_list = []
			_recursive_list_nodes(edited_root, node_list)
			response += JSON.stringify({"nodes": node_list})
		else:
			response += JSON.stringify({"status": "error", "message": "No scene open"})

	elif "GET /get_selected_text" in request:
		var script_editor = EditorInterface.get_script_editor()
		var current_editor = script_editor.get_current_editor()
		
		if current_editor:
			var code_edit = current_editor.get_base_editor()
			var file_path = ""
			
			# Get the currently edited script's path via ScriptEditor
			var current_script = script_editor.get_current_script()
			if current_script and current_script.resource_path != "":
				file_path = ProjectSettings.globalize_path(current_script.resource_path)
			
			if code_edit and code_edit is CodeEdit:
				var selected_text = code_edit.get_selected_text()
				response += JSON.stringify({"text": selected_text, "file_path": file_path})
			else:
				response += JSON.stringify({"status": "error", "message": "No text editor active"})
		else:
			response += JSON.stringify({"status": "error", "message": "Script Editor not open"})
	
	peer.put_data(response.to_utf8_buffer())
	peer.disconnect_from_host()

func _recursive_list_nodes(node: Node, list: Array):
	var edited_root = EditorInterface.get_edited_scene_root()
	var path = "root"
	if node != edited_root:
		path = "root/" + String(edited_root.get_path_to(node))
	list.append({
		"name": node.name,
		"path": path,
		"type": node.get_class()
	})
	for child in node.get_children():
		_recursive_list_nodes(child, list)

func _scan_project_structure(path: String) -> Dictionary:
	var structure = {"scenes": 0, "scripts": 0, "assets": 0, "other": 0}
	_recursive_scan(path, structure)
	return structure

func _recursive_scan(path: String, structure: Dictionary):
	var dir = DirAccess.open(path)
	if not dir:
		return
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			if not file_name.begins_with("."):
				_recursive_scan(path.path_join(file_name), structure)
		else:
			var ext = file_name.get_extension().to_lower()
			if ext == "tscn":
				structure["scenes"] += 1
			elif ext in ["gd", "cs"]:
				structure["scripts"] += 1
			elif ext in ["png", "jpg", "jpeg", "svg", "wav", "mp3"]:
				structure["assets"] += 1
			else:
				structure["other"] += 1
		file_name = dir.get_next()

func _parse_params(request: String) -> Dictionary:
	var params = {}
	var url_part = request.split(" ")[1]
	if "?" in url_part:
		var query = url_part.split("?")[1]
		for pair in query.split("&"):
			var kv = pair.split("=")
			if kv.size() == 2:
				params[kv[0]] = kv[1].uri_decode()
	return params
