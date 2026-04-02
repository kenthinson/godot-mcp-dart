<a id="doc-configuring-an-ide"></a>

# Configuring an IDE

We assume that you have already [cloned](https://github.com/godotengine/godot)
and [compiled](../compiling/index.md#toc-devel-compiling) Godot.

You can easily develop Godot with any text editor and by invoking `scons`
on the command line, but if you want to work with an IDE (Integrated
Development Environment), here are setup instructions for some popular ones:

* [Android Studio](android_studio.md)
* [CLion](clion.md)
* [Code::Blocks](code_blocks.md)
* [KDevelop](kdevelop.md)
* [Qt Creator](qt_creator.md)
* [JetBrains Rider](rider.md)
* [Visual Studio](visual_studio.md)
* [Visual Studio Code](visual_studio_code.md)
* [Xcode](xcode.md)

It is possible to use other IDEs, but their setup is not documented yet.

If your editor supports the [language server protocol](https://microsoft.github.io/language-server-protocol/),
you can use [clangd](https://clangd.llvm.org) for completion, diagnostics, and more.
You can generate a compilation database for use with clangd one of two ways:

```shell
# Generate compile_commands.json while compiling
scons compiledb=yes

# Generate compile_commands.json without compiling
scons compiledb=yes compile_commands.json
```
