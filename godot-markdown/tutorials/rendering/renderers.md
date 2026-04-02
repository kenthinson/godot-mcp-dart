<a id="doc-renderers"></a>

# Overview of renderers

#### SEE ALSO
This page gives an overview of Godot's renderers, focusing on the differences
between their rendering features. For more technical details on the renderers,
see [Internal rendering architecture](../../engine_details/architecture/internal_rendering_architecture.md#doc-internal-rendering-architecture).

## Introduction

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

### Renderers, rendering drivers, and RenderingDevice

![Diagram of rendering layers. The Compatibility renderer runs on the OpenGL
driver. The Forward+ and Mobile renderers run on RenderingDevice, which can use
Vulkan, Direct3D 12, or Metal as a rendering driver.](tutorials/rendering/img/renderers_rendering_layers.webp)

The *renderer*, or *rendering method*, determines which features are available.
Most of the time, this is the only thing you need to think about. Godot's renderers
are **Forward+**, **Mobile**, and **Compatibility**.

The *rendering driver* tells the GPU what to do, using a graphics API. Godot can
use the **OpenGL**, **Vulkan**, **Direct3D 12**, and **Metal** rendering drivers.
Not every GPU supports every rendering driver, and therefore not every GPU supports
all renderers. Vulkan, Direct3D 12, and Metal are modern, low-level graphics APIs,
and requires newer hardware. OpenGL is an older graphics API that runs on most hardware.

RenderingDevice is a *rendering backend*, an abstraction layer between the renderer
and the rendering driver. It is used by the Forward+ and Mobile renderers, and
these renderers are sometimes called "RenderingDevice-based renderers".

## Choosing a renderer

Choosing a renderer is a complex question, and depends on your hardware and the
which platforms you are developing for. As a starting point:

Choose **Forward+** if:

> - You are developing for desktop.
> - You have relatively new hardware which supports Vulkan, Direct3D 12, or Metal.
> - You are developing a 3D game.
> - You want to use the most advanced rendering features.

Choose **Mobile** if:

> - You are developing for newer mobile devices, desktop XR, or desktop.
> - You have relatively new hardware which supports Vulkan, Direct3D 12, or Metal.
> - You are developing a 3D game.
> - You want to use advanced rendering features, subject to the limitations
>   of mobile hardware.

Choose **Compatibility** if:

> - You are developing for older mobile devices, older desktop devices, or
>   standalone XR. The Compatibility renderer supports the widest range of hardware.
> - You are developing for web. In this case, Compatibility is the only choice.
> - You have older hardware which does not support Vulkan. In this case,
>   Compatibility is the only choice.
> - You are developing a 2D game, or a 3D game which does not need advanced
>   rendering features.
> - You want the best performance possible on all devices and don't need advanced
>   rendering features.

Keep in mind every game is unique, and this is only a starting point. For example,
you might choose to use the Compatibility renderer even though you have the latest
GPU, so you can support the widest range of hardware. Or you might want to use the
Forward+ renderer for a 2D game, so you can use advanced features like compute shaders.

### Switching between renderers

In the editor, you can always switch between renderers by clicking on the renderer
name in the upper-right corner of the editor.

Switching between renderers may require some manual tweaks to your scene, lighting,
and environment, since each renderer is different. In general, switching between
the Mobile and Forward+ renderers will require fewer adjustments than switching
between the Compatibility renderer and the Forward+ or Mobile renderers.

Since Godot 4.4, when using Forward+ or Mobile, if Vulkan is not supported, the
engine will fall back to Direct3D 12 and vice versa. If the attempted fallback
driver is not supported either, the engine will then fall back to Compatibility
when the RenderingDevice backend is not supported. This allows the project to run
anyway, but it may look different than the intended appearance due to the more
limited renderer. This behavior can be disabled in the project settings by unchecking
[Rendering > Rendering Device > Fallback to OpenGL 3](../../classes/class_projectsettings.md#class-projectsettings-property-rendering-rendering-device-fallback-to-opengl3).

## Feature comparison

This is not a complete list of the features of each renderer. If a feature is
not listed here, it is available in all renderers, though it may be much faster
on some renderers. For a list of *all* features in Godot, see [List of features](../../about/list_of_features.md#doc-list-of-features).

Hardware with RenderingDevice support is hardware which can run Vulkan, Direct3D
12, or Metal.

### Overall comparison

<!-- Note that these tables use emojis, which are not monospaced in most editors. -->
<!-- The tables look malformed but are not. When making changes, check the nearby -->
<!-- lines for guidance. -->

| Feature                                                      | Compatibility                                                                                                            | Mobile                                                                                                                 | Forward+                                                                                                                  |
|--------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| **Required**<br/>**hardware**                                | Older or low-end.                                                                                                        | Newer or high-end.<br/>Requires Vulkan, Direct3D<br/>12, or Metal support.                                             | Newer or high-end.<br/>Requires Vulkan, Direct3D<br/>12, or Metal support.                                                |
| Runs on new hardware                                         | ✔️ Yes.                                                                                                                  | ✔️ Yes.                                                                                                                | ✔️ Yes.                                                                                                                   |
| Runs on old and<br/>low-end hardware                         | ✔️ Yes.                                                                                                                  | ✔️ Yes, but slower than<br/>Compatibility.                                                                             | ✔️ Yes, but slowest of<br/>all renderers.                                                                                 |
| Runs on hardware<br/>without<br/>RenderingDevice<br/>support | ✔️ Yes.                                                                                                                  | ❌ No.                                                                                                                  | ❌ No.                                                                                                                     |
| **Target platforms**                                         | Mobile, low-end desktop,<br/>web.                                                                                        | Mobile, desktop.                                                                                                       | Desktop.                                                                                                                  |
| Desktop                                                      | ✔️ Yes.                                                                                                                  | ✔️ Yes.                                                                                                                | ✔️ Yes.                                                                                                                   |
| Mobile                                                       | ✔️ Yes (low-end).                                                                                                        | ✔️ Yes (high-end).                                                                                                     | ⚠️ Supported, but poorly<br/>optimized. Use Mobile or<br/>Compatibility instead.                                          |
| XR                                                           | ✔️ Yes. Recommended for<br/>standalone headsets.                                                                         | ✔️ Yes. Recommended for<br/>desktop headsets.                                                                          | ⚠️ Supported, but poorly<br/>optimized. Use Mobile or<br/>Compatibility instead.                                          |
| Web                                                          | ✔️ Yes.                                                                                                                  | ❌ No.                                                                                                                  | ❌ No.                                                                                                                     |
| 2D Games                                                     | ✔️ Yes.                                                                                                                  | ✔️ Yes, but<br/>Compatibility is usually<br/>good enough for 2D.                                                       | ✔️ Yes, but<br/>Compatibility is usually<br/>good enough for 2D.                                                          |
| 3D Games                                                     | ✔️ Yes.                                                                                                                  | ✔️ Yes.                                                                                                                | ✔️ Yes.                                                                                                                   |
| **Feature set**                                              | 2D and core 3D features.                                                                                                 | Most rendering features.                                                                                               | All rendering features.                                                                                                   |
| 2D rendering<br/>features                                    | ✔️ Yes.                                                                                                                  | ✔️ Yes.                                                                                                                | ✔️ Yes.                                                                                                                   |
| Core 3D rendering<br/>features                               | ✔️ Yes.                                                                                                                  | ✔️ Yes.                                                                                                                | ✔️ Yes.                                                                                                                   |
| Advanced<br/>rendering features                              | ❌ No.                                                                                                                    | ⚠️ Yes, limited by<br/>mobile hardware.                                                                                | ✔️ Yes. All rendering<br/>features are supported.                                                                         |
| New features                                                 | ⚠️ Some new rendering<br/>features are added to<br/>Compatibility. Features<br/>are added after Mobile<br/>and Forward+. | ✔️ Most new rendering<br/>features are added to<br/>Mobile. Mobile usually<br/>gets new features as<br/>Forward+ does. | ✔️ All new features are<br/>added to Forward+. As the<br/>focus of new development,<br/>Forward+ gets features<br/>first. |
| Rendering cost                                               | Low base cost, but<br/>high scaling cost.                                                                                | Medium base cost, and<br/>medium scaling cost.                                                                         | Highest base cost, and<br/>low scaling cost.                                                                              |
| Rendering driver                                             | OpenGL.                                                                                                                  | Vulkan, Direct3D 12, or<br/>Metal.                                                                                     | Vulkan, Direct3D 12, or<br/>Metal.                                                                                        |

### Lights and shadows

See [3D lights and shadows](../3d/lights_and_shadows.md#doc-lights-and-shadows) for more information.

| Feature                              | Compatibility                     | Mobile                    | Forward+                               |
|--------------------------------------|-----------------------------------|---------------------------|----------------------------------------|
| Lighting approach                    | Forward                           | Forward                   | Clustered Forward                      |
| Maximum<br/>OmniLights               | 8 per mesh. Can be<br/>increased. | 8 per mesh, 256 per view. | 512 per cluster. Can be<br/>increased. |
| Maximum<br/>SpotLights               | 8 per mesh. Can be<br/>increased. | 8 per mesh, 256 per view. | 512 per cluster. Can be<br/>increased. |
| Maximum<br/>DirectionalLights        | 8                                 | 8                         | 8                                      |
| PCSS for<br/>OmniLight and SpotLight | ❌ Not supported.                  | ✔️ Supported.             | ✔️ Supported.                          |
| PCSS for<br/>DirectionalLight        | ❌ Not supported.                  | ❌ Not supported.          | ✔️ Supported.                          |
| Light projector<br/>textures         | ❌ Not supported.                  | ✔️ Supported.             | ✔️ Supported.                          |

### Global Illumination

See [Introduction to global illumination](../3d/global_illumination/introduction_to_global_illumination.md#doc-introduction-to-global-illumination) for more information.

| Feature                                                   | Compatibility                                                                                                        | Mobile                        | Forward+                 |
|-----------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|-------------------------------|--------------------------|
| ReflectionProbe                                           | ✔️ Supported, 2 per<br/>mesh.                                                                                        | ✔️ Supported, 8 per<br/>mesh. | ✔️ Supported, unlimited. |
| LightmapGI                                                | ⚠️ Rendering of baked<br/>lightmaps is supported.<br/>Baking requires hardware<br/>with RenderingDevice<br/>support. | ✔️ Supported.                 | ✔️ Supported.            |
| VoxelGI                                                   | ❌ Not supported.                                                                                                     | ❌ Not supported.              | ✔️ Supported.            |
| Screen-Space<br/>Indirect Lighting (SSIL)                 | ❌ Not supported.                                                                                                     | ❌ Not supported.              | ✔️ Supported.            |
| Signed Distance Field<br/>Global Illumination<br/>(SDFGI) | ❌ Not supported.                                                                                                     | ❌ Not supported.              | ✔️ Supported.            |

### Environment and post-processing

See [Environment and post-processing](../3d/environment_and_post_processing.md#doc-environment-and-post-processing) for more information.

| Feature                                                   | Compatibility    | Mobile           | Forward+      |
|-----------------------------------------------------------|------------------|------------------|---------------|
| Fog (Depth and Height)                                    | ✔️ Supported.    | ✔️ Supported.    | ✔️ Supported. |
| Volumetric Fog                                            | ❌ Not supported. | ❌ Not supported. | ✔️ Supported. |
| Tonemapping                                               | ✔️ Supported.    | ✔️ Supported.    | ✔️ Supported. |
| Screen-Space Reflections                                  | ❌ Not supported. | ❌ Not supported. | ✔️ Supported. |
| Screen-Space Ambient<br/>Occlusion (SSAO)                 | ✔️ Supported.    | ❌ Not supported. | ✔️ Supported. |
| Screen-Space<br/>Indirect Lighting (SSIL)                 | ❌ Not supported. | ❌ Not supported. | ✔️ Supported. |
| Signed Distance Field<br/>Global Illumination<br/>(SDFGI) | ❌ Not supported. | ❌ Not supported. | ✔️ Supported. |
| Glow                                                      | ✔️ Supported.    | ✔️ Supported.    | ✔️ Supported. |
| Adjustments                                               | ✔️ Supported.    | ✔️ Supported.    | ✔️ Supported. |
| Custom post-processing<br/>with fullscreen quad           | ✔️ Supported.    | ✔️ Supported.    | ✔️ Supported. |
| Custom post-processing<br/>with CompositorEffects         | ❌ Not supported. | ✔️ Supported.    | ✔️ Supported. |

### Antialiasing

See [3D antialiasing](../3d/3d_antialiasing.md#doc-3d-antialiasing) for more information.

| Feature                            | Compatibility    | Mobile           | Forward+      |
|------------------------------------|------------------|------------------|---------------|
| MSAA 3D                            | ✔️ Supported.    | ✔️ Supported.    | ✔️ Supported. |
| MSAA 2D                            | ❌ Not supported. | ✔️ Supported.    | ✔️ Supported. |
| TAA                                | ❌ Not supported. | ❌ Not supported. | ✔️ Supported. |
| FSR2                               | ❌ Not supported. | ❌ Not supported. | ✔️ Supported. |
| FXAA                               | ❌ Not supported. | ✔️ Supported.    | ✔️ Supported. |
| SSAA                               | ✔️ Supported.    | ✔️ Supported.    | ✔️ Supported. |
| Screen-space<br/>roughness limiter | ❌ Not supported. | ✔️ Supported.    | ✔️ Supported. |

### StandardMaterial features

See [Standard Material 3D and ORM Material 3D](../3d/standard_material_3d.md#doc-standard-material-3d) for more information.

| Feature                | Compatibility    | Mobile           | Forward+      |
|------------------------|------------------|------------------|---------------|
| Sub-surface scattering | ❌ Not supported. | ❌ Not supported. | ✔️ Supported. |

### Shader features

See [Shading reference](../shaders/shader_reference/index.md#doc-shading-reference) for more information.

| Feature                 | Compatibility    | Mobile                                                                       | Forward+      |
|-------------------------|------------------|------------------------------------------------------------------------------|---------------|
| Screen texture          | ✔️ Supported.    | ✔️ Supported.                                                                | ✔️ Supported. |
| Depth texture           | ✔️ Supported.    | ✔️ Supported.                                                                | ✔️ Supported. |
| Normal/Roughness buffer | ❌ Not supported. | ❌ Not supported.                                                             | ✔️ Supported. |
| Compute shaders         | ❌ Not supported. | ⚠️ Supported, but comes<br/>with a performance<br/>penalty on older devices. | ✔️ Supported. |

### Other features

| Feature                              | Compatibility    | Mobile        | Forward+      |
|--------------------------------------|------------------|---------------|---------------|
| Variable rate<br/>shading            | ❌ Not supported. | ✔️ Supported. | ✔️ Supported. |
| Decals                               | ❌ Not supported. | ✔️ Supported. | ✔️ Supported. |
| Particle trails                      | ❌ Not supported. | ✔️ Supported. | ✔️ Supported. |
| Particle SDF collision               | ❌ Not supported. | ✔️ Supported. | ✔️ Supported. |
| Depth of field blur                  | ❌ Not supported. | ✔️ Supported. | ✔️ Supported. |
| Adaptive and Mailbox<br/>VSync modes | ❌ Not supported. | ✔️ Supported. | ✔️ Supported. |
| 2D HDR Viewport                      | ❌ Not supported. | ✔️ Supported. | ✔️ Supported. |
| RenderingDevice<br/>access           | ❌ Not supported. | ✔️ Supported. | ✔️ Supported. |
