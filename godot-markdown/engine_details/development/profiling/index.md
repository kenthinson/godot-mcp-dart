<a id="doc-using-cpp-profilers"></a>

# Using C++ profilers

To optimize Godot's performance, you need to know what to optimize first.
To this end, profilers are useful tools.

#### NOTE
There is a [built-in GDScript profiler](../../../tutorials/scripting/debug/the_profiler.md#doc-the-profiler) in the editor,
but using a C++ profiler may be useful in cases where the GDScript profiler
is not accurate enough or is missing information due to bugs in the profiler.

There are two main types of profilers: sampling profilers and tracing profilers.

Sampling profilers periodically interrupt the running program and take a "sample",
which records which functions are running. Using this information, the profiler
estimates which functions the program spent the most time in.

Tracing profilers work by recording application-specific events (such as the
start and end of a single frame), producing a log called a "trace". The profiler
can use the trace to produce a graph showing an accurate high-level timeline of
what happened. However, any code that is not explicitly instrumented will not
appear in a tracing profiler's timeline!

Godot supports both sampling profilers and tracing profilers, and already
includes the logging code for common Godot events for use with a tracing profiler!

Different problems may be easier to debug with one kind of profiler over the other,
but it's difficult to provide a set of rules for which to use. Give both a try,
and see what you can learn from them!

<a id="doc-sampling-profilers"></a>

## Sampling profilers

We recommend the following sampling profilers:

- [VerySleepy](very_sleepy.md#doc-profiler-very-sleepy) (Windows only)
- [Hotspot](hotspot.md#doc-profiler-hotspot) (Linux only)
- [Instruments](instruments.md#doc-profiler-instruments) (Apple only)

These profilers may not be the most powerful or flexible options, but their
standalone operation and limited feature set tends to make them easier to use.

### Setting up Godot

To get useful profiling information, it is **absolutely required** to use a Godot
build that includes debugging symbols. Official binaries do not include debugging
symbols, since these would make the download size significantly larger.

To get profiling data that best matches the production environment (but with debugging symbols),
you should compile binaries with the `production=yes debug_symbols=yes` SCons options.

It is possible to run a profiler on less optimized builds (e.g. `target=template_debug` without LTO),
but results will naturally be less representative of real world conditions.

#### WARNING
Do *not* strip debugging symbols on the binaries using the `strip` command
after compiling the binaries. Otherwise, you will no longer get useful
profiling information when running a profiler.

### Benchmarking startup/shutdown times

If you're looking into optimizing Godot's startup/shutdown performance,
you can tell the profiler to use the `--quit` command line option on the Godot binary.
This will exit Godot just after it's done starting.
The `--quit` option works with `--editor`, `--project-manager`, and
`--path <path to project directory>` (which runs a project directly).

#### SEE ALSO
See [Command line tutorial](../../../tutorials/editor/command_line_tutorial.md#doc-command-line-tutorial) for more command line arguments
supported by Godot.

<a id="doc-tracing-profilers"></a>

## Tracing profilers

Godot currently supports three tracing profilers:

- [Tracy](tracy.md#doc-profiler-tracy)
- [Perfetto](perfetto.md#doc-profiler-perfetto)
- [Instruments](instruments.md#doc-profiler-instruments) (Apple only)

In order to use either of them, you'll need to build the engine from source.
If you've never done this before, please read
[these docs](../compiling/index.md#doc-compiling-index) for the platform you want to profile on.
You'll need to perform the same steps here, but with some additional arguments
for `scons`.

## All recommended profilers

* [Hotspot](hotspot.md)
* [Instruments](instruments.md)
* [Perfetto](perfetto.md)
* [Tracy](tracy.md)
* [VerySleepy](very_sleepy.md)
