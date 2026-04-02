<a id="doc-engine-module-api"></a>

# Engine extension APIs

This section introduces various ways in which you can extend the engine with C++ code.
You can use these APIs by creating a [module](custom_modules_in_cpp.md#doc-custom-modules-in-cpp).
Note that you can change the engine in many more ways than presented here — this section just presents
a subselection of common and useful ways to do it.

Alternatively, some of the functions presented here are also available through the
[GDExtension](../../tutorials/scripting/gdextension/what_is_gdextension.md#doc-what-is-gdextension) API.
You can use them in C++ by using creating a [godot-cpp](../../tutorials/scripting/cpp/about_godot_cpp.md#doc-about-godot-cpp) based GDExtension,
or with any of the [community-created GDExtension implementations](../../tutorials/scripting/other_languages.md#doc-scripting-languages). Note though
that some aspects of the code or directory structures may be different in GDExtension compared to the module APIs.

* [Custom modules in C++](custom_modules_in_cpp.md)
* [Binding to external libraries](binding_to_external_libraries.md)
* [Custom Godot servers](custom_godot_servers.md)
* [Custom resource format loaders](custom_resource_format_loaders.md)
* [Custom AudioStreams](custom_audiostreams.md)
* [Custom platform ports](custom_platform_ports.md)
