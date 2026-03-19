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
	if "GET /get_screenshot" in request:
		var image = get_viewport().get_texture().get_image()
		var png_bytes = image.save_png_to_buffer()
		var base64_image = Marshalls.raw_to_base64(png_bytes)
		
		var response = "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n\r\n"
		response += JSON.stringify({"screenshot": base64_image})
		peer.put_data(response.to_utf8_buffer())
	peer.disconnect_from_host()
