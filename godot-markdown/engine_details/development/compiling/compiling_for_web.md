<a id="doc-compiling-for-web"></a>

# Compiling for the Web

#### SEE ALSO
This page describes how to compile HTML5 editor and export template binaries from source.
If you're looking to export your project to HTML5 instead, read [Exporting for the Web](../../../tutorials/export/exporting_for_web.md#doc-exporting-for-web).

## Requirements

To compile export templates for the Web, the following is required:

- [Emscripten 4.0.0+](https://emscripten.org).
- [Python 3.8+](https://www.python.org/).
- [SCons 4.0+](https://scons.org/pages/download.html) build system.

#### SEE ALSO
To get the Godot source code for compiling, see
[Getting the source](getting_source.md#doc-getting-source).

For a general overview of SCons usage for Godot, see
[Introduction to the buildsystem](introduction_to_the_buildsystem.md#doc-introduction-to-the-buildsystem).

## Building export templates

Before starting, confirm that `emcc` is available in your PATH. This is
usually configured by the Emscripten SDK, e.g. when invoking `emsdk activate`
and `source ./emsdk_env.sh`/`emsdk_env.bat`.

Open a terminal and navigate to the root directory of the engine source code.
Then instruct SCons to build the Web platform. Specify `target` as
either `template_release` for a release build or `template_debug` for a debug build:

```shell
scons platform=web target=template_release
scons platform=web target=template_debug
```

By default, the [JavaScriptBridge singleton](../../../tutorials/platform/web/javascript_bridge.md#doc-web-javascript-bridge) will be built
into the engine. Official export templates also have the JavaScript singleton
enabled. Since `eval()` calls can be a security concern, the
`javascript_eval` option can be used to build without the singleton:

```shell
scons platform=web target=template_release javascript_eval=no
scons platform=web target=template_debug javascript_eval=no
```

By default, WebWorker threads support is enabled. To disable it and only use a single thread,
the `threads` option can be used to build the web template without threads support:

```shell
scons platform=web target=template_release threads=no
scons platform=web target=template_debug threads=no
```

The engine will now be compiled to WebAssembly by Emscripten. Once finished,
the resulting file will be placed in the `bin` subdirectory. Its name is
`godot.web.template_release.wasm32.zip` for release or `godot.web.template_debug.wasm32.zip`
for debug.

Finally, rename the zip archive to `web_release.zip` for the
release template:

```shell
mv bin/godot.web.template_release.wasm32.zip bin/web_release.zip
```

And `web_debug.zip` for the debug template:

```shell
mv bin/godot.web.template_debug.wasm32.zip bin/web_debug.zip
```

## GDExtension

The default export templates do not include GDExtension support for
performance and compatibility reasons. See the
[export page](../../../tutorials/export/exporting_for_web.md#doc-javascript-export-options) for more info.

You can build the export templates using the option `dlink_enabled=yes`
to enable GDExtension support:

```shell
scons platform=web dlink_enabled=yes target=template_release
scons platform=web dlink_enabled=yes target=template_debug
```

Once finished, the resulting file will be placed in the `bin` subdirectory.
Its name will have `_dlink` added.

Finally, rename the zip archives to `web_dlink_release.zip` and
`web_dlink_release.zip` for the release template:

```shell
mv bin/godot.web.template_release.wasm32.dlink.zip bin/web_dlink_release.zip
mv bin/godot.web.template_debug.wasm32.dlink.zip bin/web_dlink_debug.zip
```

## Building the editor

It is also possible to build a version of the Godot editor that can run in the
browser. The editor version is not recommended
over the native build. You can build the editor with:

```shell
scons platform=web target=editor
```

Once finished, the resulting file will be placed in the `bin` subdirectory.
Its name will be `godot.web.editor.wasm32.zip`. You can upload the
zip content to your web server and visit it with your browser to use the editor.

Refer to the [export page](../../../tutorials/export/exporting_for_web.md#doc-javascript-export-options) for the web
server requirements.
