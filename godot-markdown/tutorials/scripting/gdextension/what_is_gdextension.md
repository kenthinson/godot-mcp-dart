<a id="doc-what-is-gdextension"></a>

# What is GDExtension?

**GDExtension** is a Godot-specific technology that lets the engine interact with
native [shared libraries](https://en.wikipedia.org/wiki/Library_(computing)#Shared_libraries)
at runtime. You can use it to run native code without compiling it with the engine.

There are three primary methods with which this is achieved:

* `gdextension_interface.h`: A set of C functions that Godot and a GDExtension can use to communicate.
* `extension_api.json`: A list of C functions that are exposed from Godot APIs ([Core Features](../index.md#doc-scripting-core-features)).
* [\*.gdextension](gdextension_file.md#doc-gdextension-file): A file format read by Godot to load a GDExtension.

Most people create GDExtensions with some existing language binding, such as [godot-cpp (for C++)](../cpp/index.md#doc-godot-cpp),
or one of the [community-made ones](../other_languages.md#doc-what-is-gdnative-third-party-bindings).

## Version compatibility

See [godot-cpp Version Compatibility](../cpp/about_godot_cpp.md#doc-what-is-gdextension-version-compatibility), which applies to all GDExtensions.
