<a id="doc-fog-shader"></a>

# Fog shaders

Fog shaders are used to define how fog is added to (or subtracted from) a scene in
a given area. Fog shaders are always used together with
[FogVolumes](../../../classes/class_fogvolume.md#class-fogvolume) and volumetric fog. Fog shaders only have
one processing function, the `fog()` function.

The resolution of the fog shaders depends on the resolution of the
volumetric fog froxel grid. Accordingly, the level of detail that a fog shader
can add depends on how close the [FogVolume](../../../classes/class_fogvolume.md#class-fogvolume) is to the
camera.

Fog shaders are a special form of compute shader that is called once for
every froxel that is touched by an axis-aligned bounding box of the associated
[FogVolume](../../../classes/class_fogvolume.md#class-fogvolume). This means that froxels that just barely
touch a given [FogVolume](../../../classes/class_fogvolume.md#class-fogvolume) will still be used.

## Built-ins

Values marked as `in` are read-only. Values marked as `out` can optionally
be written to and will not necessarily contain sensible values. Samplers cannot
be written to so they are not marked.

## Global built-ins

Global built-ins are available everywhere, including in custom functions.

| Built-in          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| in float **TIME** | Global time since the engine has started, in seconds. It repeats after every `3,600`<br/>seconds (which can be changed with the<br/>[rollover](../../../classes/class_projectsettings.md#class-projectsettings-property-rendering-limits-time-time-rollover-secs)<br/>setting). It's affected by<br/>[time_scale](../../../classes/class_engine.md#class-engine-property-time-scale) but not by pausing. If you need a<br/>`TIME` variable that is not affected by time scale, add your own<br/>[global shader uniform](shading_language.md#doc-shading-language-global-uniforms) and update it each<br/>frame. |
| in float **PI**   | A `PI` constant (`3.141592`).<br/>The ratio of a circle's circumference to its diameter and the number of radians in a half turn.                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| in float **TAU**  | A `TAU` constant (`6.283185`).<br/>Equivalent to `PI * 2` and the number of radians in a full turn.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| in float **E**    | An `E` constant (`2.718281`).<br/>Euler's number, the base of the natural logarithm.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |

## Fog built-ins

All of the output values of fog volumes overlap one another. This allows
[FogVolumes](../../../classes/class_fogvolume.md#class-fogvolume) to be rendered efficiently as they can all
be drawn at once.

| Built-in                    | Description                                                                                                                                                                               |
|-----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| in vec3 **WORLD_POSITION**  | Position of current froxel cell in world space.                                                                                                                                           |
| in vec3 **OBJECT_POSITION** | Position of the center of the current [FogVolume](../../../classes/class_fogvolume.md#class-fogvolume) in world space.                                                                    |
| in vec3 **UVW**             | 3-dimensional UV, used to map a 3D texture to the current [FogVolume](../../../classes/class_fogvolume.md#class-fogvolume).                                                               |
| in vec3 **SIZE**            | Size of the current [FogVolume](../../../classes/class_fogvolume.md#class-fogvolume) when its<br/>[shape](../../../classes/class_fogvolume.md#class-fogvolume-property-shape) has a size. |
| in vec3 **SDF**             | Signed distance field to the surface of the [FogVolume](../../../classes/class_fogvolume.md#class-fogvolume). Negative if<br/>inside volume, positive otherwise.                          |
| out vec3 **ALBEDO**         | Output base color value, interacts with light to produce final color. Only written to fog<br/>volume if used.                                                                             |
| out float **DENSITY**       | Output density value. Can be negative to allow subtracting one volume from another. Density<br/>must be used for fog shader to write anything at all.                                     |
| out vec3 **EMISSION**       | Output emission color value, added to color during light pass to produce final color. Only<br/>written to fog volume if used.                                                             |
