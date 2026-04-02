<a id="doc-using-tilemaps"></a>

# Using TileMaps

#### SEE ALSO
This page assumes you have created or downloaded a TileSet already. If not,
please read [Using TileSets](using_tilesets.md#doc-using-tilesets) first as you will need a TileSet
to create a TileMap.

## Introduction

A tilemap is a grid of tiles used to create a game's layout. There are several
benefits to using [TileMapLayer](../../classes/class_tilemaplayer.md#class-tilemaplayer) nodes to design your levels.
First, they make it possible to draw the layout by "painting" the tiles onto a
grid, which is much faster than placing individual [Sprite2D](../../classes/class_sprite2d.md#class-sprite2d)
nodes one by one. Second, they allow for much larger levels because they are
optimized for drawing large numbers of tiles. Finally, you can add collision,
occlusion, and navigation shapes to tiles, adding greater functionality to
the TileMap.

## Specifying the TileSet in the TileMapLayer

If you've followed the previous page on [Using TileSets](using_tilesets.md#doc-using-tilesets), you should
have a TileSet resource that is built into the TileMapLayer node. This is good for
prototyping, but in a real world project, you will generally have multiple
levels reusing the same tileset.

The recommended way to reuse the same TileSet in several TileMapLayer nodes is to save
the TileSet to an external resource. To do so, click the dropdown next to the TileSet
resource and choose **Save**:

![Saving the built-in TileSet resource to an external resource file](tutorials/2d/img/using_tilemaps_save_tileset_to_resource.webp)

## Multiple TileMapLayers and settings

When working with tilemaps it's generally advised that you use multiple TileMapLayer
nodes when appropriate. Using multiple layers can be advantageous, for example,
this allows you to distinguish foreground tiles from background tiles for better
organization. You can place one tile per layer at a given location, which allows you
to overlap several tiles together if you have more than one layer.

Each TileMapLayer node has several properties you can adjust:

- **Enabled:** If `true`, the layer is visible in the editor and when running
  the project.
- **TileSet** The tileset used by the TileMapLayer node.

### Rendering

- **Y Sort Origin:** The vertical offset to use for Y-sorting on each tile (in pixels).
  Only effective if **Y Sort Enabled** under CanvasItem settings is `true`.
- **X Draw Order Reversed** Reverses the order tiles are drawn on the X axis. Requires
  that **Y Sort Enabled** under CanvasItem settings is `true`.
- **Rendering Quadrant Size** A quadrant is a group of tiles drawn together on a single
  CanvasItem for optimization purposes. This setting defines the length of a square's
  side in the map's coordinate system. The quadrant size does not apply to a Y sorted
  TileMapLayer since tiles are grouped by Y position in that case.

### Physics

- **Collision Enabled** Enables or disables collision.
- **Use Kinematic Bodies** When true TileMapLayer collision shapes will be instantiated
  as kinematic bodies.
- **Collision Visibility Mode** Whether or not the TileMapLayer's collision shapes are
  visible. If set to default, then it depends on the show collision debug settings.

### Navigation

- **Navigation Enabled** Whether or not navigation regions are enabled.
- **Navigation Visible** Whether or not the TileMapLayer's navigation meshes are
  visible. If set to default then it depends on the show navigation debug settings.

#### WARNING
2D navigation meshes can not be "layered" or stacked on top of each other like visuals or physic shapes. Attempting to stack navigation meshes on the same navigation map will result in merge and logical errors that break the pathfinding.

### Reordering layers

You can reorder layers by drag-and-dropping their node in the Scene tab. You can
also switch between which TileMapLayer node you're working on by using the buttons
in the top right corner of the TileMap editor.

#### NOTE
You can create, rename or reorder layers in the future without affecting
existing tiles. Be careful though, as *removing* a layer will also remove
all tiles that were placed on the layer.

## Opening the TileMap editor

Select the TileMapLayer node, then open the TileMap panel at the bottom
of the editor:

![Opening the TileMap panel at the bottom of the editor. The TileMapLayer node must be selected first.](tutorials/2d/img/using_tilemaps_open_tilemap_editor.webp)

## Selecting tiles to use for painting

First, if you've created additional layers above, make sure you've selected the
layer you wish to paint on:

![Selecting a layer to paint on in the TileMap editor](tutorials/2d/img/using_tilemaps_select_layer.webp)

You can skip the above step if you haven't created additional layers, as the
first layer is automatically selected when entering the TileMap editor.

Before you can place tiles in the 2D editor, you must select one or more tiles
in the TileMap panel located at the bottom of the editor. To do so, click a tile
in the TileMap panel, or hold down the mouse button to select multiple tiles:

![Selecting a tile in the TileMap editor by clicking it](tutorials/2d/img/using_tilemaps_select_single_tile_from_tileset.webp)

You can also hold down `Shift` to append to the current selection. When
selecting more than one tile, multiple tiles will be placed every time you
perform a painting operation. This can be used to paint structures composed of
multiple tiles in a single click (such as large platforms or trees).

The final selection does not have to be contiguous: if there is empty space
between selected tiles, it will be left empty in the pattern that will be
painted in the 2D editor.

![Selecting multiple tiles in the TileMap editor by holding down the left mouse button](tutorials/2d/img/using_tilemaps_select_multiple_tiles_from_tileset.webp)

If you've created alternative tiles in your TileSet, you can select them for
painting on the right of the base tiles:

![Selecting an alternative tile in the TileMap editor](tutorials/2d/img/using_tilemaps_use_alternative_tile.webp)

Lastly, if you've created a *scenes collection* in the TileSet, you can place scene tiles in the TileMap:

![Placing a scene tile containing particles using the TileMap editor](tutorials/2d/img/using_tilemaps_placing_scene_tiles.webp)

## Painting modes and tools

Using the toolbar at the top of the TileMap editor, you can choose between
several painting modes and tools. These modes affect operation when clicking in
the 2D editor, **not** the TileMap panel itself.

From left to right, the painting modes and tools you can choose are:

### Selection

Select tiles by clicking a single tile, or by holding down the left mouse button to
select multiple with a rectangle in the 2D editor. Note that empty space cannot be
selected: if you create a rectangle selection, only non-empty tiles will be selected.

To append to the current selection, hold `Shift` then select a tile.
To remove from the current selection, hold `Ctrl` then select a tile.

The selection can then be used in any other painting mode to quickly create copies
of an already-placed pattern.

You can remove the selected tiles from the TileMap by pressing `Del`.

You can toggle this mode temporarily while in Paint mode by holding `Ctrl`
then performing a selection.

### Paint

The standard Paint mode allows you to place tiles by clicking or holding
down the left mouse button.

If you right-click, the currently selected tile will be erased from the tilemap.
In other words, it will be replaced by empty space.

If you have selected multiple tiles in the TileMap or using the Selection tool,
they will be placed every time you click or drag the mouse while holding down
the left mouse button.

### Line

After selecting Line Paint mode, you can draw in a line that is
always 1 tile thick (no matter its orientation).

If you right-click while in Line Paint mode, you will erase in a line.

If you have selected multiple tiles in the TileMap or using the Selection tool,
you can place them in a repeating pattern across the line.

You can toggle this mode temporarily while in Paint or Eraser mode by holding
`Shift` then drawing.

![Using the line tool after selecting two tiles to draw platforms diagonally](tutorials/2d/img/using_tilesets_line_tool_multiple_tiles.webp)

### Rectangle

After selecting Rectangle Paint mode, you can draw in an axis-aligned
rectangle.

If you right-click while in Rectangle Paint mode, you will erase in
an axis-aligned rectangle.

If you have selected multiple tiles in the TileMap or using the Selection tool,
you can place them in a repeating pattern within the rectangle.

You can toggle this mode temporarily while in Paint or Eraser mode by holding
`Ctrl` and `Shift` then drawing.

### Bucket Fill

After selecting Bucket Fill mode, you can choose whether painting should be
limited to contiguous areas only by toggling the **Contiguous** checkbox that
appears on the right of the toolbar.

If you enable **Contiguous** (the default), only matching tiles that touch the
current selection will be replaced. This contiguous check is performed
horizontally and vertically, but *not* diagonally.

If you disable **Contiguous**, all tiles with the same ID in the entire TileMap will
be replaced by the currently selected tile. If selecting an empty tile with
**Contiguous** unchecked, all tiles in the rectangle that encompasses the
TileMap's effective area will be replaced instead.

If you right-click while in Bucket Fill mode, you will replace matching tiles
with empty tiles.

If you have selected multiple tiles in the TileMap or using the Selection tool,
you can place them in a repeating pattern within the filled area.

![Using the Bucket Fill tool](tutorials/2d/img/using_tilemaps_bucket_fill.webp)

### Picker

After selecting Picker mode, you can pick existing tiles in the 2D editor by
holding `Ctrl` then clicking on a tile. This will switch the currently
painted tile to the tile you've just clicked. You can also pick multiple tiles
at once by holding down the left mouse button and forming a rectangle selection.
Only non-empty tiles can be picked.

You can toggle this mode temporarily while in Paint mode by holding `Ctrl`
then clicking or dragging the mouse.

### Eraser

This mode is combined with any other painting mode (Paint, Line, Rectangle,
Bucket Fill). When eraser mode is enabled, tiles will be replaced by empty tiles
instead of drawing new lines when left-clicking.

You can toggle this mode temporarily while in any other mode by right-clicking
instead of left-clicking.

## Painting randomly using scattering

While painting, you can optionally enable *randomization*. When enabled,
a random tile will be chosen between all the currently selected tiles when
painting. This is supported with the Paint, Line, Rectangle and Bucket Fill
tools. For effective paint randomization, you must select multiple tiles
in the TileMap editor or use scattering (both approaches can be combined).

If **Scattering** is set to a value greater than 0, there is a chance that no tile
will be placed when painting. This can be used to add occasional, non-repeating
detail to large areas (such as adding grass or crumbs on a large top-down
TileMap).

Example when using Paint mode:

![Selecting from several times to randomly choose, then painting by holding down the left mouse button](tutorials/2d/img/using_tilemaps_scatter_tiles.webp)

Example when using Bucket Fill mode:

![Using Bucket Fill tool with a single tile, but with randomization and scattering enabled](tutorials/2d/img/using_tilemaps_bucket_fill_scatter.webp)

#### NOTE
Eraser mode does not take randomization and scattering into account.
All tiles within the selection are always removed.

## Saving and loading premade tile placements using patterns

While you can copy and paste tiles while in Select mode, you may wish to save
premade *patterns* of tiles to place together in a go. This can be done on a
per-TileMap basis by choosing the **Patterns** tab of the TileMap editor.

To create a new pattern, switch to Select mode, perform a selection and press
`Ctrl + C`. Click on empty space within the Patterns tab (a blue focus
rectangle should appear around the empty space), then press `Ctrl + V`:

![Creating a new pattern from a selection in the TileMap editor](tutorials/2d/img/using_tilemaps_create_pattern.webp)

To use an existing pattern, click its image in the **Patterns** tab, switch to
any painting mode, then left-click somewhere in the 2D editor:

![Placing an existing pattern using the TileMap editor](tutorials/2d/img/using_tilemaps_use_pattern.webp)

Like multi-tile selections, patterns will be repeated if used with the Line,
Rectangle or Bucket Fill painting modes.

#### NOTE
Despite being edited in the TileMap editor, patterns are stored in the
TileSet resource. This allows reusing patterns in different TileMapLayer nodes
after loading a TileSet resource saved to an external file.

## Handling tile connections automatically using terrains

To use terrains, the TileMapLayer node must feature at least one terrain set and a
terrain within this terrain set. See
[Creating terrain sets (autotiling)](using_tilesets.md#doc-using-tilesets-creating-terrain-sets) if you haven't created a terrain
set for the TileSet yet.

There are 3 kinds of painting modes available for terrain connections:

- **Connect**, where tiles are connected to surrounding tiles on the same
  TileMapLayer.
- **Path**, where tiles are connected to tiles painted in the same stroke (until
  the mouse button is released).
- Tile-specific overrides to resolve conflicts or handle situations not covered
  by the terrain system.

The Connect mode is easier to use, but Path is more flexible as it allows for
more artist control during painting. For instance, Path can allow roads to be
directly adjacent to each other without being connected to each other, while
Connect will force both roads to be connected.

![Selecting Connect mode in the TileMap editor's Terrains tab](tutorials/2d/img/using_tilemaps_terrain_select_connect_mode.webp)![Selecting Path mode in the TileMap editor's Terrains tab](tutorials/2d/img/using_tilemaps_terrain_select_path_mode.webp)

Lastly, you can select specific tiles from the terrain to resolve conflicts in
certain situations:

![Painting with specific tiles in the TileMap editor's Terrains tab](tutorials/2d/img/using_tilemaps_terrain_paint_specific_tiles.webp)

Any tile that has at least one of its bits set to a value set to the
corresponding terrain ID will appear in the list of tiles to choose from.

## Handling missing tiles

If you remove tiles in the TileSet that are referenced in a TileMap, the TileMap
will display a placeholder to indicate that an invalid tile ID is placed:

![Missing tiles in the TileMap editor due to the TileSet reference being broken](tutorials/2d/img/using_tilemaps_missing_tiles.webp)

These placeholders are **not** visible in the running project, but the tile data
is still persisted to disk. This allows you to safely close and reopen such
scenes. Once you re-add a tile with the matching ID, the tiles will appear with
the new tile's appearance.

#### NOTE
Missing tile placeholders may not be visible until you select the TileMapLayer
node and open the TileMap editor.
