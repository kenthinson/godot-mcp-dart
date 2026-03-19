# Godot Dart MCP Server

A Dart-based Model Context Protocol (MCP) server for interacting with the Godot Engine, providing both process-level management and a live HTTP Bridge for real-time Editor/Game interaction.

## Features

### Process Management
- `run_project`: Run a Godot project (supports headless/windowed modes).
- `launch_editor`: Launch the Godot Editor for a project.
- `stop_project`: Stop the currently running Godot project process.
- `get_debug_output`: Retrieve stdout/stderr from the running process.
- `get_godot_version`: Query the installed Godot version.
- `list_projects`: Discover Godot projects in a directory.

### Editor HTTP Bridge (Real-time Interaction)
- `list_scene_nodes`: List all nodes in the active scene tree.
- `get_selected_node`: Get currently selected node(s) in the Editor.
- `create_scene`: Create and open a new scene.
- `add_node`: Add a node as a child of another node.
- `remove_node`: Remove / delete a node from the scene.
- `rename_node`: Rename a node in the scene.
- `reparent_node`: Change a node's parent in the scene.
- `attach_script`: Attach a GDScript/C# script to a node.
- `detach_script`: Detach a script from a node.
- `save_scene`: Persist the active scene.
- `get_project_info`: Retrieve project metadata and structure.
- `get_uid` / `update_project_uids`: Manage resource UIDs.

### Game HTTP Bridge (Real-time Interaction)
- `get_screenshot`: Capture the running game for vision-capable models.
- `call_node_function`: Call a function on a node in the running game. Supports JSON arguments; empty `{}` calls without arguments, non-empty dictionaries are passed as a single argument. Returns structured JSON error/success responses.

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/kenthinson/godot-mcp-dart
   cd godot-mcp-dart
   ```

2. **Install dependencies:**
   ```bash
   dart pub get
   ```

3. **Link to your Godot project:**
   Symlink the `addons/mcp_addon` folder to your Godot project's `addons/` folder for automatic updates:
   ```bash
   ln -s /path/to/godot/addons/mcp_addon /path/to/your/godot-project/addons/mcp_addon
   ```

4. **Configure your environment variable:**
   ```bash
   export GODOT_PATH=/path/to/your/godot/executable
   ```

## Client Configuration

This server adheres to the standard Model Context Protocol and can be configured with various MCP-compatible agents. Ensure you use an **absolute path** to the `bin/godot.dart` entrypoint.

### Claude Code
Add the following to your `mcp.json` configuration file:

```json
{
  "mcpServers": {
    "godot": {
      "command": "dart",
      "args": ["run", "/absolute/path/to/godot-mcp-dart/bin/godot.dart"]
    }
  }
}
```

### Google Antigravity
Configure your Antigravity environment by adding the server to your agent's MCP configuration:

```json
{
  "mcp_servers": [
    {
      "name": "godot",
      "command": "dart",
      "args": ["run", "/absolute/path/to/godot-mcp-dart/bin/godot.dart"]
    }
  ]
}
```

### OpenCode
Add the following to your `opencode` configuration file:
```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "Godot MCP": {
      "type": "local",
      "command": [
        "env",
        "GODOT_PATH=/path/to/godot",
        "DEBUG=true",
        "dart",
        "run",
        "/path/to/mcp/files/godot/bin/godot.dart"
      ],
      "enabled": true
    }
  },
  "lsp": {
    "gdscript": {
      "command": [
        "npx",
        "opencode-godot-lsp"
      ],
      "extensions": [
        ".gd",
        ".gdshader"
      ]
    }
  }
}
```
*Note: We recommend using [https://github.com/MasuRii/opencode-godot-lsp](https://github.com/MasuRii/opencode-godot-lsp) for the LSP component.*


## Updating

To pull the latest changes from the repository:

```bash
git pull
dart pub get
```

## Requirements
- Dart SDK installed.
- Godot Engine installed.
- `GODOT_PATH` environment variable set to the Godot executable.

## Known Limitations
- This MCP server is currently only tested with OpenCode on Linux.
