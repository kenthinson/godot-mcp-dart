<a id="doc-gdextension"></a>

# The GDExtension system

**GDExtension** is a Godot-specific technology that lets the engine interact with
native [shared libraries](https://en.wikipedia.org/wiki/Library_(computing)#Shared_libraries)
at runtime. You can use it to run native code without compiling it with the engine.

#### NOTE
GDExtension is *not* a scripting language and has no relation to
[GDScript](../gdscript/index.md#doc-gdscript).

This section describes how GDExtension works, and is generally aimed at people wanting to make a GDExtension from
scratch, for example to create language bindings. If you want to use existing language bindings, please refer to other
articles instead, such as the articles about [C++ (godot-cpp)](../cpp/index.md#doc-godot-cpp) or one of the
[community-made ones](../other_languages.md#doc-what-is-gdnative-third-party-bindings).

* [What is GDExtension?](what_is_gdextension.md)
* [The .gdextension file](gdextension_file.md)
* [The C interface JSON file](gdextension_interface_json_file.md)
* [GDExtension C example](gdextension_c_example.md)
