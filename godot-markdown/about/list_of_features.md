<a id="doc-list-of-features"></a>

# List of features

This page aims to list **all** features currently supported by Godot.

#### NOTE
This page lists features supported by the current stable version of
Godot. Some of these features are not available in the
[3.x release series](https://docs.godotengine.org/en/3.6/about/list_of_features.html).

## Platforms

#### SEE ALSO
See [System requirements](system_requirements.md#doc-system-requirements) for hardware and software version requirements.

#### NOTE
For information about console support, see the [Godot website](https://godotengine.org/consoles/).

**Can run both the editor and exported projects:**

- Windows (x86 and ARM, 64-bit and 32-bit).
- macOS (x86 and ARM, 64-bit only).
- Linux (x86 and ARM, 64-bit and 32-bit).
  > - Binaries are statically linked and can run on any distribution if compiled
  >   on an old enough base distribution.
  > - Official binaries are compiled using the
  >   [Godot Engine buildroot](https://github.com/godotengine/buildroot),
  >   allowing for binaries that work across common Linux distributions.
- Android (editor support is experimental).
- [Web browsers](../tutorials/editor/using_the_web_editor.md#doc-using-the-web-editor). Experimental in 4.0,
  using Godot 3.x is recommended instead when targeting HTML5.

#### NOTE
Linux supports rv64 (RISC-V), ppc64 & ppc32 (PowerPC), and loongarch64. However
you must compile the editor for that platform (as well as export templates)
yourself, no official downloads are currently provided. RISC-V compiling
instructions can be found on the [Compiling for Linux, \*BSD](../engine_details/development/compiling/compiling_for_linuxbsd.md#doc-compiling-for-linuxbsd) page.

**Runs exported projects:**

- iOS.

Godot aims to be as platform-independent as possible and can be
[ported to new platforms](../engine_details/engine_api/custom_platform_ports.md#doc-custom-platform-ports) with relative ease.

#### NOTE
Projects written in C# using Godot 4 currently cannot be exported to the
web platform. To use C# on that platform, consider Godot 3 instead.
Android and iOS platform support is available as of Godot 4.2, but is
experimental and [some limitations apply](../tutorials/scripting/c_sharp/index.md#doc-c-sharp-platforms).

## Editor

**Features:**

- Scene tree editor.
- Built-in script editor.
- Support for [external script editors](../tutorials/editor/external_editor.md#doc-external-editor) such as
  Visual Studio Code or Vim.
- GDScript [debugger](../tutorials/scripting/debug/debugger_panel.md#doc-debugger-panel).
  > - Support for debugging in threads is available since 4.2.
- Visual profiler with CPU and GPU time indications for each step of the
  rendering pipeline.
- Performance monitoring tools, including
  [custom performance monitors](../tutorials/scripting/debug/custom_performance_monitors.md#doc-custom-performance-monitors).
- Live script reloading.
- Live scene editing.
  > - Changes will reflect in the editor and will be kept after closing the running project.
- Remote inspector.
  > - Changes won't reflect in the editor and won't be kept after closing the running project.
- Live camera replication.
  > - Move the in-editor camera and see the result in the running project.
- Built-in offline class reference documentation.
- Use the editor in dozens of languages contributed by the community.

**Plugins:**

- Editor plugins can be downloaded from the
  [asset library](../community/asset_library/what_is_assetlib.md#doc-what-is-assetlib) to extend editor functionality.
- [Create your own plugins](../tutorials/plugins/editor/making_plugins.md#doc-making-plugins) using GDScript to add new
  features or speed up your workflow.
- [Download projects from the asset library](../community/asset_library/using_assetlib.md#doc-using-assetlib-editor)
  in the Project Manager and import them directly.

## Rendering

Godot 4 includes three renderers:

- **Forward+**. The most advanced renderer, suited for desktop platforms only.
  Used by default on desktop platforms. This renderer uses **Vulkan**, **Direct3D 12**,
  or **Metal** as the rendering driver, and it uses the **RenderingDevice** backend.
- **Mobile**. Fewer features, but renders simple scenes faster. Suited for mobile
  and desktop platforms. Used by default on mobile platforms. This renderer uses
  **Vulkan**, **Direct3D 12**, or **Metal** as the rendering driver, and it uses
  the **RenderingDevice** backend.
- **Compatibility**, sometimes called **GL Compatibility**. The least advanced
  renderer, suited for low-end desktop and mobile platforms. Used by default on
  the web platform. This renderer uses **OpenGL** as the rendering driver.

See [Overview of renderers](../tutorials/rendering/renderers.md#doc-renderers) for a detailed comparison of the rendering methods.

## 2D graphics

- Sprite, polygon and line rendering.
  > - High-level tools to draw lines and polygons such as
  >   [Polygon2D](../classes/class_polygon2d.md#class-polygon2d) and [Line2D](../classes/class_line2d.md#class-line2d), with support for texturing.
- AnimatedSprite2D as a helper for creating animated sprites.
- Parallax layers.
  > - Pseudo-3D support including preview in the editor.
- [2D lighting](../tutorials/2d/2d_lights_and_shadows.md#doc-2d-lights-and-shadows) with normal maps and specular maps.
  > - Point (omni/spot) and directional 2D lights.
  > - Hard or soft shadows (adjustable on a per-light basis).
  > - Custom shaders can access a real-time 
  >   representation of the 2D scene based on [LightOccluder2D](../classes/class_lightoccluder2d.md#class-lightoccluder2d) nodes,
  >   which can be used for improved 2D lighting effects including 2D global illumination.
- [Font rendering](../tutorials/ui/gui_using_fonts.md#doc-gui-using-fonts) using bitmaps, rasterization using FreeType
  or multi-channel signed distance fields (MSDF).
  > - Bitmap fonts can be exported using tools like BMFont, or imported from images
  >   (for fixed-width fonts only).
  > - Dynamic fonts support monochrome fonts as well as colored fonts (e.g. for emoji).
  >   Supported formats are TTF, OTF, WOFF1 and WOFF2.
  > - Dynamic fonts support optional font outlines with adjustable width and color.
  > - Dynamic fonts support variable fonts and OpenType features including ligatures.
  > - Dynamic fonts support simulated bold and italic when the font file lacks
  >   those styles.
  > - Dynamic fonts support oversampling to keep fonts sharp at higher resolutions.
  > - Dynamic fonts support subpixel positioning to make fonts crisper at low sizes.
  > - Dynamic fonts support LCD subpixel optimizations to make fonts even crisper at low sizes.
  > - Signed distance field fonts can be scaled at any resolution without
  >   requiring re-rasterization. Multi-channel usage makes SDF fonts scale down
  >   to lower sizes better compared to monochrome SDF fonts.
- GPU-based [particles](../tutorials/2d/particle_systems_2d.md#doc-particle-systems-2d) with support for
  [custom particle shaders](../tutorials/shaders/shader_reference/particle_shader.md#doc-particle-shader).
- CPU-based particles.
- Optional [2D HDR rendering](../tutorials/3d/environment_and_post_processing.md#doc-environment-and-post-processing-using-glow-in-2d)
  for better glow capabilities.

## 2D tools

- [TileMaps](../tutorials/2d/using_tilemaps.md#doc-using-tilemaps) for 2D tile-based level design.
- 2D camera with built-in smoothing and drag margins.
- Path2D node to represent a path in 2D space.
  > - Can be drawn in the editor or generated procedurally.
  > - PathFollow2D node to make nodes follow a Path2D.
- [2D geometry helper class](../classes/class_geometry2d.md#class-geometry2d).

## 2D physics

**Physics bodies:**

- Static bodies.
- Animatable bodies (for objects moving only by script or animation, such as doors and platforms).
- Rigid bodies.
- Character bodies.
- Joints.
- Areas to detect bodies entering or leaving it.

**Collision detection:**

- Built-in shapes: line, box, circle, capsule, world boundary (infinite plane).
- Collision polygons (can be drawn manually or generated from a sprite in the editor).

## 3D graphics

- HDR rendering with sRGB.
- Perspective, orthographic and frustum-offset cameras.
- When using the Forward+ renderer, a depth prepass is used to improve
  performance in complex scenes by reducing the cost of overdraw.
- [Variable rate shading](../tutorials/3d/variable_rate_shading.md#doc-variable-rate-shading) on supported GPUs in Forward+ and Mobile.

**Physically-based rendering (built-in material features):**

- Follows the Disney PBR model.
- Supports Burley, Lambert, Lambert Wrap (half-Lambert) and Toon diffuse shading modes.
- Supports Schlick-GGX, Toon and Disabled specular shading modes.
- Uses a roughness-metallic workflow with support for ORM textures.
- Uses horizon specular occlusion (Filament model) to improve material appearance.
- Normal mapping.
- Parallax/relief mapping with automatic level of detail based on distance.
- Detail mapping for the albedo and normal maps.
- Sub-surface scattering and transmittance.
- Screen-space refraction with support for material roughness (resulting in blurry refraction).
- Proximity fade (soft particles) and distance fade.
- Distance fade can use alpha blending or dithering to avoid going through
  the transparent pipeline.
- Dithering can be determined on a per-pixel or per-object basis.

**Real-time lighting:**

- Directional lights (sun/moon). Up to 4 per scene.
- Omnidirectional lights.
- Spot lights with adjustable cone angle and attenuation.
- Specular, indirect light, and volumetric fog energy can be adjusted on a per-light basis.
- Adjustable light "size" for fake area lights (will also make shadows blurrier).
- Optional distance fade system to fade distant lights and their shadows, improving performance.
- When using the Forward+ renderer (default on desktop), lights are
  rendered with clustered forward optimizations to decrease their individual cost.
  Clustered rendering also lifts any limits on the number of lights that can be used on a mesh.
- When using the Mobile renderer, up to 8 omni lights and 8 spot lights can
  be displayed per mesh resource. Baked lighting can be used to overcome this limit
  if needed.

**Shadow mapping:**

- *DirectionalLight:* Orthogonal (fastest), PSSM 2-split and 4-split.
  Supports blending between splits.
- *OmniLight:* Dual paraboloid (fast) or cubemap (slower but more accurate).
  Supports colored projector textures in the form of panoramas.
- *SpotLight:* Single texture. Supports colored projector textures.
- Shadow normal offset bias and shadow pancaking to decrease the amount of
  visible shadow acne and peter-panning.
- -like shadow blur based on the
  light size and distance from the surface the shadow is cast on.
- Adjustable shadow blur on a per-light basis.

**Global illumination with indirect lighting:**

- [Baked lightmaps](../tutorials/3d/global_illumination/using_lightmap_gi.md#doc-using-lightmap-gi) (fast, but can't be updated at runtime).
  > - Supports baking indirect light only or baking both direct and indirect lighting.
  >   The bake mode can be adjusted on a per-light basis to allow for hybrid light
  >   baking setups.
  > - Supports lighting dynamic objects using automatic and manually placed probes.
  > - Optionally supports directional lighting and rough reflections based on spherical
  >   harmonics.
  > - Lightmaps are baked on the GPU using compute shaders (much faster compared
  >   to CPU lightmapping). Baking can only be performed from the editor,
  >   not in exported projects.
  > - Supports GPU-based [denoising](../tutorials/3d/global_illumination/using_lightmap_gi.md#doc-using-lightmap-gi-denoising)
  >   with JNLM, or CPU/GPU-based denoising with OIDN.
- [Voxel-based GI probes](../tutorials/3d/global_illumination/using_voxel_gi.md#doc-using-voxel-gi). Supports
  dynamic lights *and* dynamic occluders, while also supporting reflections.
  Requires a fast baking step which can be performed in the editor or at
  runtime (including from an exported project).
- [Signed-distance field GI](../tutorials/3d/global_illumination/using_sdfgi.md#doc-using-sdfgi) designed for large open worlds.
  Supports dynamic lights, but not dynamic occluders. Supports reflections.
  No baking required.
- [Screen-space indirect lighting (SSIL)](../tutorials/3d/environment_and_post_processing.md#doc-environment-and-post-processing-ssil)
  at half or full resolution. Fully real-time and supports any kind of emissive
  light source (including decals).
- VoxelGI and SDFGI use a deferred pass to allow for rendering GI at half
  resolution to improve performance (while still having functional MSAA support).

**Reflections:**

- Voxel-based reflections (when using GI probes) and SDF-based reflections
  (when using signed distance field GI). Voxel-based reflections are visible
  on transparent surfaces, while rough SDF-based reflections are visible
  on transparent surfaces.
- Fast baked reflections or slow real-time reflections using ReflectionProbe.
  Parallax box correction can optionally be enabled.
- Screen-space reflections with support for material roughness.
- Reflection techniques can be mixed together for greater accuracy or scalability.
- When using the Forward+ renderer (default on desktop), reflection probes are
  rendered with clustered forward optimizations to decrease their individual cost.
  Clustered rendering also lifts any limits on the number of reflection probes that can be used on a mesh.
- When using the Mobile renderer, up to 8 reflection probes can be displayed per mesh
  resource. When using the Compatibility renderer, up to 2 reflection probes can
  be displayed per mesh resource.

**Decals:**

- [Supports albedo](../tutorials/3d/using_decals.md#doc-using-decals), emissive, ,
  and normal mapping.
- Texture channels are smoothly overlaid on top of the underlying material,
  with support for normal/ORM-only decals.
- Support for normal fade to fade the decal depending on its incidence angle.
- Does not rely on runtime mesh generation. This means decals can be used on
  complex skinned meshes with no performance penalty, even if the decal moves every frame.
- Support for nearest, bilinear, trilinear or anisotropic texture filtering (configured globally).
- Optional distance fade system to fade distant decals, improving performance.
- When using the Forward+ renderer (default on desktop), decals are
  rendered with clustered forward optimizations to decrease their individual cost.
  Clustered rendering also lifts any limits on the number of decals that can be used on a mesh.
- When using the Mobile renderer, up to 8 decals can be displayed per mesh
  resource.

**Sky:**

- Panorama sky (using an HDRI).
- Procedural sky and Physically-based sky that respond to the DirectionalLights in the scene.
- Support for [custom sky shaders](../tutorials/shaders/shader_reference/sky_shader.md#doc-sky-shader), which can be animated.
- The radiance map used for ambient and specular light can be updated in
  real-time depending on the quality settings chosen.

**Fog:**

- Exponential depth fog.
- Exponential height fog.
- Support for automatic fog color depending on the sky color (aerial perspective).
- Support for sun scattering in the fog.
- Support for controlling how much fog rendering should affect the sky, with
  separate controls for traditional and volumetric fog.
- Support for making specific materials ignore fog.

**Volumetric fog:**

- Global [volumetric fog](../tutorials/3d/volumetric_fog.md#doc-volumetric-fog) that reacts to lights and shadows.
- Volumetric fog can take indirect light into account when using VoxelGI or SDFGI.
- Fog volume nodes that can be placed to add fog to specific areas (or remove fog from specific areas).
  Supported shapes include box, ellipse, cone, cylinder, and 3D texture-based density maps.
- Each fog volume can have its own custom shader.
- Can be used together with traditional fog.

**Particles:**

- GPU-based particles with support for subemitters (2D + 3D), trails (2D + 3D),
  attractors (3D only) and collision (2D + 3D).
  - 3D particle attractor shapes supported: box, sphere and 3D vector fields.
  - 3D particle collision shapes supported: box, sphere, baked signed distance field
    and real-time heightmap (suited for open world weather effects).
  - 2D particle collision is handled using a signed distance field generated in real-time
    based on [LightOccluder2D](../classes/class_lightoccluder2d.md#class-lightoccluder2d) nodes in the scene.
  - Trails can use the built-in ribbon trail and tube trail meshes, or custom
    meshes with skeletons.
  - Support for custom particle shaders with manual emission.
- CPU-based particles.

**Post-processing:**

- Tonemapping (Linear, Reinhard, Filmic, ACES, AgX).
- Automatic exposure adjustments based on viewport brightness (and manual exposure override).
- Near and far depth of field with adjustable bokeh simulation (box, hexagon, circle).
- Screen-space ambient occlusion (SSAO) at half or full resolution.
- Glow/bloom with optional bicubic upscaling and several blend modes available:
  Screen, Soft Light, Add, Replace, Mix.
- Glow can have a colored dirt map texture, acting as a lens dirt effect.
- Glow can be [used as a screen-space blur effect](../tutorials/3d/environment_and_post_processing.md#doc-environment-and-post-processing-using-glow-to-blur-the-screen).
- Color correction using a one-dimensional ramp or a 3D LUT texture.
- Roughness limiter to reduce the impact of specular aliasing.
- Brightness, contrast and saturation adjustments.

**Texture filtering:**

- Nearest, bilinear, trilinear or anisotropic filtering.
- Filtering options are defined on a per-use basis, not a per-texture basis.

**Texture compression:**

- Basis Universal (slow, but results in smaller files).
- BPTC for high-quality compression (not supported on macOS).
- ETC2 (not supported on macOS).
- S3TC (not supported on mobile/Web platforms).

**Antialiasing:**

- Temporal [antialiasing](../tutorials/3d/3d_antialiasing.md#doc-3d-antialiasing) (TAA).
- AMD FidelityFX Super Resolution 2.2 [antialiasing](../tutorials/3d/3d_antialiasing.md#doc-3d-antialiasing) (FSR2),
  which can be used at native resolution as a form of high-quality temporal antialiasing.
- Multi-sample antialiasing (MSAA), for both [2D antialiasing](../tutorials/2d/2d_antialiasing.md#doc-2d-antialiasing) and [3D antialiasing](../tutorials/3d/3d_antialiasing.md#doc-3d-antialiasing).
- Fast approximate antialiasing (FXAA).
- Super-sample antialiasing (SSAA) using bilinear 3D scaling and a 3D resolution scale above 1.0.
- Alpha antialiasing, MSAA alpha to coverage and alpha hashing on a per-material basis.

**Resolution scaling:**

- Support for [rendering 3D at a lower resolution](../tutorials/3d/resolution_scaling.md#doc-resolution-scaling)
  while keeping 2D rendering at the original scale. This can be used to improve
  performance on low-end systems or improve visuals on high-end systems.
- Resolution scaling uses bilinear filtering, AMD FidelityFX Super Resolution
  1.0 (FSR1) or AMD FidelityFX Super Resolution 2.2 (FSR2).
- Texture mipmap LOD bias is adjusted automatically to improve quality at lower
  resolution scales. It can also be modified with a manual offset.

Most effects listed above can be adjusted for better performance or to further
improve quality. This can be helpful when
[using Godot for offline rendering](../tutorials/animation/creating_movies.md#doc-creating-movies).

## 3D tools

- Built-in meshes: cube, cylinder/cone, (hemi)sphere, prism, plane, quad, torus, ribbon, tube.
- [GridMaps](../tutorials/3d/using_gridmaps.md#doc-using-gridmaps) for 3D tile-based level design.
- [Constructive solid geometry](../tutorials/3d/csg_tools.md#doc-csg-tools) (intended for prototyping).
- Tools for [procedural geometry generation](../tutorials/3d/procedural_geometry/index.md#doc-procedural-geometry).
- Path3D node to represent a path in 3D space.
  > - Can be drawn in the editor or generated procedurally.
  > - PathFollow3D node to make nodes follow a Path3D.
- [3D geometry helper class](../classes/class_geometry3d.md#class-geometry3d).
- Support for exporting the current scene as a glTF 2.0 file, both from the editor
  and at runtime from an exported project.

## 3D physics

**Physics bodies:**

- Static bodies.
- Animatable bodies (for objects moving only by script or animation, such as doors and platforms).
- Rigid bodies.
- Character bodies.
- Vehicle bodies (intended for arcade physics, not simulation).
- Joints.
- [Soft bodies](../tutorials/physics/soft_body.md#doc-soft-body).
- [Ragdolls](../tutorials/physics/ragdoll_system.md#doc-ragdoll-system).
- Areas to detect bodies entering or leaving it.

**Collision detection:**

- Built-in shapes: cuboid, sphere, capsule, cylinder, world boundary (infinite plane).
- Generate triangle collision shapes for any mesh from the editor.
- Generate one or several convex collision shapes for any mesh from the editor.

## Shaders

- *2D:* Custom vertex, fragment, and light shaders.
- *3D:* Custom vertex, fragment, light, and sky shaders.
- Text-based shaders using a [shader language inspired by GLSL](../tutorials/shaders/shader_reference/shading_language.md#doc-shading-language).
- Visual shader editor.
  > - Support for [visual shader plugins](../tutorials/plugins/editor/visual_shader_plugins.md#doc-visual-shader-plugins).

## Scripting

**General:**

- Object-oriented design pattern with scripts extending nodes.
- Signals and groups for communicating between scripts.
- Support for [cross-language scripting](../tutorials/scripting/cross_language_scripting.md#doc-cross-language-scripting).
- Many 2D, 3D and 4D linear algebra data types such as vectors and transforms.

[GDScript:](../tutorials/scripting/gdscript/index.md#doc-gdscript)

- [High-level interpreted language](../tutorials/scripting/gdscript/gdscript_basics.md#doc-gdscript-reference) with
  [optional static typing](../tutorials/scripting/gdscript/static_typing.md#doc-gdscript-static-typing).
- Syntax inspired by Python. However, GDScript is **not** based on Python.
- Syntax highlighting is provided on GitHub.
- [Use threads](../tutorials/performance/using_multiple_threads.md#doc-using-multiple-threads) to perform asynchronous actions
  or make use of multiple processor cores.

[C#:](../tutorials/scripting/c_sharp/index.md#doc-c-sharp)

- Packaged in a separate binary to keep file sizes and dependencies down.
- Supports .NET 8 and higher.
  > - Full support for the C# 12.0 syntax and features.
- Supports Windows, Linux, and macOS. Since Godot 4.2, experimental support for Android and iOS is also available.
  > - On the iOS platform only some architectures are supported: `arm64`.
  > - The web platform is currently unsupported. To use C# on that platform,
  >   consider Godot 3 instead.
- Using an external editor is recommended to benefit from IDE functionality.

**GDExtension (C, C++, Rust, D, ...):**

- When you need it, link to native libraries for higher performance and third-party integrations.
  > - For scripting game logic, GDScript or C# are recommended if their
  >   performance is suitable.
- Official GDExtension bindings for [C](https://github.com/godotengine/godot-headers)
  and [C++](https://github.com/godotengine/godot-cpp).
  > - Use any build system and language features you wish.
- Actively developed GDExtension bindings for [D](https://github.com/godot-dlang/godot-dlang),
  [Swift](https://github.com/migueldeicaza/SwiftGodot), and [Rust](https://github.com/godot-rust/gdextension)
  bindings provided by the community. (Some of these bindings may be experimental and not production-ready).

## Audio

**Features:**

- Mono, stereo, 5.1 and 7.1 output.
- Non-positional and positional playback in 2D and 3D.
  > - Optional Doppler effect in 2D and 3D.
- Support for re-routable [audio buses](../tutorials/audio/audio_buses.md#doc-audio-buses) and effects
  with dozens of effects included.
- Support for polyphony (playing several sounds from a single AudioStreamPlayer node).
- Support for random volume and pitch.
- Support for real-time pitch scaling.
- Support for sequential/random sample selection, including repetition prevention
  when using random sample selection.
- Listener2D and Listener3D nodes to listen from a position different than the camera.
- Support for [procedural audio generation](../classes/class_audiostreamgenerator.md#class-audiostreamgenerator).
- Audio input to record microphones.
- [Text to speech](../tutorials/audio/text_to_speech.md#doc-text-to-speech) using platform-provided TTS engines.
- MIDI input.
  > - No support for MIDI output yet.

**APIs used:**

- *Windows:* WASAPI.
- *macOS:* CoreAudio.
- *Linux:* PulseAudio or ALSA.

## Import

- Support for [custom import plugins](../tutorials/plugins/editor/import_plugins.md#doc-import-plugins).

**Formats:**

- *Images:* See [Importing images](../tutorials/assets_pipeline/importing_images.md#doc-importing-images).
- *Audio:*
  > - WAV with optional IMA-ADPCM compression.
  > - Ogg Vorbis.
  > - MP3.
- *3D scenes:* See [Importing 3D scenes](../tutorials/assets_pipeline/importing_3d_scenes/index.md#doc-importing-3d-scenes).
  > - glTF 2.0  *(recommended)*.
  > - `.blend` (by calling Blender's glTF export functionality transparently).
  > - FBX (by calling [FBX2glTF](https://github.com/godotengine/FBX2glTF) transparently).
  > - Collada (.dae).
  > - Wavefront OBJ (static scenes only, can be loaded directly as a mesh or imported as a 3D scene).
- Support for loading glTF 2.0 scenes at runtime, including from an exported project.
- 3D meshes use [Mikktspace](http://www.mikktspace.com/) to generate tangents
  on import, which ensures consistency with other 3D applications such as Blender.

## Input

- [Input mapping system](../tutorials/inputs/input_examples.md#doc-input-examples) using hardcoded input events
  or remappable input actions.
  > - Axis values can be mapped to two different actions with a configurable deadzone.
  > - Use the same code to support both keyboards and gamepads.
- Keyboard input.
  > - Keys can be mapped in "physical" mode to be independent of the keyboard layout.
- Mouse input.
  > - The mouse cursor can be visible, hidden, captured or confined within the window.
  > - When captured, raw input will be used on Windows and Linux to
  >   sidestep the OS' mouse acceleration settings.
- Gamepad input (up to 8 simultaneous controllers).
- Pen/tablet input with pressure support.

## Navigation

- A\* algorithm in [2D](../classes/class_astar2d.md#class-astar2d) and [3D](../classes/class_astar3d.md#class-astar3d).
- Navigation meshes with dynamic obstacle avoidance in
  [2D](../tutorials/navigation/navigation_introduction_2d.md#doc-navigation-overview-2d) and [3D](../tutorials/navigation/navigation_introduction_3d.md#doc-navigation-overview-3d).
- Generate navigation meshes from the editor or at runtime (including from an exported project).

## Networking

- Low-level TCP networking using [StreamPeer](../classes/class_streampeer.md#class-streampeer) and [TCPServer](../classes/class_tcpserver.md#class-tcpserver).
- Low-level UDP networking using [PacketPeer](../classes/class_packetpeer.md#class-packetpeer) and [UDPServer](../classes/class_udpserver.md#class-udpserver).
- Low-level HTTP requests using [HTTPClient](../classes/class_httpclient.md#class-httpclient).
- High-level HTTP requests using [HTTPRequest](../classes/class_httprequest.md#class-httprequest).
  > - Supports HTTPS out of the box using bundled certificates.
- [High-level multiplayer](../tutorials/networking/high_level_multiplayer.md#doc-high-level-multiplayer) API using UDP and ENet.
  > - Automatic replication using remote procedure calls (RPCs).
  > - Supports unreliable, reliable and ordered transfers.
- [WebSocket](../tutorials/networking/websocket.md#doc-websocket) client and server, available on all platforms.
- [WebRTC](../tutorials/networking/webrtc.md#doc-webrtc) client and server, available on all platforms.
- Support for [UPnP](../classes/class_upnp.md#class-upnp) to sidestep the requirement to forward ports
  when hosting a server behind a NAT.

## Internationalization

- Full support for Unicode including emoji.
- Support for loading system fonts on Windows, macOS, and Linux.
  - By default, system fonts are used as a fallback to display unsupported
    characters. This allows proper display of multilingual text without
    having to bundle large font files with a project.
- Store localization strings using [CSV](../tutorials/i18n/internationalizing_games.md#doc-internationalizing-games)
  or [gettext](../tutorials/i18n/localization_using_gettext.md#doc-localization-using-gettext).
  - Support for generating gettext POT and PO files from the editor.
- Use localized strings in your project automatically in GUI elements or by
  using the `tr()` function.
- Support for pluralization and translation contexts.
- Support for [bidirectional typesetting](../tutorials/i18n/internationalizing_games.md#doc-internationalizing-games-bidi),
  text shaping and OpenType localized forms.
- Automatic UI mirroring for right-to-left locales.
- Support for pseudolocalization to test your project for i18n-friendliness.

## Windowing and OS integration

- Spawn multiple independent windows within a single process.
- Move, resize, minimize, and maximize windows spawned by the project.
- Change the window title and icon.
- Create transparent windows to use as overlays, with polygon-based
  mouse passthrough support.
- Request attention (will cause the title bar to blink on most platforms).
- Fullscreen mode.
  > - Uses borderless fullscreen by default on Windows for fast alt-tabbing,
  >   but can optionally use exclusive fullscreen to reduce input lag.
- Borderless windows (fullscreen or non-fullscreen).
- Keep a window always on top.
- Make a window ignore focus (useful for overlays).
- Declare a window as a popup (hidden from task switcher)
  or exclusive (prevents interacting with other windows from the same process).
- Native file dialog support on Windows, macOS, Linux, and Android.
- Tray icon support on Windows and macOS.
- Global menu integration on macOS.
- Client-side decorations on macOS.
- Execute commands in a blocking or non-blocking manner (including running
  multiple instances of the same project).
- Open file paths and URLs using default or custom protocol handlers (if registered on the system).
- Parse custom command line arguments.
- Support for screen readers on Windows, macOS, and Linux.
- Any Godot binary (editor or exported project) can be
  [used as a headless server](../tutorials/export/exporting_for_dedicated_servers.md#doc-exporting-for-dedicated-servers)
  by starting it with the `--headless` command line argument.
  This allows running the engine without a GPU or display server.

#### SEE ALSO
See [Creating applications](../tutorials/ui/creating_applications.md#doc-creating-applications) for details on using these features.

## Mobile

- In-app purchases on [Android](../tutorials/platform/android/android_in_app_purchases.md#doc-android-in-app-purchases)
  and [iOS](../tutorials/platform/ios/plugins_for_ios.md#doc-plugins-for-ios).
- Support for advertisements using third-party modules.

<a id="doc-xr-support"></a>

## XR support (AR and VR)

- Out of the box [support for OpenXR](../tutorials/xr/setting_up_xr.md#doc-setting-up-xr).
  > - Including support for popular desktop headsets like the Valve Index, WMR headsets, and Quest over Link.
- Support for [Android-based headsets](../tutorials/xr/deploying_to_android.md#doc-deploying-to-android) using OpenXR through a plugin.
  - Including support for popular stand alone headsets like the Meta Quest 1/2/3 and Pro, Pico 4, Magic Leap 2, and Lynx R1.
- Out of the box limited support for visionOS Apple headsets.
  - Currently only exporting an application for use on a flat plane within the
    headset is supported. Immersive experiences are not supported.
- Other devices supported through an XR plugin structure.
- Various advanced toolkits are available that implement common features required by XR applications.

## GUI system

Godot's GUI is built using the same Control nodes used to make games in Godot.
The editor UI can easily be extended in many ways using add-ons.

**Nodes:**

- Buttons.
- Checkboxes, check buttons, radio buttons.
- Text entry using [LineEdit](../classes/class_lineedit.md#class-lineedit) (single line) and [TextEdit](../classes/class_textedit.md#class-textedit) (multiple lines).
  TextEdit also supports code editing features such as displaying line numbers
  and syntax highlighting.
- Dropdown menus using [PopupMenu](../classes/class_popupmenu.md#class-popupmenu) and [OptionButton](../classes/class_optionbutton.md#class-optionbutton).
- Scrollbars.
- Labels.
- RichTextLabel for [text formatted using BBCode](../tutorials/ui/bbcode_in_richtextlabel.md#doc-bbcode-in-richtextlabel),
  with support for animated custom effects.
- Trees (can also be used to represent tables).
- Color picker with RGB and HSV modes.
- Controls can be rotated and scaled.

**Sizing:**

- Anchors to keep GUI elements in a specific corner, edge or centered.
- Containers to place GUI elements automatically following certain rules.
  > - [Stack](../classes/class_boxcontainer.md#class-boxcontainer) layouts.
  > - [Grid](../classes/class_gridcontainer.md#class-gridcontainer) layouts.
  > - [Flow](../classes/class_flowcontainer.md#class-flowcontainer) layouts (similar to autowrapping text).
  > - [Margin](../classes/class_margincontainer.md#class-margincontainer), [centered](../classes/class_centercontainer.md#class-centercontainer)
  >   and [aspect ratio](../classes/class_aspectratiocontainer.md#class-aspectratiocontainer) layouts.
  > - [Draggable splitter](../classes/class_splitcontainer.md#class-splitcontainer) layouts.
- Scale to [multiple resolutions](../tutorials/rendering/multiple_resolutions.md#doc-multiple-resolutions) using the
  `canvas_items` or `viewport` stretch modes.
- Support any aspect ratio using anchors and the `expand` stretch aspect.

**Theming:**

- Built-in theme editor.
  > - Generate a theme based on the current editor theme settings.
- Procedural vector-based theming using [StyleBoxFlat](../classes/class_styleboxflat.md#class-styleboxflat).
  > - Supports rounded/beveled corners, drop shadows, per-border widths and antialiasing.
- Texture-based theming using [StyleBoxTexture](../classes/class_styleboxtexture.md#class-styleboxtexture).

Godot's small distribution size can make it a suitable alternative to frameworks
like Electron or Qt.

## Animation

- Direct kinematics and inverse kinematics.
- Support for animating any property with customizable interpolation.
- Support for calling methods in animation tracks.
- Support for playing sounds in animation tracks.
- Support for Bézier curves in animation.

## File formats

- Scenes and resources can be saved in [text-based](../engine_details/file_formats/tscn.md#doc-tscn-file-format) or binary formats.
  > - Text-based formats are human-readable and more friendly to version control.
  > - Binary formats are faster to save/load for large scenes/resources.
- Read and write text or binary files using [FileAccess](../classes/class_fileaccess.md#class-fileaccess).
  > - Can optionally be compressed or encrypted.
- Read and write [JSON](../classes/class_json.md#class-json) files.
- Read and write INI-style configuration files using [ConfigFile](../classes/class_configfile.md#class-configfile).
  > - Can (de)serialize any Godot datatype, including Vector2/3, Color, ...
- Read XML files using [XMLParser](../classes/class_xmlparser.md#class-xmlparser).
- [Load and save images, audio/video, fonts and ZIP archives](../tutorials/io/runtime_file_loading_and_saving.md#doc-runtime-loading-and-saving)
  in an exported project without having to go through Godot's import system.
- Pack game data into a PCK file (custom format optimized for fast seeking),
  into a ZIP archive, or directly into the executable for single-file distribution.
- [Export additional PCK files](../tutorials/export/exporting_pcks.md#doc-exporting-pcks) that can be read
  by the engine to support mods and DLCs.

## Miscellaneous

- [Video playback](../tutorials/animation/playing_videos.md#doc-playing-videos) with built-in support for Ogg Theora.
- [Movie Maker mode](../tutorials/animation/creating_movies.md#doc-creating-movies) to record videos from a running
  project with synchronized audio and perfect frame pacing.
- [Low-level access to servers](../tutorials/performance/using_servers.md#doc-using-servers) which allows bypassing
  the scene tree's overhead when needed.
- [Command line interface](../tutorials/editor/command_line_tutorial.md#doc-command-line-tutorial) for automation.
  > - Export and deploy projects using continuous integration platforms.
  > - [Shell completion scripts](https://github.com/godotengine/godot/tree/master/misc/dist/shell)
  >   are available for Bash, zsh and fish.
  > - Print colored text to standard output on all platforms using
  >   [print_rich](../classes/class_@globalscope.md#class-globalscope-method-print-rich).
- The editor can
  [detect features used in a project and create a compilation profile](../tutorials/editor/using_engine_compilation_configuration_editor.md#doc-engine-compilation-configuration-editor),
  which can be used to create smaller export template binaries
  with unneeded features disabled.
- Support for [C++ modules](../engine_details/engine_api/custom_modules_in_cpp.md#doc-custom-modules-in-cpp) statically linked
  into the engine binary.
  - Most built-in modules can be disabled at compile-time to reduce binary size
    in custom builds. See [Optimizing a build for size](../engine_details/development/compiling/optimizing_for_size.md#doc-optimizing-for-size) for details.
- Engine and editor written in C++17.
  > - Can be [compiled](../engine_details/development/compiling/introduction_to_the_buildsystem.md#doc-introduction-to-the-buildsystem) using GCC,
  >   Clang and MSVC. MinGW is also supported.
  > - Friendly towards packagers. In most cases, system libraries can be used
  >   instead of the ones provided by Godot. The build system doesn't download anything.
  >   Builds can be fully reproducible.
- Licensed under the permissive MIT license.
  > - Open development process with [contributions welcome](https://contributing.godotengine.org/en/latest/organization/how_to_contribute.html).

#### SEE ALSO
The [Godot proposals repository](https://github.com/godotengine/godot-proposals)
lists features that have been requested by the community and may be implemented
in future Godot releases.
