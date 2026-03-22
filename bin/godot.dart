import 'dart:io';
import 'dart:convert';
import 'package:mcp_server/mcp_server.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class GodotServer {
  final Server _server;
  String? _godotPath;
  final String _operationsScriptPath;
  Process? _activeProcess;
  final List<String> _output = [];
  final List<String> _errors = [];

  GodotServer(this._operationsScriptPath)
    : _server = Server(
        name: 'godot-mcp-dart',
        version: '0.1.0',
        capabilities: ServerCapabilities.simple(tools: true),
      ) {
    _setupToolHandlers();
    _useFields();
  }

  void _useFields() {
    print(_operationsScriptPath);
  }

  void _setupToolHandlers() {
    _server.addTool(
      name: 'run_project',
      description: 'Run the Godot project',
      inputSchema: {
        'type': 'object',
        'properties': {
          'projectPath': {'type': 'string'},
          'headless': {'type': 'boolean'},
          'scene': {'type': 'string'},
        },
        'required': ['projectPath'],
      },
      handler: (arguments) async => await _handleRunProject(arguments),
    );

    _server.addTool(
      name: 'get_godot_version',
      description: 'Get the installed Godot version',
      inputSchema: {'type': 'object', 'properties': {}, 'required': []},
      handler: (arguments) async {
        final version = await _getGodotVersion();
        return CallToolResult(content: [TextContent(text: version)]);
      },
    );

    _server.addTool(
      name: 'list_projects',
      description: 'List Godot projects in a directory',
      inputSchema: {
        'type': 'object',
        'properties': {
          'directory': {
            'type': 'string',
            'description': 'Directory to search for Godot projects',
          },
        },
        'required': ['directory'],
      },
      handler: (arguments) async {
        final directory = arguments['directory'] as String;
        final projects = _findGodotProjects(directory);
        return CallToolResult(
          content: [TextContent(text: jsonEncode(projects))],
        );
      },
    );

    _server.addTool(
      name: 'add_node',
      description:
          'Add a node to an existing node in the scene. IMPORTANT: Verify the parent path using list_scene_nodes first.',
      inputSchema: {
        'type': 'object',
        'properties': {
          'parentNodePath': {
            'type': 'string',
            'description':
                'Path to parent node (e.g., "root" or "root/Player")',
          },
          'nodeType': {
            'type': 'string',
            'description': 'Type of node (e.g., Node2D, Sprite2D)',
          },
          'nodeName': {'type': 'string', 'description': 'Name of the new node'},
        },
        'required': ['nodeType', 'nodeName'],
      },
      handler: (arguments) async {
        try {
          final uri = Uri.parse('http://localhost:8080/add_node').replace(
            queryParameters: {
              'parentNodePath': arguments['parentNodePath'] ?? 'root',
              'nodeType': arguments['nodeType'],
              'nodeName': arguments['nodeName'],
            },
          );
          final response = await http.get(uri);
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'get_debug_output',
      description: 'Get the current debug output and errors',
      inputSchema: {'type': 'object', 'properties': {}, 'required': []},
      handler: (arguments) async => await _handleGetDebugOutput(),
    );

    _server.addTool(
      name: 'stop_project',
      description: 'Stop the currently running Godot project',
      inputSchema: {'type': 'object', 'properties': {}, 'required': []},
      handler: (arguments) async => await _handleStopProject(),
    );

    _server.addTool(
      name: 'get_selected_node',
      description: 'Get the selected nodes in the Godot Editor',
      inputSchema: {'type': 'object', 'properties': {}, 'required': []},
      handler: (arguments) async {
        try {
          final response = await http.get(
            Uri.parse('http://localhost:8080/get_selected_node'),
          );
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'launch_editor',
      description: 'Launch the Godot editor if not already running',
      inputSchema: {
        'type': 'object',
        'properties': {
          'projectPath': {
            'type': 'string',
            'description': 'Path to the Godot project directory',
          },
        },
        'required': ['projectPath'],
      },
      handler: (arguments) async {
        final projectPath = arguments['projectPath'] as String;
        try {
          // Check if running
          final response = await http
              .get(Uri.parse('http://localhost:8080/ping'))
              .timeout(const Duration(seconds: 2));
          if (response.statusCode == 200) {
            return CallToolResult(
              content: [TextContent(text: 'Godot Editor is already running.')],
            );
          }
        } catch (e) {
          // If ping fails, assume not running
        }

        try {
          final godot = await _ensureGodotPath();
          await Process.start(godot, ['-e', '--path', projectPath]);
          return CallToolResult(
            content: [
              TextContent(
                text: 'Godot Editor launched for project at $projectPath.',
              ),
            ],
          );
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Failed to launch editor: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'create_scene',
      description: 'Create a new Godot scene in the editor',
      inputSchema: {
        'type': 'object',
        'properties': {
          'scenePath': {'type': 'string'},
          'rootNodeType': {'type': 'string'},
        },
        'required': ['scenePath'],
      },
      handler: (arguments) async {
        try {
          final uri = Uri.parse('http://localhost:8080/create_scene').replace(
            queryParameters: {
              'scenePath': arguments['scenePath'],
              'rootNodeType': arguments['rootNodeType'] ?? 'Node2D',
            },
          );
          final response = await http.get(uri);
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'remove_node',
      description: 'Remove / delete a node from the active scene',
      inputSchema: {
        'type': 'object',
        'properties': {
          'nodePath': {
            'type': 'string',
            'description': 'Path to the node to remove (e.g., "root/MyNode")',
          },
        },
        'required': ['nodePath'],
      },
      handler: (arguments) async {
        try {
          final uri = Uri.parse(
            'http://localhost:8080/remove_node',
          ).replace(queryParameters: {'nodePath': arguments['nodePath']});
          final response = await http.get(uri);
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'rename_node',
      description: 'Rename a node in the active scene',
      inputSchema: {
        'type': 'object',
        'properties': {
          'nodePath': {
            'type': 'string',
            'description': 'Path to the node (e.g., "root/MyNode")',
          },
          'newName': {'type': 'string', 'description': 'New name for the node'},
        },
        'required': ['nodePath', 'newName'],
      },
      handler: (arguments) async {
        try {
          final uri = Uri.parse('http://localhost:8080/rename_node').replace(
            queryParameters: {
              'nodePath': arguments['nodePath'],
              'newName': arguments['newName'],
            },
          );
          final response = await http.get(uri);
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'reparent_node',
      description: 'Reparent a node in the active scene',
      inputSchema: {
        'type': 'object',
        'properties': {
          'nodePath': {
            'type': 'string',
            'description': 'Path to the node to reparent (e.g., "root/MyNode")',
          },
          'newParentPath': {
            'type': 'string',
            'description':
                'Path to the new parent node (e.g., "root/Container")',
          },
        },
        'required': ['nodePath', 'newParentPath'],
      },
      handler: (arguments) async {
        try {
          final uri = Uri.parse('http://localhost:8080/reparent_node').replace(
            queryParameters: {
              'nodePath': arguments['nodePath'],
              'newParentPath': arguments['newParentPath'],
            },
          );
          final response = await http.get(uri);
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'attach_script',
      description: 'Attach a GDScript/C# script to a node',
      inputSchema: {
        'type': 'object',
        'properties': {
          'nodePath': {
            'type': 'string',
            'description': 'Path to the node (e.g., "root/MyNode")',
          },
          'scriptPath': {
            'type': 'string',
            'description':
                'Path to the script (e.g., "res://scripts/my_script.gd")',
          },
        },
        'required': ['nodePath', 'scriptPath'],
      },
      handler: (arguments) async {
        try {
          final uri = Uri.parse('http://localhost:8080/attach_script').replace(
            queryParameters: {
              'nodePath': arguments['nodePath'],
              'scriptPath': arguments['scriptPath'],
            },
          );
          final response = await http.get(uri);
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'detach_script',
      description: 'Detach a script from a node',
      inputSchema: {
        'type': 'object',
        'properties': {
          'nodePath': {
            'type': 'string',
            'description': 'Path to the node (e.g., "root/MyNode")',
          },
        },
        'required': ['nodePath'],
      },
      handler: (arguments) async {
        try {
          final uri = Uri.parse(
            'http://localhost:8080/detach_script',
          ).replace(queryParameters: {'nodePath': arguments['nodePath']});
          final response = await http.get(uri);
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'list_scene_nodes',
      description: 'List all nodes in the active scene',
      inputSchema: {'type': 'object', 'properties': {}, 'required': []},
      handler: (arguments) async {
        try {
          final response = await http.get(
            Uri.parse('http://localhost:8080/list_scene_nodes'),
          );
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'save_scene',
      description: 'Save the active scene in the editor',
      inputSchema: {'type': 'object', 'properties': {}, 'required': []},
      handler: (arguments) async {
        try {
          final response = await http.get(
            Uri.parse('http://localhost:8080/save_scene'),
          );
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'get_project_info',
      description: 'Retrieve metadata about the active Godot project',
      inputSchema: {
        'type': 'object',
        'properties': {
          'projectPath': {
            'type': 'string',
            'description': 'Optional path to ensure context.',
          },
        },
        'required': [],
      },
      handler: (arguments) async {
        try {
          final response = await http.get(
            Uri.parse('http://localhost:8080/get_project_info'),
          );
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'get_uid',
      description: 'Get the UID for a specific file in the Godot project',
      inputSchema: {
        'type': 'object',
        'properties': {
          'filePath': {
            'type': 'string',
            'description':
                'Path to the file using res:// format (e.g., res://scenes/main.tscn)',
          },
        },
        'required': ['filePath'],
      },
      handler: (arguments) async {
        try {
          final uri = Uri.parse(
            'http://localhost:8080/get_uid',
          ).replace(queryParameters: {'filePath': arguments['filePath']});
          final response = await http.get(uri);
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'update_project_uids',
      description:
          'Update UID references by saving all scenes and scanning the filesystem',
      inputSchema: {'type': 'object', 'properties': {}, 'required': []},
      handler: (arguments) async {
        try {
          final response = await http.get(
            Uri.parse('http://localhost:8080/update_project_uids'),
          );
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling editor API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'get_screenshot',
      description: 'Get a screenshot of the running game',
      inputSchema: {'type': 'object', 'properties': {}, 'required': []},
      handler: (arguments) async {
        try {
          final response = await http.get(
            Uri.parse('http://localhost:8081/get_screenshot'),
          );

          if (response.statusCode != 200) {
            return CallToolResult(
              content: [
                TextContent(
                  text: 'Error: Game API returned ${response.statusCode}',
                ),
              ],
              isError: true,
            );
          }

          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse['screenshot'] == null) {
            return CallToolResult(
              content: [
                TextContent(
                  text: 'Error: Screenshot data not found in response',
                ),
              ],
              isError: true,
            );
          }

          final base64Image = jsonResponse['screenshot'] as String;

          return CallToolResult(
            content: [ImageContent(data: base64Image, mimeType: 'image/png')],
          );
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling game API: $e')],
            isError: true,
          );
        }
      },
    );

    _server.addTool(
      name: 'call_node_function',
      description:
          'Call a function on a node in the running game. Supports multiple arguments of various types (int, float, string, boolean, arrays, dictionaries).',
      inputSchema: {
        'type': 'object',
        'properties': {
          'nodePath': {
            'type': 'string',
            'description': 'Path to the node (e.g., "root/Player")',
          },
          'functionName': {
            'type': 'string',
            'description': 'Name of the function to call',
          },
          'arguments': {
            'type': 'array',
            'description': 'List of arguments to pass to the function',
            'items': {},
          },
        },
        'required': ['nodePath', 'functionName'],
      },
      handler: (arguments) async {
        try {
          final uri = Uri.parse('http://localhost:8081/call_node_function')
              .replace(
                queryParameters: {
                  'nodePath': arguments['nodePath'],
                  'functionName': arguments['functionName'],
                  'arguments': jsonEncode(arguments['arguments'] ?? []),
                },
              );
          final response = await http.get(uri);
          return CallToolResult(content: [TextContent(text: response.body)]);
        } catch (e) {
          return CallToolResult(
            content: [TextContent(text: 'Error calling game API: $e')],
            isError: true,
          );
        }
      },
    );
  }

  Future<CallToolResult> _handleRunProject(
    Map<String, dynamic> arguments,
  ) async {
    final projectPath = arguments['projectPath'] as String;
    final isHeadless = arguments['headless'] is bool
        ? arguments['headless'] as bool
        : arguments['headless'] == 'true';

    // Stop existing process
    if (_activeProcess != null) {
      _activeProcess!.kill();
      _activeProcess = null;
    }

    _output.clear();
    _errors.clear();

    final godot = await _ensureGodotPath();
    final args = ['--path', projectPath];
    if (isHeadless) {
      args.add('--headless');
    }

    if (arguments.containsKey('scene')) {
      args.add(arguments['scene'] as String);
    }

    try {
      final process = await Process.start(godot, args);
      _activeProcess = process;

      process.stdout
          .transform(utf8.decoder)
          .listen((data) => _output.add(data));
      process.stderr
          .transform(utf8.decoder)
          .listen((data) => _errors.add(data));

      return CallToolResult(
        content: [
          TextContent(
            text:
                'Godot project started ${isHeadless ? 'in headless mode' : 'in windowed mode'}.',
          ),
        ],
      );
    } catch (e) {
      return CallToolResult(
        content: [TextContent(text: 'Failed to start project: $e')],
        isError: true,
      );
    }
  }

  Future<CallToolResult> _handleGetDebugOutput() async {
    return CallToolResult(
      content: [
        TextContent(
          text: 'Output: ${_output.join()}\nErrors: ${_errors.join()}',
        ),
      ],
    );
  }

  Future<CallToolResult> _handleStopProject() async {
    if (_activeProcess == null) {
      return CallToolResult(
        content: [TextContent(text: 'No active process to stop.')],
      );
    }

    _activeProcess!.kill();
    _activeProcess = null;
    return CallToolResult(
      content: [TextContent(text: 'Godot project stopped.')],
    );
  }

  Future<String> _getGodotVersion() async {
    final godot = await _ensureGodotPath();
    final result = await Process.run(godot, ['--version']);
    return result.stdout.toString().trim();
  }

  List<Map<String, String>> _findGodotProjects(String directory) {
    final projects = <Map<String, String>>[];
    final dir = Directory(directory);
    if (!dir.existsSync()) return projects;

    for (final entity in dir.listSync()) {
      if (entity is Directory) {
        final projectFile = File(path.join(entity.path, 'project.godot'));
        if (projectFile.existsSync()) {
          projects.add({
            'path': entity.path,
            'name': path.basename(entity.path),
          });
        }
      }
    }
    return projects;
  }

  Future<String> _ensureGodotPath() async {
    if (_godotPath != null) return _godotPath!;

    final envPath = Platform.environment['GODOT_PATH'];
    if (envPath != null) {
      if (await _isValidGodotPath(envPath)) {
        _godotPath = envPath;
        return _godotPath!;
      }
      stderr.writeln('[ERROR] GODOT_PATH set to invalid executable: $envPath');
    }

    _godotPath = 'godot';
    if (await _isValidGodotPath(_godotPath!)) {
      return _godotPath!;
    }

    throw Exception('Could not find a valid Godot executable. Set GODOT_PATH.');
  }

  Future<bool> _isValidGodotPath(String executablePath) async {
    try {
      final result = await Process.run(executablePath, ['--version']);
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  void start() {
    final transport = StdioServerTransport();
    _server.connect(transport);
  }
}

void main() async {
  final scriptPath = path.join(
    Directory.current.path,
    'scripts',
    'godot_operations.gd',
  );
  final server = GodotServer(scriptPath);
  server.start();
}
