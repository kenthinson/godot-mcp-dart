<a id="doc-c-sharp"></a>

# C#/.NET

C# is a high-level programming language developed by Microsoft. Godot supports
C# as an option for a scripting language, alongside Godot's own
[GDScript](../gdscript/index.md#doc-gdscript).

The standard Godot executable does not contain C# support out of the box. Instead,
to enable C# support for your project you need to [download a .NET version](https://godotengine.org/download/)
of the editor from the Godot website.

* [C# basics](c_sharp_basics.md)
* [C# language features](c_sharp_features.md)
* [C# style guide](c_sharp_style_guide.md)
* [C# diagnostics](diagnostics/index.md)

## Godot API for C#

As a general purpose game engine Godot offers some high-level features as a part
of its API. Articles below explain how these features integrate into C# and how
C# API may be different from GDScript.

* [C# API differences to GDScript](c_sharp_differences.md)
* [C# collections](c_sharp_collections.md)
* [C# Variant](c_sharp_variant.md)
* [C# signals](c_sharp_signals.md)
* [C# exported properties](c_sharp_exports.md)
* [C# global classes](c_sharp_global_classes.md)

<a id="doc-c-sharp-platforms"></a>

## C# platform support

#### SEE ALSO
See [System requirements](../../../about/system_requirements.md#doc-system-requirements) for hardware and software version
requirements for the Godot engine.

#### NOTE
Since C# projects use the .NET runtime, also check the system requirements
for the version of .NET that you'll be using.
See [supported OS](https://github.com/dotnet/core/tree/main/release-notes#supported-os).

Since Godot 4.2, projects written in C# support all desktop platforms (Windows, Linux,
and macOS), as well as Android and iOS.

Android support is currently experimental.

iOS support is currently experimental and has a few limitations.

- The official export templates for the iOS simulator only supports the `x64` architecture.
- Exporting to iOS can only be done from a MacOS device.

Currently, projects written in C# cannot be exported to the web platform. To use C#
on that platform, consider Godot 3 instead.
