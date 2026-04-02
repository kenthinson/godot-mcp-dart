<a id="doc-variant-class"></a>

# Variant class

## About

Variant is the most important datatype in Godot. A Variant takes up only 24
bytes on 64-bit platforms (20 bytes on 32-bit platforms) and can store almost
any engine datatype inside of it. Variants are rarely used to hold information
for long periods of time, instead they are used mainly for communication,
editing, serialization and generally moving data around.

A Variant can:

- Store almost any datatype.
- Perform operations between many variants (GDScript uses Variant as
  its atomic/native datatype).
- Be hashed, so it can be compared quickly to other variants.
- Be used to convert safely between datatypes.
- Be used to abstract calling methods and their arguments (Godot
  exports all its functions through variants).
- Be used to defer calls or move data between threads.
- Be serialized as binary and stored to disk, or transferred via
  network.
- Be serialized to text and use it for printing values and editable
  settings.
- Work as an exported property, so the editor can edit it universally.
- Be used for dictionaries, arrays, parsers, etc.

Basically, thanks to the Variant class, writing Godot itself was a much,
much easier task, as it allows for highly dynamic constructs not common
of C++ with little effort. Become a friend of Variant today.

#### NOTE
All types within Variant except Nil and Object **cannot** be `null` and
must always store a valid value. These types within Variant are therefore
called *non-nullable* types.

One of the Variant types is *Nil* which can only store the value `null`.
Therefore, it is possible for a Variant to contain the value `null`, even
though all Variant types excluding Nil and Object are non-nullable.

### References

- [core/variant/variant.h](https://github.com/godotengine/godot/blob/master/core/variant/variant.h)

## List of variant types

These types are available in Variant:

| Type                                                                                     | Notes                   |
|------------------------------------------------------------------------------------------|-------------------------|
| Nil (can only store `null`)                                                              | Nullable type           |
| [bool](../../classes/class_bool.md#class-bool)                                           |                         |
| [int](../../classes/class_int.md#class-int)                                              |                         |
| [float](../../classes/class_float.md#class-float)                                        |                         |
| [String](../../classes/class_string.md#class-string)                                     |                         |
| [Vector2](../../classes/class_vector2.md#class-vector2)                                  |                         |
| [Vector2i](../../classes/class_vector2i.md#class-vector2i)                               |                         |
| [Rect2](../../classes/class_rect2.md#class-rect2)                                        | 2D counterpart of AABB  |
| [Rect2i](../../classes/class_rect2i.md#class-rect2i)                                     |                         |
| [Vector3](../../classes/class_vector3.md#class-vector3)                                  |                         |
| [Vector3i](../../classes/class_vector3i.md#class-vector3i)                               |                         |
| [Transform2D](../../classes/class_transform2d.md#class-transform2d)                      |                         |
| [Vector4](../../classes/class_vector4.md#class-vector4)                                  |                         |
| [Vector4i](../../classes/class_vector4i.md#class-vector4i)                               |                         |
| [Plane](../../classes/class_plane.md#class-plane)                                        |                         |
| [Quaternion](../../classes/class_quaternion.md#class-quaternion)                         |                         |
| [AABB](../../classes/class_aabb.md#class-aabb)                                           | 3D counterpart of Rect2 |
| [Basis](../../classes/class_basis.md#class-basis)                                        |                         |
| [Transform3D](../../classes/class_transform3d.md#class-transform3d)                      |                         |
| [Projection](../../classes/class_projection.md#class-projection)                         |                         |
| [Color](../../classes/class_color.md#class-color)                                        |                         |
| [StringName](../../classes/class_stringname.md#class-stringname)                         |                         |
| [NodePath](../../classes/class_nodepath.md#class-nodepath)                               |                         |
| [RID](../../classes/class_rid.md#class-rid)                                              |                         |
| [Object](../../classes/class_object.md#class-object)                                     | Nullable type           |
| [Callable](../../classes/class_callable.md#class-callable)                               |                         |
| [Signal](../../classes/class_signal.md#class-signal)                                     |                         |
| [Dictionary](../../classes/class_dictionary.md#class-dictionary)                         |                         |
| [Array](../../classes/class_array.md#class-array)                                        |                         |
| [PackedByteArray](../../classes/class_packedbytearray.md#class-packedbytearray)          |                         |
| [PackedInt32Array](../../classes/class_packedint32array.md#class-packedint32array)       |                         |
| [PackedInt64Array](../../classes/class_packedint64array.md#class-packedint64array)       |                         |
| [PackedFloat32Array](../../classes/class_packedfloat32array.md#class-packedfloat32array) |                         |
| [PackedFloat64Array](../../classes/class_packedfloat64array.md#class-packedfloat64array) |                         |
| [PackedStringArray](../../classes/class_packedstringarray.md#class-packedstringarray)    |                         |
| [PackedVector2Array](../../classes/class_packedvector2array.md#class-packedvector2array) |                         |
| [PackedVector3Array](../../classes/class_packedvector3array.md#class-packedvector3array) |                         |
| [PackedColorArray](../../classes/class_packedcolorarray.md#class-packedcolorarray)       |                         |
| [PackedVector4Array](../../classes/class_packedvector4array.md#class-packedvector4array) |                         |

## Containers: Array and Dictionary

Both [Array](../../classes/class_array.md#class-array) and [Dictionary](../../classes/class_dictionary.md#class-dictionary) are implemented using
variants. A Dictionary can match any datatype used as key to any other datatype.
An Array just holds an array of Variants. Of course, a Variant can also hold a
Dictionary or an Array inside, making it even more flexible.

Modifications to a container will modify all references to
it. A [Mutex](core_types.md#doc-core-concurrency-types) should be created to lock it if
[multi-threaded access](../../tutorials/performance/using_multiple_threads.md#doc-using-multiple-threads) is desired.

### References

- [core/variant/dictionary.h](https://github.com/godotengine/godot/blob/master/core/variant/dictionary.h)
- [core/variant/array.h](https://github.com/godotengine/godot/blob/master/core/variant/array.h)
