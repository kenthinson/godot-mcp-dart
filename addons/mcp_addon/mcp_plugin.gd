@tool
extends EditorPlugin

const GAME_AUTOLOAD_PATH = "res://addons/mcp_addon/game_autoload.gd"
const EDITOR_AUTOLOAD_PATH = "res://addons/mcp_addon/editor_autoload.gd"

var editor_autoload_instance: Node

func _enter_tree():
	# Runtime Autoload
	add_autoload_singleton("MCPGame", GAME_AUTOLOAD_PATH)
	
	# Editor Autoload (Loading instance into editor root)
	var editor_script = load(EDITOR_AUTOLOAD_PATH)
	if editor_script and editor_script is GDScript:
		editor_autoload_instance = editor_script.new()
		get_editor_interface().get_editor_main_screen().add_child(editor_autoload_instance)

func _exit_tree():
	remove_autoload_singleton("MCPGame")
	
	if editor_autoload_instance:
		editor_autoload_instance.queue_free()
