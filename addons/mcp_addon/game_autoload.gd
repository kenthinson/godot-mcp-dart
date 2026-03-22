extends Node

var server = TCPServer.new()
var port = 8081
var client_peer: StreamPeerTCP = null

func _ready():
	if server.listen(port) == OK:
		print("DEBUG: MCP Game Autoload HTTP server started on ", port)
	else:
		printerr("DEBUG: MCP Game Autoload failed to start server on ", port)

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
	
	if "GET /get_screenshot" in request:
		var image = get_viewport().get_texture().get_image()
		var png_bytes = image.save_png_to_buffer()
		var base64_image = Marshalls.raw_to_base64(png_bytes)
		
		response += JSON.stringify({"screenshot": base64_image})
	
	elif "GET /call_node_function" in request:
		var params = _parse_params(request)
		var node_path = params.get("nodePath", "root")
		var function_name = params.get("functionName", "")
		var args_json = params.get("arguments", "{}")
		var arguments = JSON.parse_string(args_json)
		
		# Robustly get the scene root in the running game
		var root = get_tree().current_scene
		var target_node = root
		
		if node_path != "root":
			var path_to_node = node_path.replace("root/", "")
			print("DEBUG: Root node is ", root.name, ", trying to find node at: ", path_to_node)
			if root.has_node(path_to_node):
				target_node = root.get_node(path_to_node)
				print("DEBUG: Found node: ", target_node.name)
			else:
				target_node = null
				print("DEBUG: Node NOT found at: ", path_to_node)
		
		if not target_node:
			response += JSON.stringify({"status": "error", "message": "Node not found at: " + node_path})
		elif function_name == "":
			response += JSON.stringify({"status": "error", "message": "No function name provided"})
		elif not target_node.has_method(function_name):
			print("DEBUG: Method not found: ", function_name, " on node: ", target_node.name)
			response += JSON.stringify({"status": "error", "message": "Method '" + function_name + "' not found on node: " + target_node.name})
		else:
			print("DEBUG: Calling method: ", function_name, " with args: ", arguments)
			var result = null
			
			# Check if arguments is an array (standard behavior)
			if typeof(arguments) == TYPE_ARRAY:
				result = target_node.callv(function_name, arguments)
			# Fallback: if arguments is a dictionary (legacy behavior)
			elif typeof(arguments) == TYPE_DICTIONARY:
				if arguments.is_empty():
					result = target_node.call(function_name)
				else:
					result = target_node.call(function_name, arguments)
			# Fallback: single argument of another type
			else:
				result = target_node.call(function_name, arguments)
			
			response += JSON.stringify({"status": "success", "result": result})

	peer.put_data(response.to_utf8_buffer())
	peer.disconnect_from_host()

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
