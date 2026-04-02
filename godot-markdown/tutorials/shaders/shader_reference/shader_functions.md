<a id="doc-shader-functions"></a>

# Built-in functions

Godot supports a large number of built-in functions, conforming roughly to the
GLSL ES 3.0 specification.

#### NOTE
The following type aliases only used in documentation to reduce repetitive function declarations.
They can each refer to any of several actual types.

| alias           | actual types                                        | glsl documentation alias   |
|-----------------|-----------------------------------------------------|----------------------------|
| vec_type        | float, vec2, vec3, or vec4                          | genType                    |
| vec_int_type    | int, ivec2, ivec3, or ivec4                         | genIType                   |
| vec_uint_type   | uint, uvec2, uvec3, or uvec4                        | genUType                   |
| vec_bool_type   | bool, bvec2, bvec3, or bvec4                        | genBType                   |
| mat_type        | mat2, mat3, or mat4                                 | mat                        |
| gvec4_type      | vec4, ivec4, or uvec4                               | gvec4                      |
| gsampler2D      | sampler2D, isampler2D, or uSampler2D                | gsampler2D                 |
| gsampler2DArray | sampler2DArray, isampler2DArray, or uSampler2DArray | gsampler2DArray            |
| gsampler3D      | sampler3D, isampler3D, or uSampler3D                | gsampler3D                 |

If any of these are specified for multiple parameters, they must all be the same type unless otherwise noted.

<a id="shading-componentwise"></a>

#### NOTE
Many functions that accept one or more vectors or matrices perform the described function on each component of the vector/matrix.
Some examples:

| Operation                           | Equivalent Scalar Operation             |
|-------------------------------------|-----------------------------------------|
| `sqrt(vec2(4, 64))`                 | `vec2(sqrt(4), sqrt(64))`               |
| `min(vec2(3, 4), 1)`                | `vec2(min(3, 1), min(4, 1))`            |
| `min(vec3(1, 2, 3),vec3(5, 1, 3))`  | `vec3(min(1, 5), min(2, 1), min(3, 3))` |
| `pow(vec3(3, 8, 5 ), 2)`            | `vec3(pow(3, 2), pow(8, 2), pow(5, 2))` |
| `pow(vec3(3, 8, 5), vec3(1, 2, 4))` | `vec3(pow(3, 1), pow(8, 2), pow(5, 4))` |

The [GLSL Language Specification](http://www.opengl.org/registry/doc/GLSLangSpec.4.30.6.pdf) says under section 5.10 Vector and Matrix Operations:

> With a few exceptions, operations are component-wise. Usually, when an operator operates on a
> vector or matrix, it is operating independently on each component of the vector or matrix,
> in a component-wise fashion. [...] The exceptions are matrix multiplied by vector,
> vector multiplied by matrix, and matrix multiplied by matrix. These do not operate component-wise,
> but rather perform the correct linear algebraic multiply.

These function descriptions are adapted and modified from
[official OpenGL documentation](https://registry.khronos.org/OpenGL-Refpages/gl4/)
originally published by Khronos Group under the
[Open Publication License](https://opencontent.org/openpub).
Each function description links to the corresponding official OpenGL
documentation. Modification history for this page can be found on
[GitHub](https://github.com/godotengine/godot-docs/blob/master/tutorials/shaders/shader_reference/shader_functions.rst).

---

## Trigonometric functions

| Return Type     | Function                                                                                        | Description / Return value   |
|-----------------|-------------------------------------------------------------------------------------------------|------------------------------|
|                 | [radians](#shader-func-radians)( degrees)                                                       | Convert degrees to radians.  |
|                 | [degrees](#shader-func-degrees)( radians)                                                       | Convert radians to degrees.  |
|                 | [sin](#shader-func-sin)( x)                                                                     | Sine.                        |
|                 | [cos](#shader-func-cos)( x)                                                                     | Cosine.                      |
|                 | [tan](#shader-func-tan)( x)                                                                     | Tangent.                     |
|                 | [asin](#shader-func-asin)( x)                                                                   | Arc sine.                    |
|                 | [acos](#shader-func-acos)( x)                                                                   | Arc cosine.                  |
| <br/><br/><br/> | [atan](#shader-func-atan)( y_over_x)<br/><br/><br/>[atan](#shader-func-atan2)( y,  x)<br/><br/> | Arc tangent.                 |
|                 | [sinh](#shader-func-sinh)( x)                                                                   | Hyperbolic sine.             |
|                 | [cosh](#shader-func-cosh)( x)                                                                   | Hyperbolic cosine.           |
|                 | [tanh](#shader-func-tanh)( x)                                                                   | Hyperbolic tangent.          |
|                 | [asinh](#shader-func-asinh)( x)                                                                 | Arc hyperbolic sine.         |
|                 | [acosh](#shader-func-acosh)( x)                                                                 | Arc hyperbolic cosine.       |
|                 | [atanh](#shader-func-atanh)( x)                                                                 | Arc hyperbolic tangent.      |

### Trigonometric function descriptions

<a id="shader-func-radians"></a>

 **radians**( degrees) [🔗](#shader-func-radians)

> [Component-wise Function](#shading-componentwise).

> Converts a quantity specified in degrees into radians, with the formula
> `degrees * (PI / 180)`.

> * **param degrees:**
>   The quantity, in degrees, to be converted to radians.
> * **return:**
>   The input `degrees` converted to radians.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/radians.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/radians.xhtml)

---

<a id="shader-func-degrees"></a>

 **degrees**( radians) [🔗](#shader-func-degrees)

> [Component-wise Function](#shading-componentwise).

> Converts a quantity specified in radians into degrees, with the formula
> `radians * (180 / PI)`

> * **param radians:**
>   The quantity, in radians, to be converted to degrees.
> * **return:**
>   The input `radians` converted to degrees.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/degrees.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/degrees.xhtml)

---

<a id="shader-func-sin"></a>

 **sin**( angle) [🔗](#shader-func-sin)

> [Component-wise Function](#shading-componentwise).

> Returns the trigonometric sine of `angle`.

> * **param angle:**
>   The quantity, in radians, of which to return the sine.
> * **return:**
>   The sine of `angle`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/sin.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/sin.xhtml)

---

<a id="shader-func-cos"></a>

 **cos**( angle) [🔗](#shader-func-cos)

> [Component-wise Function](#shading-componentwise).

> Returns the trigonometric cosine of `angle`.

> * **param angle:**
>   The quantity, in radians, of which to return the cosine.
> * **return:**
>   The cosine of `angle`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/cos.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/cos.xhtml)

---

<a id="shader-func-tan"></a>

 **tan**( angle) [🔗](#shader-func-tan)

> [Component-wise Function](#shading-componentwise).

> Returns the trigonometric tangent of `angle`.

> * **param angle:**
>   The quantity, in radians, of which to return the tangent.
> * **return:**
>   The tangent of `angle`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/tan.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/tan.xhtml)

---

<a id="shader-func-asin"></a>

 **asin**( x) [🔗](#shader-func-asin)

> [Component-wise Function](#shading-componentwise).

> Arc sine, or inverse sine.
> Calculates the angle whose sine is `x` and is in the range `[-PI/2, PI/2]`.
> The result is undefined if `x < -1` or `x > 1`.

> * **param x:**
>   The value whose arc sine to return.
> * **return:**
>   The angle whose trigonometric sine is `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/asin.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/asin.xhtml)

---

<a id="shader-func-acos"></a>

 **acos**( x) [🔗](#shader-func-acos)

> [Component-wise Function](#shading-componentwise).

> Arc cosine, or inverse cosine.
> Calculates the angle whose cosine is `x` and is in the range `[0, PI]`.

> The result is undefined if `x < -1` or `x > 1`.

> * **param x:**
>   The value whose arc cosine to return.
> * **return:**
>   The angle whose trigonometric cosine is `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/acos.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/acos.xhtml)

---

<a id="shader-func-atan"></a>

 **atan**( y_over_x) [🔗](#shader-func-atan)

> [Component-wise Function](#shading-componentwise).

> Calculates the arc tangent given a tangent value of `y/x`.

> #### NOTE
> Because of the sign ambiguity, the function cannot determine with certainty in
> which quadrant the angle falls only by its tangent value. If you need to know the
> quadrant, use [atan(vec_type y, vec_type x)](#shader-func-atan2).

> * **param y_over_x:**
>   The fraction whose arc tangent to return.
> * **return:**
>   The trigonometric arc-tangent of `y_over_x` and is
>   in the range `[-PI/2, PI/2]`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/atan.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/atan.xhtml)

---

<a id="shader-func-atan2"></a>

 **atan**( y,  x) [🔗](#shader-func-atan2)

> [Component-wise Function](#shading-componentwise).

> Calculates the arc tangent given a numerator and denominator. The signs of
> `y` and `x` are used to determine the quadrant that the angle lies in.
> The result is undefined if `x == 0`.

> Equivalent to [atan2()](../../../classes/class_@globalscope.md#class-globalscope-method-atan2) in GDScript.

> * **param y:**
>   The numerator of the fraction whose arc tangent to return.
> * **param x:**
>   The denominator of the fraction whose arc tangent to return.
> * **return:**
>   The trigonometric arc tangent of `y/x` and is in
>   the range `[-PI, PI]`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/atan.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/atan.xhtml)

---

<a id="shader-func-sinh"></a>

 **sinh**( x) [🔗](#shader-func-sinh)

> [Component-wise Function](#shading-componentwise).

> Calculates the hyperbolic sine using `(e^x - e^-x)/2`.

> * **param x:**
>   The value whose hyperbolic sine to return.
> * **return:**
>   The hyperbolic sine of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/sinh.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/sinh.xhtml)

---

<a id="shader-func-cosh"></a>

 **cosh**( x) [🔗](#shader-func-cosh)

> [Component-wise Function](#shading-componentwise).

> Calculates the hyperbolic cosine using `(e^x + e^-x)/2`.

> * **param x:**
>   The value whose hyperbolic cosine to return.
> * **return:**
>   The hyperbolic cosine of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/cosh.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/cosh.xhtml)

---

<a id="shader-func-tanh"></a>

 **tanh**( x) [🔗](#shader-func-tanh)

> [Component-wise Function](#shading-componentwise).

> Calculates the hyperbolic tangent using `sinh(x)/cosh(x)`.

> * **param x:**
>   The value whose hyperbolic tangent to return.
> * **return:**
>   The hyperbolic tangent of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/tanh.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/tanh.xhtml)

---

<a id="shader-func-asinh"></a>

 **asinh**( x) [🔗](#shader-func-asinh)

> [Component-wise Function](#shading-componentwise).

> Calculates the arc hyperbolic sine of `x`, or the inverse of `sinh`.

> * **param x:**
>   The value whose arc hyperbolic sine to return.
> * **return:**
>   The arc hyperbolic sine of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/asinh.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/asinh.xhtml)

---

<a id="shader-func-acosh"></a>

 **acosh**( x) [🔗](#shader-func-acosh)

> [Component-wise Function](#shading-componentwise).

> Calculates the arc hyperbolic cosine of `x`, or the non-negative inverse of `cosh`.
> The result is undefined if `x < 1`.

> * **param x:**
>   The value whose arc hyperbolic cosine to return.
> * **return:**
>   The arc hyperbolic cosine of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/acosh.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/acosh.xhtml)

---

<a id="shader-func-atanh"></a>

 **atanh**( x) [🔗](#shader-func-atanh)

> [Component-wise Function](#shading-componentwise).

> Calculates the arc hyperbolic tangent of `x`, or the inverse of `tanh`.
> The result is undefined if `abs(x) > 1`.

> * **param x:**
>   The value whose arc hyperbolic tangent to return.
> * **return:**
>   The arc hyperbolic tangent of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/atanh.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/atanh.xhtml)

---

## Exponential and math functions

| Return Type                                             | Function                                                                                                                                                                                                                                                                                                                                                                        | Description / Return value                                          |
|---------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------|
|                                                         | [pow](#shader-func-pow)( x,  y)                                                                                                                                                                                                                                                                                                                                                 | Power (undefined if `x < 0` or if `x == 0` and `y <= 0`).           |
|                                                         | [exp](#shader-func-exp)( x)                                                                                                                                                                                                                                                                                                                                                     | Base-e exponential.                                                 |
|                                                         | [exp2](#shader-func-exp2)( x)                                                                                                                                                                                                                                                                                                                                                   | Base-2 exponential.                                                 |
|                                                         | [log](#shader-func-log)( x)                                                                                                                                                                                                                                                                                                                                                     | Natural (base-e) logarithm.                                         |
|                                                         | [log2](#shader-func-log2)( x)                                                                                                                                                                                                                                                                                                                                                   | Base-2 logarithm.                                                   |
|                                                         | [sqrt](#shader-func-sqrt)( x)                                                                                                                                                                                                                                                                                                                                                   | Square root.                                                        |
|                                                         | [inversesqrt](#shader-func-inversesqrt)( x)                                                                                                                                                                                                                                                                                                                                     | Inverse square root.                                                |
| <br/><br/><br/>                                         | [abs](#shader-func-abs)( x)<br/><br/><br/>[abs](#shader-func-abs)( x)<br/><br/>                                                                                                                                                                                                                                                                                                 | Absolute value (returns positive value if negative).                |
|                                                         | [sign](#shader-func-sign)( x)                                                                                                                                                                                                                                                                                                                                                   | Returns `1.0` if positive, `-1.0` if negative,<br/>`0.0` otherwise. |
|                                                         | [sign](#shader-func-sign)( x)                                                                                                                                                                                                                                                                                                                                                   | Returns `1` if positive, `-1` if negative,<br/>`0` otherwise.       |
|                                                         | [floor](#shader-func-floor)( x)                                                                                                                                                                                                                                                                                                                                                 | Rounds to the integer below.                                        |
|                                                         | [round](#shader-func-round)( x)                                                                                                                                                                                                                                                                                                                                                 | Rounds to the nearest integer.                                      |
|                                                         | [roundEven](#shader-func-roundeven)( x)                                                                                                                                                                                                                                                                                                                                         | Rounds to the nearest even integer.                                 |
|                                                         | [trunc](#shader-func-trunc)( x)                                                                                                                                                                                                                                                                                                                                                 | Truncation.                                                         |
|                                                         | [ceil](#shader-func-ceil)( x)                                                                                                                                                                                                                                                                                                                                                   | Rounds to the integer above.                                        |
|                                                         | [fract](#shader-func-fract)( x)                                                                                                                                                                                                                                                                                                                                                 | Fractional (returns `x - floor(x)`).                                |
| <br/><br/><br/>                                         | [mod](#shader-func-mod)( x,  y)<br/><br/><br/>[mod](#shader-func-mod)( x, float y)<br/><br/>                                                                                                                                                                                                                                                                                    | Modulo (division remainder).                                        |
|                                                         | [modf](#shader-func-modf)( x, out  i)                                                                                                                                                                                                                                                                                                                                           | Fractional of `x`, with `i` as integer part.                        |
| <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/> | [min](#shader-func-min)( a,  b)<br/><br/><br/>[min](#shader-func-min)( a, float b)<br/><br/><br/>[min](#shader-func-min)( a,  b)<br/><br/><br/>[min](#shader-func-min)( a, int b)<br/><br/><br/>[min](#shader-func-min)( a,  b)<br/><br/><br/>[min](#shader-func-min)( a, uint b)<br/><br/>                                                                                     | Lowest value between `a` and `b`.                                   |
| <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/> | [max](#shader-func-max)( a,  b)<br/><br/><br/>[max](#shader-func-max)( a, float b)<br/><br/><br/>[max](#shader-func-max)( a,  b)<br/><br/><br/>[max](#shader-func-max)( a, int b)<br/><br/><br/>[max](#shader-func-max)( a,  b)<br/><br/><br/>[max](#shader-func-max)( a, uint b)<br/><br/>                                                                                     | Highest value between `a` and `b`.                                  |
| <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/> | [clamp](#shader-func-clamp)( x,  min,  max)<br/><br/><br/>[clamp](#shader-func-clamp)( x, float min, float max)<br/><br/><br/>[clamp](#shader-func-clamp)( x,  min,  max)<br/><br/><br/>[clamp](#shader-func-clamp)( x, int min, int max)<br/><br/><br/>[clamp](#shader-func-clamp)( x,  min,  max)<br/><br/><br/>[clamp](#shader-func-clamp)( x, uint min, uint max)<br/><br/> | Clamps `x` between `min` and `max` (inclusive).                     |
| <br/><br/><br/><br/><br/>                               | [mix](#shader-func-mix)( a,  b,  c)<br/><br/><br/>[mix](#shader-func-mix)( a,  b, float c)<br/><br/><br/>[mix](#shader-func-mix)( a,  b,  c)<br/><br/>                                                                                                                                                                                                                          | Linear interpolate between `a` and `b` by `c`.                      |
|                                                         | [fma](#shader-func-fma)( a,  b,  c)                                                                                                                                                                                                                                                                                                                                             | Fused multiply-add operation: `(a * b + c)`                         |
| <br/><br/><br/>                                         | [step](#shader-func-step)( a,  b)<br/><br/><br/>[step](#shader-func-step)(float a,  b)<br/><br/>                                                                                                                                                                                                                                                                                | `b < a ? 0.0 : 1.0`                                                 |
| <br/><br/><br/>                                         | [smoothstep](#shader-func-smoothstep)( a,  b,  c)<br/><br/><br/>[smoothstep](#shader-func-smoothstep)(float a, float b,  c)<br/><br/>                                                                                                                                                                                                                                           | Hermite interpolate between `a` and `b` by `c`.                     |
|                                                         | [isnan](#shader-func-isnan)( x)                                                                                                                                                                                                                                                                                                                                                 | Returns `true` if scalar or vector component is `NaN`.              |
|                                                         | [isinf](#shader-func-isinf)( x)                                                                                                                                                                                                                                                                                                                                                 | Returns `true` if scalar or vector component is `INF`.              |
|                                                         | [floatBitsToInt](#shader-func-floatbitstoint)( x)                                                                                                                                                                                                                                                                                                                               | `float` to `int` bit copying, no conversion.                        |
|                                                         | [floatBitsToUint](#shader-func-floatbitstouint)( x)                                                                                                                                                                                                                                                                                                                             | `float` to `uint` bit copying, no conversion.                       |
|                                                         | [intBitsToFloat](#shader-func-intbitstofloat)( x)                                                                                                                                                                                                                                                                                                                               | `int` to `float` bit copying, no conversion.                        |
|                                                         | [uintBitsToFloat](#shader-func-uintbitstofloat)( x)                                                                                                                                                                                                                                                                                                                             | `uint` to `float` bit copying, no conversion.                       |

### Exponential and math function descriptions

<a id="shader-func-pow"></a>

 **pow**( x,  y) [🔗](#shader-func-pow)

> [Component-wise Function](#shading-componentwise).

> Raises `x` to the power of `y`.

> The result is undefined if `x < 0` or  if `x == 0` and `y <= 0`.

> * **param x:**
>   The value to be raised to the power `y`.
> * **param y:**
>   The power to which `x` will be raised.
> * **return:**
>   The value of `x` raised to the `y` power.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/pow.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/pow.xhtml)

---

<a id="shader-func-exp"></a>

 **exp**( x) [🔗](#shader-func-exp)

> [Component-wise Function](#shading-componentwise).

> Raises `e` to the power of `x`, or the the natural exponentiation.

> Equivalent to `pow(e, x)`.

> * **param x:**
>   The value to exponentiate.
> * **return:**
>   The natural exponentiation of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/exp.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/exp.xhtml)

---

<a id="shader-func-exp2"></a>

 **exp2**( x) [🔗](#shader-func-exp2)

> [Component-wise Function](#shading-componentwise).

> Raises `2` to the power of `x`.

> Equivalent to `pow(2.0, x)`.

> * **param x:**
>   The value of the power to which `2` will be raised.
> * **return:**
>   `2` raised to the power of x.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/exp2.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/exp2.xhtml)

---

<a id="shader-func-log"></a>

 **log**( x) [🔗](#shader-func-log)

> [Component-wise Function](#shading-componentwise).

> Returns the natural logarithm of `x`, i.e. the value `y` which satisfies `x == pow(e, y)`.
> The result is undefined if `x <= 0`.

> * **param x:**
>   The value of which to take the natural logarithm.
> * **return:**
>   The natural logarithm of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/log.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/log.xhtml)

---

<a id="shader-func-log2"></a>

 **log2**( x) [🔗](#shader-func-log2)

> [Component-wise Function](#shading-componentwise).

> Returns the base-2 logarithm of `x`, i.e. the value `y` which satisfies `x == pow(2, y)`.
> The result is undefined if `x <= 0`.

> * **param x:**
>   The value of which to take the base-2 logarithm.
> * **return:**
>   The base-2 logarithm of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/log2.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/log2.xhtml)

---

<a id="shader-func-sqrt"></a>

 **sqrt**( x) [🔗](#shader-func-sqrt)

> [Component-wise Function](#shading-componentwise).

> Returns the square root of `x`.
> The result is undefined if `x < 0`.

> * **param x:**
>   The value of which to take the square root.
> * **return:**
>   The square root of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/sqrt.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/sqrt.xhtml)

---

<a id="shader-func-inversesqrt"></a>

 **inversesqrt**( x) [🔗](#shader-func-inversesqrt)

> [Component-wise Function](#shading-componentwise).

> Returns the inverse of the square root of `x`, or `1.0 / sqrt(x)`.
> The result is undefined if `x <= 0`.

> * **param x:**
>   The value of which to take the inverse of the square root.
> * **return:**
>   The inverse of the square root of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/inversesqrt.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/inversesqrt.xhtml)

---

<a id="shader-func-abs"></a>

 **abs**( x) [🔗](#shader-func-abs)

 **abs**( x) [🔗](#shader-func-abs)

> [Component-wise Function](#shading-componentwise).

> Returns the absolute value of `x`. Returns `x` if `x` is positive, otherwise returns `-1 * x`.

> * **param x:**
>   The value of which to return the absolute.
> * **return:**
>   The absolute value of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/abs.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/abs.xhtml)

---

<a id="shader-func-sign"></a>

 **sign**( x) [🔗](#shader-func-sign)

 **sign**( x) [🔗](#shader-func-sign)

> [Component-wise Function](#shading-componentwise).

> Returns `-1` if `x < 0`, `0` if `x == 0`, and `1` if `x > 0`.

> * **param x:**
>   The value from which to extract the sign.
> * **return:**
>   The sign of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/sign.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/sign.xhtml)

---

<a id="shader-func-floor"></a>

 **floor**( x) [🔗](#shader-func-floor)

> [Component-wise Function](#shading-componentwise).

> Returns a value equal to the nearest integer that is less than or equal to `x`.

> * **param x:**
>   The value to floor.
> * **return:**
>   The nearest integer that is less than or equal to `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/floor.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/floor.xhtml)

---

<a id="shader-func-round"></a>

 **round**( x) [🔗](#shader-func-round)

> [Component-wise Function](#shading-componentwise).

> Rounds `x` to the nearest integer.

> #### NOTE
> Rounding of values with a fractional part of `0.5` is implementation-dependent.
> This includes the possibility that `round(x)` returns the same value as
> `roundEven(x)``for all values of ``x`.

> * **param x:**
>   The value to round.
> * **return:**
>   The rounded value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/round.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/round.xhtml)

---

<a id="shader-func-roundeven"></a>

 **roundEven**( x) [🔗](#shader-func-roundeven)

> [Component-wise Function](#shading-componentwise).

> Rounds `x` to the nearest integer. A value with a fractional part of `0.5`
> will always round toward the nearest even integer.
> For example, both `3.5` and `4.5` will round to `4.0`.

> * **param x:**
>   The value to round.
> * **return:**
>   The rounded value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/roundEven.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/roundEven.xhtml)

---

<a id="shader-func-trunc"></a>

 **trunc**( x) [🔗](#shader-func-trunc)

> [Component-wise Function](#shading-componentwise).

> Truncates `x`. Returns a value equal to the nearest integer to `x` whose
> absolute value is not larger than the absolute value of `x`.

> * **param x:**
>   The value to evaluate.
> * **return:**
>   The truncated value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/trunc.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/trunc.xhtml)

---

<a id="shader-func-ceil"></a>

 **ceil**( x) [🔗](#shader-func-ceil)

> [Component-wise Function](#shading-componentwise).

> Returns a value equal to the nearest integer that is greater than or equal to `x`.

> * **param x:**
>   The value to evaluate.
> * **return:**
>   The ceiling-ed value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/ceil.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/ceil.xhtml)

---

<a id="shader-func-fract"></a>

 **fract**( x) [🔗](#shader-func-fract)

> [Component-wise Function](#shading-componentwise).

> Returns the fractional part of `x`.

> This is calculated as `x - floor(x)`.

> * **param x:**
>   The value to evaluate.
> * **return:**
>   The fractional part of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/fract.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/fract.xhtml)

---

<a id="shader-func-mod"></a>

 **mod**( x,  y) [🔗](#shader-func-mod)

 **mod**( x, float y) [🔗](#shader-func-mod)

> [Component-wise Function](#shading-componentwise).

> Returns the value of `x modulo y`.
> This is also sometimes called the remainder.

> This is computed as `x - y * floor(x/y)`.

> * **param x:**
>   The value to evaluate.
> * **return:**
>   The value of `x modulo y`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/mod.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/mod.xhtml)

---

<a id="shader-func-modf"></a>

 **modf**( x, out  i) [🔗](#shader-func-modf)

> [Component-wise Function](#shading-componentwise).

> Separates a floating-point value `x` into its integer and fractional parts.

> The fractional part of the number is returned from the function.
> The integer part (as a floating-point quantity) is returned in the output parameter `i`.

> * **param x:**
>   The value to separate.
> * **param out i:**
>   A variable that receives the integer part of `x`.
> * **return:**
>   The fractional part of the number.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/modf.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/modf.xhtml)

---

<a id="shader-func-min"></a>

 **min**( a,  b) [🔗](#shader-func-min)

 **min**( a, float b) [🔗](#shader-func-min)

 **min**( a,  b) [🔗](#shader-func-min)

 **min**( a, int b) [🔗](#shader-func-min)

 **min**( a,  b) [🔗](#shader-func-min)

 **min**( a, uint b) [🔗](#shader-func-min)

> [Component-wise Function](#shading-componentwise).

> Returns the minimum of two values `a` and `b`.

> Returns `b` if `b < a`, otherwise returns `a`.

> * **param a:**
>   The first value to compare.
> * **param b:**
>   The second value to compare.
> * **return:**
>   The minimum value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/min.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/min.xhtml)

---

<a id="shader-func-max"></a>

 **max**( a,  b) [🔗](#shader-func-max)

 **max**( a, float b) [🔗](#shader-func-max)

 **max**( a,  b) [🔗](#shader-func-max)

 **max**( a, uint b) [🔗](#shader-func-max)

 **max**( a,  b) [🔗](#shader-func-max)

 **max**( a, int b) [🔗](#shader-func-max)

> [Component-wise Function](#shading-componentwise).

> Returns the maximum of two values `a` and `b`.

> It returns `b` if `b > a`, otherwise it returns `a`.

> * **param a:**
>   The first value to compare.
> * **param b:**
>   The second value to compare.
> * **return:**
>   The maximum value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/max.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/max.xhtml)

---

<a id="shader-func-clamp"></a>

 **clamp**( x,  minVal,  maxVal) [🔗](#shader-func-clamp)

 **clamp**( x, float minVal, float maxVal) [🔗](#shader-func-clamp)

 **clamp**( x,  minVal,  maxVal) [🔗](#shader-func-clamp)

 **clamp**( x, int minVal, int maxVal) [🔗](#shader-func-clamp)

 **clamp**( x,  minVal,  maxVal) [🔗](#shader-func-clamp)

 **clamp**( x, uint minVal, uint maxVal) [🔗](#shader-func-clamp)

> [Component-wise Function](#shading-componentwise).

> Returns the value of `x` constrained to the range `minVal` to `maxVal`.

> The returned value is computed as `min(max(x, minVal), maxVal)`.

> * **param x:**
>   The value to constrain.
> * **param minVal:**
>   The lower end of the range into which to constrain `x`.
> * **param maxVal:**
>   The upper end of the range into which to constrain `x`.
> * **return:**
>   The clamped value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/clamp.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/clamp.xhtml)

---

<a id="shader-func-mix"></a>

 **mix**( a,  b,  c) [🔗](#shader-func-mix)

 **mix**( a,  b, float c) [🔗](#shader-func-mix)

> [Component-wise Function](#shading-componentwise).

> Performs a linear interpolation between `a` and `b` using `c` to weight between them.

> Computed as `a * (1 - c) + b * c`.

> Equivalent to [lerp()](../../../classes/class_@globalscope.md#class-globalscope-method-lerp) in GDScript.

> * **param a:**
>   The start of the range in which to interpolate.
> * **param b:**
>   The end of the range in which to interpolate.
> * **param c:**
>   The value to use to interpolate between `a` and `b`.
> * **return:**
>   The interpolated value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/mix.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/mix.xhtml)

---

 **mix**( a,  b,  c) [🔗](#shader-func-mix)

> Selects either value `a` or value `b` based on the value of `c`.
> For a component of `c` that is false, the corresponding component of `a` is returned.
> For a component of `c` that is true, the corresponding component of `b` is returned.
> Components of `a` and `b` that are not selected are allowed to be invalid floating-point values and will have no effect on the results.

> If `a`, `b`, and `c` are vector types the operation is performed [component-wise](#shading-componentwise).
> ie. `mix(vec2(42, 314), vec2(9.8, 6e23), bvec2(true, false)))` will return `vec2(9.8, 314)`.

> * **param a:**
>   Value returned when `c` is false.
> * **param b:**
>   Value returned when `c` is true.
> * **param c:**
>   The value used to select between `a` and `b`.
> * **return:**
>   The interpolated value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/mix.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/mix.xhtml)

---

<a id="shader-func-fma"></a>

 **fma**( a,  b,  c) [🔗](#shader-func-fma)

> [Component-wise Function](#shading-componentwise).

> Performs, where possible, a fused multiply-add operation, returning `a * b + c`. In use cases where the
> return value is eventually consumed by a variable declared as precise:

> > - `fma()` is considered a single operation, whereas the expression `a * b + c` consumed by a variable declared as precise is considered two operations.
> > - The precision of `fma()` can differ from the precision of the expression `a * b + c`.
> > - `fma()` will be computed with the same precision as any other `fma()` consumed by a precise variable,
> >   giving invariant results for the same input values of a, b and c.

> Otherwise, in the absence of precise consumption, there are no special constraints on the number of operations
> or difference in precision between `fma()` and the expression `a * b + c`.

> * **param a:**
>   The first value to be multiplied.
> * **param b:**
>   The second value to be multiplied.
> * **param c:**
>   The value to be added to the result.
> * **return:**
>   The value of `a * b + c`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/fma.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/fma.xhtml)

---

<a id="shader-func-step"></a>

 **step**( a,  b) [🔗](#shader-func-step)

 **step**(float a,  b) [🔗](#shader-func-step)

> [Component-wise Function](#shading-componentwise).

> Generates a step function by comparing b to a.

> Equivalent to `if (b < a) { return 0.0; } else { return 1.0; }`.
> For element i of the return value, 0.0 is returned if b[i] < a[i], and 1.0 is returned otherwise.

> * **param a:**
>   The location of the edge of the step function.
> * **param b:**
>   The value to be used to generate the step function.
> * **return:**
>   `0.0` or `1.0`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/step.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/step.xhtml)

---

<a id="shader-func-smoothstep"></a>

 **smoothstep**( a,  b,  c) [🔗](#shader-func-smoothstep)

 **smoothstep**(float a, float b,  c) [🔗](#shader-func-smoothstep)

> [Component-wise Function](#shading-componentwise).

> Performs smooth Hermite interpolation between `0` and `1` when a < c < b.
> This is useful in cases where a threshold function with a smooth transition is desired.

> Smoothstep is equivalent to:

> ```gdscript
> vec_type t;
> t = clamp((c - a) / (b - a), 0.0, 1.0);
> return t * t * (3.0 - 2.0 * t);
> ```

> Results are undefined if `a >= b`.

> * **param a:**
>   The value of the lower edge of the Hermite function.
> * **param b:**
>   The value of the upper edge of the Hermite function.
> * **param c:**
>   The source value for interpolation.
> * **return:**
>   The interpolated value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/smoothstep.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/smoothstep.xhtml)

---

<a id="shader-func-isnan"></a>

 **isnan**( x) [🔗](#shader-func-isnan)

> [Component-wise Function](#shading-componentwise).

> For each element i of the result, returns `true` if x[i] is positive
> or negative floating-point NaN (Not a Number) and false otherwise.

> * **param x:**
>   The value to test for NaN.
> * **return:**
>   `true` or `false`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/isnan.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/isnan.xhtml)

---

<a id="shader-func-isinf"></a>

 **isinf**( x) [🔗](#shader-func-isinf)

> [Component-wise Function](#shading-componentwise).

> For each element i of the result, returns `true` if x[i] is positive or negative
> floating-point infinity and false otherwise.

> * **param x:**
>   The value to test for infinity.
> * **return:**
>   `true` or `false`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/isinf.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/isinf.xhtml)

---

<a id="shader-func-floatbitstoint"></a>

 **floatBitsToInt**( x) [🔗](#shader-func-floatbitstoint)

> [Component-wise Function](#shading-componentwise).

> Returns the encoding of the floating-point parameters as `int`.

> The floating-point bit-level representation is preserved.

> * **param x:**
>   The value whose floating-point encoding to return.
> * **return:**
>   The floating-point encoding of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/floatBitsToInt.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/floatBitsToInt.xhtml)

---

<a id="shader-func-floatbitstouint"></a>

 **floatBitsToUint**( x) [🔗](#shader-func-floatbitstouint)

> [Component-wise Function](#shading-componentwise).

> Returns the encoding of the floating-point parameters as `uint`.

> The floating-point bit-level representation is preserved.

> * **param x:**
>   The value whose floating-point encoding to return.
> * **return:**
>   The floating-point encoding of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/floatBitsToInt.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/floatBitsToInt.xhtml)

---

<a id="shader-func-intbitstofloat"></a>

 **intBitsToFloat**( x) [🔗](#shader-func-intbitstofloat)

> [Component-wise Function](#shading-componentwise).

> Converts a bit encoding to a floating-point value. Opposite of floatBitsToInt<shader_func_floatBitsToInt>

> If the encoding of a `NaN` is passed in `x`, it will not signal and the resulting value will be undefined.

> If the encoding of a floating-point infinity is passed in parameter `x`, the resulting floating-point value is
> the corresponding (positive or negative) floating-point infinity.

> * **param x:**
>   The bit encoding to return as a floating-point value.
> * **return:**
>   A floating-point value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/intBitsToFloat.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/intBitsToFloat.xhtml)

---

<a id="shader-func-uintbitstofloat"></a>

 **uintBitsToFloat**( x) [🔗](#shader-func-uintbitstofloat)

> [Component-wise Function](#shading-componentwise).

> Converts a bit encoding to a floating-point value. Opposite of floatBitsToUint<shader_func_floatBitsToUint>

> If the encoding of a `NaN` is passed in `x`, it will not signal and the resulting value will be undefined.

> If the encoding of a floating-point infinity is passed in parameter `x`, the resulting floating-point value is
> the corresponding (positive or negative) floating-point infinity.

> * **param x:**
>   The bit encoding to return as a floating-point value.
> * **return:**
>   A floating-point value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/intBitsToFloat.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/intBitsToFloat.xhtml)

---

## Geometric functions

| float   | [length](#shader-func-length)( x)                          | Vector length.                                     |
|---------|------------------------------------------------------------|----------------------------------------------------|
| float   | [distance](#shader-func-distance)( a,  b)                  | Distance between vectors i.e `length(a - b)`.      |
| float   | [dot](#shader-func-dot)( a,  b)                            | Dot product.                                       |
| vec3    | [cross](#shader-func-cross)(vec3 a, vec3 b)                | Cross product.                                     |
|         | [normalize](#shader-func-normalize)( x)                    | Normalize to unit length.                          |
| vec3    | [reflect](#shader-func-reflect)(vec3 I, vec3 N)            | Reflect.                                           |
| vec3    | [refract](#shader-func-refract)(vec3 I, vec3 N, float eta) | Refract.                                           |
|         | [faceforward](#shader-func-faceforward)( N,  I,  Nref)     | If `dot(Nref, I)` < 0, return `N`, otherwise `-N`. |
|         | [matrixCompMult](#shader-func-matrixcompmult)( x,  y)      | Matrix component multiplication.                   |
|         | [outerProduct](#shader-func-outerproduct)( column,  row)   | Matrix outer product.                              |
|         | [transpose](#shader-func-transpose)( m)                    | Transpose matrix.                                  |
| float   | [determinant](#shader-func-determinant)( m)                | Matrix determinant.                                |
|         | [inverse](#shader-func-inverse)( m)                        | Inverse matrix.                                    |

### Geometric function descriptions

<a id="shader-func-length"></a>

float **length**( x) [🔗](#shader-func-length)

> Returns the length of the vector.
> ie. `sqrt(x[0] * x[0] + x[1] * x[1] + ... + x[n] * x[n])`

> * **param x:**
>   The vector
> * **return:**
>   The length of the vector.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/length.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/length.xhtml)

---

<a id="shader-func-distance"></a>

float **distance**( a,  b) [🔗](#shader-func-distance)

> Returns the distance between the two points a and b.

> i.e., `length(b - a);`

> * **param a:**
>   The first point.
> * **param b:**
>   The second point.
> * **return:**
>   The scalar distance between the points

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/distance.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/distance.xhtml)

---

<a id="shader-func-dot"></a>

float **dot**( a,  b) [🔗](#shader-func-dot)

> Returns the dot product of two vectors, `a` and `b`.
> i.e., `a.x * b.x + a.y * b.y + ...`

> * **param a:**
>   The first vector.
> * **param b:**
>   The second vector.
> * **return:**
>   The dot product.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/dot.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/dot.xhtml)

---

<a id="shader-func-cross"></a>

vec3 **cross**(vec3 a, vec3 b) [🔗](#shader-func-cross)

> Returns the cross product of two vectors. i.e.:

> ```glsl
> vec2( a.y * b.z - b.y * a.z,
>       a.z * b.x - b.z * a.x,
>       a.x * b.z - b.x * a.y)
> ```

> * **param a:**
>   The first vector.
> * **param b:**
>   The second vector.
> * **return:**
>   The cross product of `a` and `b`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/cross.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/cross.xhtml)

---

<a id="shader-func-normalize"></a>

 **normalize**( x) [🔗](#shader-func-normalize)

> Returns a vector with the same direction as `x` but with length `1.0`.

> * **param x:**
>   The vector to normalize.
> * **return:**
>   The normalized vector.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/normalize.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/normalize.xhtml)

---

<a id="shader-func-reflect"></a>

vec3 **reflect**(vec3 I, vec3 N) [🔗](#shader-func-reflect)

> Calculate the reflection direction for an incident vector.

> For a given incident vector `I` and surface normal `N` reflect returns the reflection direction calculated as `I - 2.0 * dot(N, I) * N`.

> #### NOTE
> `N` should be normalized in order to achieve the desired result.

> * **param I:**
>   The incident vector.
> * **param N:**
>   The normal vector.
> * **return:**
>   The reflection vector.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/reflect.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/reflect.xhtml)

---

<a id="shader-func-refract"></a>

vec3 **refract**(vec3 I, vec3 N, float eta) [🔗](#shader-func-refract)

> Calculate the refraction direction for an incident vector.

> For a given incident vector `I`, surface normal `N` and ratio of indices of refraction, `eta`, refract returns the refraction vector, `R`.

> `R` is calculated as:

> ```glsl
> k = 1.0 - eta * eta * (1.0 - dot(N, I) * dot(N, I));
> if (k < 0.0)
>     R = genType(0.0);       // or genDType(0.0)
> else
>     R = eta * I - (eta * dot(N, I) + sqrt(k)) * N;
> ```

> #### NOTE
> The input parameters I and N should be normalized in order to achieve the desired result.

> * **param I:**
>   The incident vector.
> * **param N:**
>   The normal vector.
> * **param eta:**
>   The ratio of indices of refraction.
> * **return:**
>   The refraction vector.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/refract.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/refract.xhtml)

---

<a id="shader-func-faceforward"></a>

 **faceforward**( N,  I,  Nref) [🔗](#shader-func-faceforward)

> Returns a vector pointing in the same direction as another.

> Orients a vector to point away from a surface as defined by its normal.
> If `dot(Nref, I) < 0` faceforward returns `N`, otherwise it returns `-N`.

> * **param N:**
>   The vector to orient.
> * **param I:**
>   The incident vector.
> * **param Nref:**
>   The reference vector.
> * **return:**
>   The oriented vector.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/faceforward.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/faceforward.xhtml)

---

<a id="shader-func-matrixcompmult"></a>

 **matrixCompMult**( x,  y) [🔗](#shader-func-matrixcompmult)

> Perform a [component-wise](#shading-componentwise) multiplication of two matrices.

> Performs a component-wise multiplication of two matrices, yielding a result
> matrix where each component, `result[i][j]` is computed as the scalar
> product of `x[i][j]` and `y[i][j]`.

> * **param x:**
>   The first matrix multiplicand.
> * **param y:**
>   The second matrix multiplicand.
> * **return:**
>   The resultant matrix.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/matrixCompMult.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/matrixCompMult.xhtml)

---

<a id="shader-func-outerproduct"></a>

 **outerProduct**( column,  row) [🔗](#shader-func-outerproduct)

> Calculate the outer product of a pair of vectors.

> Does a linear algebraic matrix multiply `column * row`, yielding a matrix whose number of
> rows is the number of components in `column` and whose number of columns is the number of
> components in `row`.

> * **param column:**
>   The column vector for multiplication.
> * **param row:**
>   The row vector for multiplication.
> * **return:**
>   The outer product matrix.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/outerProduct.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/outerProduct.xhtml)

---

<a id="shader-func-transpose"></a>

 **transpose**( m) [🔗](#shader-func-transpose)

> Calculate the transpose of a matrix.

> * **param m:**
>   The matrix to transpose.
> * **return:**
>   A new matrix that is the transpose of the input matrix `m`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/transpose.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/transpose.xhtml)

---

<a id="shader-func-determinant"></a>

float **determinant**( m) [🔗](#shader-func-determinant)

> Calculate the determinant of a matrix.

> * **param m:**
>   The matrix.
> * **return:**
>   The determinant of the input matrix `m`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/determinant.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/determinant.xhtml)

---

<a id="shader-func-inverse"></a>

 **inverse**( m) [🔗](#shader-func-inverse)

> Calculate the inverse of a matrix.

> The values in the returned matrix are undefined if `m` is singular or poorly-conditioned (nearly singular).

> * **param m:**
>   The matrix of which to take the inverse.
> * **return:**
>   A new matrix which is the inverse of the input matrix `m`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/inverse.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/inverse.xhtml)

---

## Comparison functions

|      | [lessThan](#shader-func-lessthan)( x,  y)                  | Bool vector comparison on < int/uint/float vectors.     |
|------|------------------------------------------------------------|---------------------------------------------------------|
|      | [greaterThan](#shader-func-greaterthan)( x,  y)            | Bool vector comparison on > int/uint/float vectors.     |
|      | [lessThanEqual](#shader-func-lessthanequal)( x,  y)        | Bool vector comparison on <= int/uint/float vectors.    |
|      | [greaterThanEqual](#shader-func-greaterthanequal)(  x,  y) | Bool vector comparison on >= int/uint/float vectors.    |
|      | [equal](#shader-func-equal)( x,  y)                        | Bool vector comparison on == int/uint/float vectors.    |
|      | [notEqual](#shader-func-notequal)( x,  y)                  | Bool vector comparison on != int/uint/float vectors.    |
| bool | [any](#shader-func-any)( x)                                | `true` if any component is `true`, `false` otherwise.   |
| bool | [all](#shader-func-all)( x)                                | `true` if all components are `true`, `false` otherwise. |
|      | [not](#shader-func-not)( x)                                | Invert boolean vector.                                  |

### Comparison function descriptions

<a id="shader-func-lessthan"></a>

 **lessThan**( x,  y) [🔗](#shader-func-lessthan)

> Performs a [component-wise](#shading-componentwise) less-than comparison of two vectors.

> * **param x:**
>   The first vector to compare.
> * **param y:**
>   The second vector to compare.
> * **return:**
>   A boolean vector in which each element `i` is computed as `x[i] < y[i]`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/lessThan.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/lessThan.xhtml)

---

<a id="shader-func-greaterthan"></a>

 **greaterThan**( x,  y) [🔗](#shader-func-greaterthan)

> Performs a [component-wise](#shading-componentwise) greater-than comparison of two vectors.

> * **param x:**
>   The first vector to compare.
> * **param y:**
>   The second vector to compare.
> * **return:**
>   A boolean vector in which each element `i` is computed as `x[i] > y[i]`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/greaterThan.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/greaterThan.xhtml)

---

<a id="shader-func-lessthanequal"></a>

 **lessThanEqual**( x,  y) [🔗](#shader-func-lessthanequal)

> Performs a [component-wise](#shading-componentwise) less-than-or-equal comparison of two vectors.

> * **param x:**
>   The first vector to compare.
> * **param y:**
>   The second vector to compare.
> * **return:**
>   A boolean vector in which each element `i` is computed as `x[i] <= y[i]`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/lessThanEqual.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/lessThanEqual.xhtml)

---

<a id="shader-func-greaterthanequal"></a>

 **greaterThanEqual**( x,  y) [🔗](#shader-func-greaterthanequal)

> Performs a [component-wise](#shading-componentwise) greater-than-or-equal comparison of two vectors.

> * **param x:**
>   The first vector to compare.
> * **param y:**
>   The second vector to compare.
> * **return:**
>   A boolean vector in which each element `i` is computed as `x[i] >= y[i]`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/greaterThanEqual.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/greaterThanEqual.xhtml)

---

<a id="shader-func-equal"></a>

 **equal**( x,  y) [🔗](#shader-func-equal)

> Performs a [component-wise](#shading-componentwise) equal-to comparison of two vectors.

> * **param x:**
>   The first vector to compare.
> * **param y:**
>   The second vector to compare.
> * **return:**
>   A boolean vector in which each element `i` is computed as `x[i] == y[i]`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/equal.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/equal.xhtml)

---

<a id="shader-func-notequal"></a>

 **notEqual**( x,  y) [🔗](#shader-func-notequal)

> Performs a [component-wise](#shading-componentwise) not-equal-to comparison of two vectors.

> * **param x:**
>   The first vector for comparison.
> * **param y:**
>   The second vector for comparison.
> * **return:**
>   A boolean vector in which each element `i` is computed as `x[i] != y[i]`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/notEqual.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/notEqual.xhtml)

---

<a id="shader-func-any"></a>

bool **any**( x) [🔗](#shader-func-any)

> Returns `true` if any element of a boolean vector is `true`, `false` otherwise.

> Functionally equivalent to:

> ```gdscript
> bool any(bvec x) {     // bvec can be bvec2, bvec3 or bvec4
>     bool result = false;
>     int i;
>     for (i = 0; i < x.length(); ++i) {
>         result |= x[i];
>     }
>     return result;
> }
> ```

> * **param x:**
>   The vector to be tested for truth.
> * **return:**
>   True if any element of x is true and false otherwise.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/any.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/any.xhtml)

---

<a id="shader-func-all"></a>

bool **all**( x) [🔗](#shader-func-all)

> Returns `true` if all elements of a boolean vector are `true`, `false` otherwise.

> Functionally equivalent to:

> ```gdscript
> bool all(bvec x)       // bvec can be bvec2, bvec3 or bvec4
> {
>     bool result = true;
>     int i;
>     for (i = 0; i < x.length(); ++i)
>     {
>         result &= x[i];
>     }
>     return result;
> }
> ```

> * **param x:**
>   The vector to be tested for truth.
> * **return:**
>   `true` if all elements of `x` are `true` and `false` otherwise.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/all.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/all.xhtml)

---

<a id="shader-func-not"></a>

 **not**( x) [🔗](#shader-func-not)

> Logically invert a boolean vector.

> * **param x:**
>   The vector to be inverted.
> * **return:**
>   A new boolean vector for which each element i is computed as !x[i].

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/not.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/not.xhtml)

---

## Texture functions

| ivec2<br/><br/><br/>ivec2<br/><br/><br/>ivec2<br/><br/><br/>ivec3<br/><br/><br/>ivec3<br/><br/>   | [textureSize](#shader-func-texturesize)( s, int lod)<br/><br/><br/>[textureSize](#shader-func-texturesize)(samplerCube s, int lod)<br/><br/><br/>[textureSize](#shader-func-texturesize)(samplerCubeArray s, int lod)<br/><br/><br/>[textureSize](#shader-func-texturesize)( s, int lod)<br/><br/><br/>[textureSize](#shader-func-texturesize)( s, int lod)<br/><br/>                                                                                                                                | Get the size of a texture.<br/><br/>For performance reasons, this function should be avoided as it<br/>always performs a full texture read. When possible, you should pass<br/>the texture size as a uniform instead.   |
|---------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| vec2<br/><br/><br/>vec3<br/><br/><br/>vec2<br/><br/><br/>vec2<br/><br/>                           | [textureQueryLod](#shader-func-texturequerylod)( s, vec2 p)<br/><br/><br/>[textureQueryLod](#shader-func-texturequerylod)( s, vec2 p)<br/><br/><br/>[textureQueryLod](#shader-func-texturequerylod)( s, vec3 p)<br/><br/><br/>[textureQueryLod](#shader-func-texturequerylod)(samplerCube s, vec3 p)<br/><br/>                                                                                                                                                                                       | Compute the level-of-detail that would be used to sample from a<br/>texture.                                                                                                                                            |
| int<br/><br/><br/>int<br/><br/><br/>int<br/><br/><br/>int<br/><br/>                               | [textureQueryLevels](#shader-func-texturequerylevels)( s)<br/><br/><br/>[textureQueryLevels](#shader-func-texturequerylevels)( s)<br/><br/><br/>[textureQueryLevels](#shader-func-texturequerylevels)( s)<br/><br/><br/>[textureQueryLevels](#shader-func-texturequerylevels)(samplerCube s)<br/><br/>                                                                                                                                                                                               | Get the number of accessible mipmap levels of a texture.                                                                                                                                                                |
| <br/><br/><br/><br/><br/><br/>vec4<br/><br/><br/>vec4<br/><br/><br/>vec4<br/><br/>                | [texture](#shader-func-texture)( s, vec2 p [, float bias] )<br/><br/><br/>[texture](#shader-func-texture)( s, vec3 p [, float bias] )<br/><br/><br/>[texture](#shader-func-texture)( s, vec3 p [, float bias] )<br/><br/><br/>[texture](#shader-func-texture)(samplerCube s, vec3 p [, float bias] )<br/><br/><br/>[texture](#shader-func-texture)(samplerCubeArray s, vec4 p [, float bias] )<br/><br/><br/>[texture](#shader-func-texture)(samplerExternalOES s, vec2 p [, float bias] )<br/><br/> | Performs a texture read.                                                                                                                                                                                                |
| <br/><br/><br/><br/><br/>                                                                         | [textureProj](#shader-func-textureproj)( s, vec3 p [, float bias] )<br/><br/><br/>[textureProj](#shader-func-textureproj)( s, vec4 p [, float bias] )<br/><br/><br/>[textureProj](#shader-func-textureproj)( s, vec4 p [, float bias] )<br/><br/>                                                                                                                                                                                                                                                    | Performs a texture read with projection.                                                                                                                                                                                |
| <br/><br/><br/><br/><br/><br/>vec4<br/><br/><br/>vec4<br/><br/>                                   | [textureLod](#shader-func-texturelod)( s, vec2 p, float lod)<br/><br/><br/>[textureLod](#shader-func-texturelod)( s, vec3 p, float lod)<br/><br/><br/>[textureLod](#shader-func-texturelod)( s, vec3 p, float lod)<br/><br/><br/>[textureLod](#shader-func-texturelod)(samplerCube s, vec3 p, float lod)<br/><br/><br/>[textureLod](#shader-func-texturelod)(samplerCubeArray s, vec4 p, float lod)<br/><br/>                                                                                        | Performs a texture read at custom mipmap.                                                                                                                                                                               |
| <br/><br/><br/><br/><br/>                                                                         | [textureProjLod](#shader-func-textureprojlod)( s, vec3 p, float lod)<br/><br/><br/>[textureProjLod](#shader-func-textureprojlod)( s, vec4 p, float lod)<br/><br/><br/>[textureProjLod](#shader-func-textureprojlod)( s, vec4 p, float lod)<br/><br/>                                                                                                                                                                                                                                                 | Performs a texture read with projection/LOD.                                                                                                                                                                            |
| <br/><br/><br/><br/><br/><br/>vec4<br/><br/><br/>vec4<br/><br/>                                   | [textureGrad](#shader-func-texturegrad)( s, vec2 p, vec2 dPdx, vec2 dPdy)<br/><br/><br/>[textureGrad](#shader-func-texturegrad)( s, vec3 p, vec2 dPdx, vec2 dPdy)<br/><br/><br/>[textureGrad](#shader-func-texturegrad)( s, vec3 p, vec2 dPdx, vec2 dPdy)<br/><br/><br/>[textureGrad](#shader-func-texturegrad)(samplerCube s, vec3 p, vec3 dPdx, vec3 dPdy)<br/><br/><br/>[textureGrad](#shader-func-texturegrad)(samplerCubeArray s, vec3 p, vec3 dPdx, vec3 dPdy)<br/><br/>                       | Performs a texture read with explicit gradients.                                                                                                                                                                        |
| <br/><br/><br/><br/><br/>                                                                         | [textureProjGrad](#shader-func-textureprojgrad)( s, vec3 p, vec2 dPdx, vec2 dPdy)<br/><br/><br/>[textureProjGrad](#shader-func-textureprojgrad)( s, vec4 p, vec2 dPdx, vec2 dPdy)<br/><br/><br/>[textureProjGrad](#shader-func-textureprojgrad)( s, vec4 p, vec3 dPdx, vec3 dPdy)<br/><br/>                                                                                                                                                                                                          | Performs a texture read with projection/LOD and with explicit                                                                                                                                                           |
| <br/><br/><br/><br/><br/>                                                                         | [texelFetch](#shader-func-texelfetch)( s, ivec2 p, int lod)<br/><br/><br/>[texelFetch](#shader-func-texelfetch)( s, ivec3 p, int lod)<br/><br/><br/>[texelFetch](#shader-func-texelfetch)( s, ivec3 p, int lod)<br/><br/>                                                                                                                                                                                                                                                                            | Fetches a single texel using integer coordinates.                                                                                                                                                                       |
| <br/><br/><br/><br/>vec4<br/><br/>                                                                | [textureGather](#shader-func-texturegather)( s, vec2 p [, int comps] )<br/><br/><br/>[textureGather](#shader-func-texturegather)( s, vec3 p [, int comps] )<br/><br/><br/>[textureGather](#shader-func-texturegather)(samplerCube s, vec3 p [, int comps] )<br/><br/>                                                                                                                                                                                                                                | Gathers four texels from a texture.                                                                                                                                                                                     |
|                                                                                                   | [dFdx](#shader-func-dfdx)( p)                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Derivative with respect to `x` window coordinate,<br/>automatic granularity.                                                                                                                                            |
|                                                                                                   | [dFdxCoarse](#shader-func-dfdxcoarse)( p)                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Derivative with respect to `x` window coordinate,<br/>course granularity.<br/><br/>Not available when using the Compatibility renderer.                                                                                 |
|                                                                                                   | [dFdxFine](#shader-func-dfdxfine)( p)                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Derivative with respect to `x` window coordinate,<br/>fine granularity.<br/><br/>Not available when using the Compatibility renderer.                                                                                   |
|                                                                                                   | [dFdy](#shader-func-dfdy)( p)                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Derivative with respect to `y` window coordinate,<br/>automatic granularity.                                                                                                                                            |
|                                                                                                   | [dFdyCoarse](#shader-func-dfdycoarse)( p)                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Derivative with respect to `y` window coordinate,<br/>course granularity.<br/><br/>Not available when using the Compatibility renderer.                                                                                 |
|                                                                                                   | [dFdyFine](#shader-func-dfdyfine)( p)                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Derivative with respect to `y` window coordinate,<br/>fine granularity.<br/><br/>Not available when using the Compatibility renderer.                                                                                   |
|                                                                                                   | [fwidth](#shader-func-fwidth)( p)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Sum of absolute derivative in `x` and `y`.                                                                                                                                                                              |
|                                                                                                   | [fwidthCoarse](#shader-func-fwidthcoarse)( p)                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Sum of absolute derivative in `x` and `y`.<br/><br/>Not available when using the Compatibility renderer.                                                                                                                |
|                                                                                                   | [fwidthFine](#shader-func-fwidthfine)( p)                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Sum of absolute derivative in `x` and `y`.<br/><br/>Not available when using the Compatibility renderer.                                                                                                                |

### Texture function descriptions

<a id="shader-func-texturesize"></a>

ivec2 **textureSize**( s, int lod) [🔗](#shader-func-texturesize)

ivec2 **textureSize**(samplerCube s, int lod) [🔗](#shader-func-texturesize)

ivec2 **textureSize**(samplerCubeArray s, int lod) [🔗](#shader-func-texturesize)

ivec3 **textureSize**( s, int lod) [🔗](#shader-func-texturesize)

ivec3 **textureSize**( s, int lod) [🔗](#shader-func-texturesize)

> Retrieves the dimensions of a level of a texture.

> Returns the dimensions of level `lod` (if present) of the texture bound to sampler.

> The components in the return value are filled in, in order, with the width, height and depth
> of the texture. For the array forms, the last component of the return value is
> the number of layers in the texture array.

> * **param s:**
>   The sampler to which the texture whose dimensions to retrieve is bound.
> * **param lod:**
>   The level of the texture for which to retrieve the dimensions.
> * **return:**
>   The dimensions of level `lod` (if present) of the texture bound to sampler.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureSize.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureSize.xhtml)

---

<a id="shader-func-texturequerylod"></a>

vec2 **textureQueryLod**( s, vec2 p) [🔗](#shader-func-texturequerylod)

vec2 **textureQueryLod**( s, vec2 p) [🔗](#shader-func-texturequerylod)

vec2 **textureQueryLod**( s, vec3 p) [🔗](#shader-func-texturequerylod)

vec2 **textureQueryLod**(samplerCube s, vec3 p) [🔗](#shader-func-texturequerylod)

> #### NOTE
> Available only in the fragment shader.

> Compute the level-of-detail that would be used to sample from a texture.

> The mipmap array(s) that would be accessed is returned in the x component of
> the return value. The computed level-of-detail relative to the base level is
> returned in the y component of the return value.

> If called on an incomplete texture, the result of the operation is undefined.

> * **param s:**
>   The sampler to which the texture whose level-of-detail will be queried is bound.
> * **param p:**
>   The texture coordinates at which the level-of-detail will be queried.
> * **return:**
>   See description.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureQueryLod.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureQueryLod.xhtml)

---

<a id="shader-func-texturequerylevels"></a>

int **textureQueryLevels**( s) [🔗](#shader-func-texturequerylevels)

int **textureQueryLevels**( s) [🔗](#shader-func-texturequerylevels)

int **textureQueryLevels**( s) [🔗](#shader-func-texturequerylevels)

int **textureQueryLevels**(samplerCube s) [🔗](#shader-func-texturequerylevels)

> Compute the number of accessible mipmap levels of a texture.

> If called on an incomplete texture, or if no texture is associated with sampler, `0` is returned.

> * **param s:**
>   The sampler to which the texture whose mipmap level count will be queried is bound.
> * **return:**
>   The number of accessible mipmap levels in the texture, or `0`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureQueryLevels.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureQueryLevels.xhtml)

---

<a id="shader-func-texture"></a>

 **texture**( s, vec2 p [, float bias] ) [🔗](#shader-func-texture)

 **texture**( s, vec3 p [, float bias] ) [🔗](#shader-func-texture)

 **texture**( s, vec3 p [, float bias] ) [🔗](#shader-func-texture)

vec4 **texture**(samplerCube s, vec3 p [, float bias] ) [🔗](#shader-func-texture)

vec4 **texture**(samplerCubeArray s, vec4 p [, float bias] ) [🔗](#shader-func-texture)

vec4 **texture**(samplerExternalOES s, vec2 p [, float bias] ) [🔗](#shader-func-texture)

> Retrieves texels from a texture.

> Samples texels from the texture bound to `s` at texture coordinate `p`. An optional bias, specified in `bias` is
> included in the level-of-detail computation that is used to choose mipmap(s) from which to sample.

> For shadow forms, the last component of `p` is used as Dsub and the array layer is specified in the second to last
> component of `p`. (The second component of `p` is unused for 1D shadow lookups.)

> For non-shadow variants, the array layer comes from the last component of P.

> * **param s:**
>   The sampler to which the texture from which texels will be retrieved is bound.
> * **param p:**
>   The texture coordinates at which texture will be sampled.
> * **param bias:**
>   An optional bias to be applied during level-of-detail computation.
> * **return:**
>   A texel.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/texture.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/texture.xhtml)

---

<a id="shader-func-textureproj"></a>

 **textureProj**( s, vec3 p [, float bias] ) [🔗](#shader-func-textureproj)

 **textureProj**( s, vec4 p [, float bias] ) [🔗](#shader-func-textureproj)

 **textureProj**( s, vec4 p [, float bias] ) [🔗](#shader-func-textureproj)

> Perform a texture lookup with projection.

> The texture coordinates consumed from `p`, not including the last component of `p`, are
> divided by the last component of `p`. The resulting 3rd component of `p` in the shadow
> forms is used as Dref. After these values are computed, the texture lookup proceeds as in texture.

> * **param s:**
>   The sampler to which the texture from which texels will be retrieved is bound.
> * **param p:**
>   The texture coordinates at which texture will be sampled.
> * **param bias:**
>   Optional bias to be applied during level-of-detail computation.
> * **return:**
>   A texel.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureProj.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureProj.xhtml)

---

<a id="shader-func-texturelod"></a>

 **textureLod**( s, vec2 p, float lod) [🔗](#shader-func-texturelod)

 **textureLod**( s, vec3 p, float lod) [🔗](#shader-func-texturelod)

 **textureLod**( s, vec3 p, float lod) [🔗](#shader-func-texturelod)

vec4 **textureLod**(samplerCube s, vec3 p, float lod) [🔗](#shader-func-texturelod)

vec4 **textureLod**(samplerCubeArray s, vec4 p, float lod) [🔗](#shader-func-texturelod)

> Performs a texture lookup at coordinate `p` from the texture bound to sampler with
> an explicit level-of-detail as specified in `lod`. `lod` specifies λbase and sets the
> partial derivatives as follows:

> ```gdscript
> δu/δx=0, δv/δx=0, δw/δx=0
> δu/δy=0, δv/δy=0, δw/δy=0
> ```

> * **param s:**
>   The sampler to which the texture from which texels will be retrieved is bound.
> * **param p:**
>   The texture coordinates at which texture will be sampled.
> * **param lod:**
>   The explicit level-of-detail.
> * **return:**
>   A texel.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureLod.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureLod.xhtml)

---

<a id="shader-func-textureprojlod"></a>

 **textureProjLod**( s, vec3 p, float lod) [🔗](#shader-func-textureprojlod)

 **textureProjLod**( s, vec4 p, float lod) [🔗](#shader-func-textureprojlod)

 **textureProjLod**( s, vec4 p, float lod) [🔗](#shader-func-textureprojlod)

> Performs a texture lookup with projection from an explicitly specified level-of-detail.

> The texture coordinates consumed from P, not including the last component of `p`, are
> divided by the last component of `p`. The resulting 3rd component of `p` in the shadow
> forms is used as Dref. After these values are computed, the texture lookup proceeds as in
> textureLod<shader_func_textureLod>, with `lod` used to specify the level-of-detail from
> which the texture will be sampled.

> * **param s:**
>   The sampler to which the texture from which texels will be retrieved is bound.
> * **param p:**
>   The texture coordinates at which texture will be sampled.
> * **param lod:**
>   The explicit level-of-detail from which to fetch texels.
> * **return:**
>   a texel

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureProjLod.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureProjLod.xhtml)

---

<a id="shader-func-texturegrad"></a>

 **textureGrad**( s, vec2 p, vec2 dPdx, vec2 dPdy) [🔗](#shader-func-texturegrad)

 **textureGrad**( s, vec3 p, vec2 dPdx, vec2 dPdy) [🔗](#shader-func-texturegrad)

 **textureGrad**( s, vec3 p, vec2 dPdx, vec2 dPdy) [🔗](#shader-func-texturegrad)

vec4 **textureGrad**(samplerCube s, vec3 p, vec3 dPdx, vec3 dPdy) [🔗](#shader-func-texturegrad)

vec4 **textureGrad**(samplerCubeArray s, vec3 p, vec3 dPdx, vec3 dPdy) [🔗](#shader-func-texturegrad)

> Performs a texture lookup at coordinate `p` from the texture bound to sampler with explicit texture coordinate gradiends as specified in `dPdx` and `dPdy`. Set:
> : - `δs/δx=δp/δx` for a 1D texture, `δp.s/δx` otherwise
>   - `δs/δy=δp/δy` for a 1D texture, `δp.s/δy` otherwise
>   - `δt/δx=0.0` for a 1D texture, `δp.t/δx` otherwise
>   - `δt/δy=0.0` for a 1D texture, `δp.t/δy` otherwise
>   - `δr/δx=0.0` for a 1D or 2D texture, `δp.p/δx` otherwise
>   - `δr/δy=0.0`  for a 1D or 2D texture, `δp.p/δy` otherwise

> For the cube version, the partial derivatives of `p` are assumed to be in the coordinate system used before texture coordinates are projected onto the appropriate cube face.

> * **param s:**
>   The sampler to which the texture from which texels will be retrieved is bound.
> * **param p:**
>   The texture coordinates at which texture will be sampled.
> * **param dPdx:**
>   The partial derivative of P with respect to window x.
> * **param dPdy:**
>   The partial derivative of P with respect to window y.
> * **return:**
>   A texel.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureGrad.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureGrad.xhtml)

---

<a id="shader-func-textureprojgrad"></a>

 **textureProjGrad**( s, vec3 p, vec2 dPdx, vec2 dPdy) [🔗](#shader-func-textureprojgrad)

 **textureProjGrad**( s, vec4 p, vec2 dPdx, vec2 dPdy) [🔗](#shader-func-textureprojgrad)

 **textureProjGrad**( s, vec4 p, vec3 dPdx, vec3 dPdy) [🔗](#shader-func-textureprojgrad)

> Perform a texture lookup with projection and explicit gradients.

> The texture coordinates consumed from `p`, not including the last component of `p`, are divided by the last component of `p`.
> After these values are computed, the texture lookup proceeds as in textureGrad<shader_func_textureGrad>, passing `dPdx` and `dPdy` as gradients.

> * **param s:**
>   The sampler to which the texture from which texels will be retrieved is bound.
> * **param p:**
>   The texture coordinates at which texture will be sampled.
> * **param dPdx:**
>   The partial derivative of `p` with respect to window x.
> * **param dPdy:**
>   The partial derivative of `p` with respect to window y.
> * **return:**
>   A texel.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureProjGrad.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureProjGrad.xhtml)

---

<a id="shader-func-texelfetch"></a>

 **texelFetch**( s, ivec2 p, int lod) [🔗](#shader-func-texelfetch)

 **texelFetch**( s, ivec3 p, int lod) [🔗](#shader-func-texelfetch)

 **texelFetch**( s, ivec3 p, int lod) [🔗](#shader-func-texelfetch)

> Performs a lookup of a single texel from texture coordinate `p` in the texture bound to sampler.

> * **param s:**
>   The sampler to which the texture from which texels will be retrieved is bound.
> * **param p:**
>   The texture coordinates at which texture will be sampled.
> * **param lod:**
>   Specifies the level-of-detail within the texture from which the texel will be fetched.
> * **return:**
>   A texel.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/texelFetch.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/texelFetch.xhtml)

---

<a id="shader-func-texturegather"></a>

 **textureGather**( s, vec2 p [, int comps] ) [🔗](#shader-func-texturegather)

 **textureGather**( s, vec3 p [, int comps] ) [🔗](#shader-func-texturegather)

vec4 **textureGather**(samplerCube s, vec3 p [, int comps] ) [🔗](#shader-func-texturegather)

> Gathers four texels from a texture.

> Returns the value:

> ```gdscript
> vec4(Sample_i0_j1(p, base).comps,
>      Sample_i1_j1(p, base).comps,
>      Sample_i1_j0(p, base).comps,
>      Sample_i0_j0(p, base).comps);
> ```

> * **param s:**
>   The sampler to which the texture from which texels will be retrieved is bound.
> * **param p:**
>   The texture coordinates at which texture will be sampled.
> * **param comps:**
>   *optional* the component of the source texture (0 -> x, 1 -> y, 2 -> z, 3 -> w) that will be used to generate the resulting vector. Zero if not specified.
> * **return:**
>   The gathered texel.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureGather.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/textureGather.xhtml)

---

<a id="shader-func-dfdx"></a>

 **dFdx**( p) [🔗](#shader-func-dfdx)

> #### NOTE
> Available only in the fragment shader.

> Returns the partial derivative of `p` with respect to the window x coordinate using local differencing.

> Returns either [dFdxCoarse](#shader-func-dfdxcoarse) or [dFdxFine](#shader-func-dfdxfine).
> The implementation may choose which calculation to perform based upon factors
> such as performance or the value of the API `GL_FRAGMENT_SHADER_DERIVATIVE_HINT` hint.

> #### WARNING
> Expressions that imply higher order derivatives such as `dFdx(dFdx(n))`
> have undefined results, as do mixed-order derivatives such as `dFdx(dFdy(n))`.

> * **param p:**
>   The expression of which to take the partial derivative.

>   #### NOTE
>   It is assumed that the expression `p` is continuous and therefore expressions evaluated via non-uniform control flow may be undefined.
> * **return:**
>   The partial derivative of `p`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/dFdx.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/dFdx.xhtml)

---

<a id="shader-func-dfdxcoarse"></a>

 **dFdxCoarse**( p) [🔗](#shader-func-dfdxcoarse)

> #### NOTE
> Available only in the fragment shader.
> Not available when using the Compatibility renderer.

> Returns the partial derivative of `p` with respect to the window x coordinate.

> Calculates derivatives using local differencing based on the value of `p`
> for the current fragment's neighbors, and will possibly, but not necessarily,
> include the value for the current fragment. That is, over a given area, the
> implementation can compute derivatives in fewer unique locations than would
> be allowed for the corresponding [dFdxFine](#shader-func-dfdxfine) function.

> #### WARNING
> Expressions that imply higher order derivatives such as `dFdx(dFdx(n))`
> have undefined results, as do mixed-order derivatives such as `dFdx(dFdy(n))`.

> * **param p:**
>   The expression of which to take the partial derivative.

>   #### NOTE
>   It is assumed that the expression `p` is continuous and therefore
>   expressions evaluated via non-uniform control flow may be undefined.
> * **return:**
>   The partial derivative of `p`.

> [https://registry.khronos.org/OpenGL-Refpages/gl4/html/dFdx.xhtml](https://registry.khronos.org/OpenGL-Refpages/gl4/html/dFdx.xhtml)

---

<a id="shader-func-dfdxfine"></a>

 **dFdxFine**( p) [🔗](#shader-func-dfdxfine)

> #### NOTE
> Available only in the fragment shader.
> Not available when using the Compatibility renderer.

> Returns the partial derivative of `p` with respect to the window x coordinate.

> Calculates derivatives using local differencing based on the value of `p` for the current fragment and its immediate neighbor(s).

> #### WARNING
> Expressions that imply higher order derivatives such as `dFdx(dFdx(n))`
> have undefined results, as do mixed-order derivatives such as `dFdx(dFdy(n))`.

> * **param p:**
>   The expression of which to take the partial derivative.

>   #### NOTE
>   It is assumed that the expression `p` is continuous and therefore expressions evaluated via non-uniform control flow may be undefined.
> * **return:**
>   The partial derivative of `p`.

> [https://registry.khronos.org/OpenGL-Refpages/gl4/html/dFdx.xhtml](https://registry.khronos.org/OpenGL-Refpages/gl4/html/dFdx.xhtml)

---

<a id="shader-func-dfdy"></a>

 **dFdy**( p) [🔗](#shader-func-dfdy)

> #### NOTE
> Available only in the fragment shader.

> Returns the partial derivative of `p` with respect to the window y coordinate using local differencing.

> Returns either [dFdyCoarse](#shader-func-dfdycoarse) or [dFdyFine](#shader-func-dfdyfine).
> The implementation may choose which calculation to perform based upon factors
> such as performance or the value of the API `GL_FRAGMENT_SHADER_DERIVATIVE_HINT` hint.

> #### WARNING
> Expressions that imply higher order derivatives such as `dFdx(dFdx(n))`
> have undefined results, as do mixed-order derivatives such as `dFdx(dFdy(n))`.

> * **param p:**
>   The expression of which to take the partial derivative.

>   #### NOTE
>   It is assumed that the expression `p` is continuous and therefore expressions evaluated via non-uniform control flow may be undefined.
> * **return:**
>   The partial derivative of `p`.

> [https://registry.khronos.org/OpenGL-Refpages/gl4/html/dFdx.xhtml](https://registry.khronos.org/OpenGL-Refpages/gl4/html/dFdx.xhtml)

---

<a id="shader-func-dfdycoarse"></a>

 **dFdyCoarse**( p) [🔗](#shader-func-dfdycoarse)

> #### NOTE
> Available only in the fragment shader.
> Not available when using the Compatibility renderer.

> Returns the partial derivative of `p` with respect to the window y coordinate.

> Calculates derivatives using local differencing based on the value of `p` for the current fragment's neighbors, and will possibly,
> but not necessarily, include the value for the current fragment. That is, over a given area, the implementation can compute derivatives in fewer unique locations than
> would be allowed for the corresponding dFdyFine and dFdyFine functions.

> #### WARNING
> Expressions that imply higher order derivatives such as `dFdx(dFdx(n))` have undefined results, as do mixed-order derivatives such as `dFdx(dFdy(n))`.

> * **param p:**
>   The expression of which to take the partial derivative.

>   #### NOTE
>   It is assumed that the expression `p` is continuous and therefore expressions evaluated via non-uniform control flow may be undefined.
> * **return:**
>   The partial derivative of `p`.

> [https://registry.khronos.org/OpenGL-Refpages/gl4/html/dFdx.xhtml](https://registry.khronos.org/OpenGL-Refpages/gl4/html/dFdx.xhtml)

---

<a id="shader-func-dfdyfine"></a>

 **dFdyFine**( p) [🔗](#shader-func-dfdyfine)

> #### NOTE
> Available only in the fragment shader.
> Not available when using the Compatibility renderer.

> Returns the partial derivative of `p` with respect to the window y coordinate.

> Calculates derivatives using local differencing based on the value of `p` for the current fragment and its immediate neighbor(s).

> #### WARNING
> Expressions that imply higher order derivatives such as `dFdx(dFdx(n))` have undefined results, as do mixed-order derivatives such as `dFdx(dFdy(n))`.

> * **param p:**
>   The expression of which to take the partial derivative.

>   #### NOTE
>   It is assumed that the expression `p` is continuous and therefore expressions evaluated via non-uniform control flow may be undefined.
> * **return:**
>   The partial derivative of `p`.

> [https://registry.khronos.org/OpenGL-Refpages/gl4/html/dFdx.xhtml](https://registry.khronos.org/OpenGL-Refpages/gl4/html/dFdx.xhtml)

---

<a id="shader-func-fwidth"></a>

 **fwidth**( p) [🔗](#shader-func-fwidth)

> Returns the sum of the absolute value of derivatives in x and y.

> Uses local differencing for the input argument `p`.

> Equivalent to `abs(dFdx(p)) + abs(dFdy(p))`.

> * **param p:**
>   The expression of which to take the partial derivative.
> * **return:**
>   The partial derivative.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/fwidth.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/fwidth.xhtml)

---

<a id="shader-func-fwidthcoarse"></a>

 **fwidthCoarse**( p) [🔗](#shader-func-fwidthcoarse)

> #### NOTE
> Available only in the fragment shader.
> Not available when using the Compatibility renderer.

> Returns the sum of the absolute value of derivatives in x and y.

> Uses local differencing for the input argument p.

> Equivalent  to `abs(dFdxCoarse(p)) + abs(dFdyCoarse(p))`.

> * **param p:**
>   The expression of which to take the partial derivative.
> * **return:**
>   The partial derivative.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/fwidth.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/fwidth.xhtml)

---

<a id="shader-func-fwidthfine"></a>

 **fwidthFine**( p) [🔗](#shader-func-fwidthfine)

> #### NOTE
> Available only in the fragment shader.
> Not available when using the Compatibility renderer.

> Returns the sum of the absolute value of derivatives in x and y.

> Uses local differencing for the input argument p.

> Equivalent to `abs(dFdxFine(p)) + abs(dFdyFine(p))`.

> * **param p:**
>   The expression of which to take the partial derivative.
> * **return:**
>   The partial derivative.

> [https://registry.khronos.org/OpenGL-Refpages/gl4/html/fwidth.xhtml](https://registry.khronos.org/OpenGL-Refpages/gl4/html/fwidth.xhtml)

---

## Packing and unpacking functions

These functions convert floating-point numbers into various sized integers and
then pack those integers into a single 32bit unsigned integer. The 'unpack'
functions perform the opposite operation, returning the original
floating-point numbers.

| uint<br/><br/><br/>vec2<br/><br/>   | [packHalf2x16](#shader-func-packhalf2x16)(vec2 v)<br/><br/><br/>[unpackHalf2x16](#shader-func-unpackhalf2x16)(uint v)<br/><br/>     | Convert two 32-bit floats to 16 bit floats and pack them.                                            |
|-------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| uint<br/><br/><br/>vec2<br/><br/>   | [packUnorm2x16](#shader-func-packunorm2x16)(vec2 v)<br/><br/><br/>[unpackUnorm2x16](#shader-func-unpackunorm2x16)(uint v)<br/><br/> | Convert two normalized (range 0..1) 32-bit floats<br/>to 16-bit unsigned ints and pack them.         |
| uint<br/><br/><br/>vec2<br/><br/>   | [packSnorm2x16](#shader-func-packsnorm2x16)(vec2 v)<br/><br/><br/>[unpackSnorm2x16](#shader-func-unpacksnorm2x16)(uint v)<br/><br/> | Convert two signed normalized (range -1..1) 32-bit floats<br/>to 16-bit signed ints and pack them.   |
| uint<br/><br/><br/>vec4<br/><br/>   | [packUnorm4x8](#shader-func-packunorm4x8)(vec4 v)<br/><br/><br/>[unpackUnorm4x8](#shader-func-unpackunorm4x8)(uint v)<br/><br/>     | Convert four normalized (range 0..1) 32-bit floats<br/>into 8-bit unsigned ints and pack them.       |
| uint<br/><br/><br/>vec4<br/><br/>   | [packSnorm4x8](#shader-func-packsnorm4x8)(vec4 v)<br/><br/><br/>[unpackSnorm4x8](#shader-func-unpacksnorm4x8)(uint v)<br/><br/>     | Convert four signed normalized (range -1..1) 32-bit floats<br/>into 8-bit signed ints and pack them. |

### Packing and unpacking function descriptions

<a id="shader-func-packhalf2x16"></a>

uint **packHalf2x16**(vec2 v) [🔗](#shader-func-packhalf2x16)

> Converts two 32-bit floating-point quantities to 16-bit floating-point
> quantities and packs them into a single 32-bit integer.

> Returns an unsigned integer obtained by converting the components of a two-component floating-point vector to
> the 16-bit floating-point representation found in the OpenGL Specification, and then packing these two
> 16-bit integers into a 32-bit unsigned integer. The first vector component specifies the 16 least-significant
> bits of the result; the second component specifies the 16 most-significant bits.

> * **param v:**
>   A vector of two 32-bit floating-point values that are to be converted to 16-bit representation and packed into the result.
> * **return:**
>   The packed value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/packHalf2x16.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/packHalf2x16.xhtml)

---

<a id="shader-func-unpackhalf2x16"></a>

vec2 **unpackHalf2x16**(uint v) [🔗](#shader-func-unpackhalf2x16)

> Inverse of [packHalf2x16](#shader-func-packhalf2x16).

> Unpacks a 32-bit integer into two 16-bit floating-point values, converts them to 32-bit floating-point values, and puts them into a vector.
> The first component of the vector is obtained from the 16 least-significant bits of `v`; the second component is obtained from the
> 16 most-significant bits of `v`.

> * **param v:**
>   A single 32-bit unsigned integer containing 2 packed 16-bit floating-point values.
> * **return:**
>   Two unpacked floating-point values.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/unpackHalf2x16.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/unpackHalf2x16.xhtml)

---

<a id="shader-func-packunorm2x16"></a>

uint **packUnorm2x16**(vec2 v) [🔗](#shader-func-packunorm2x16)

> Pack floating-point values into an unsigned integer.

> Converts each component of the normalized floating-point value v into 16-bit integer values and then packs the results into a 32-bit unsigned integer.

> The conversion for component c of `v` to fixed-point is performed as follows:

> ```gdscript
> round(clamp(c, 0.0, 1.0) * 65535.0)
> ```

> The first component of the vector will be written to the least significant bits of the output; the last component will be written to the most significant bits.

> * **param v:**
>   A vector of values to be packed into an unsigned integer.
> * **return:**
>   Unsigned 32 bit integer containing the packed encoding of the vector.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/packUnorm.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/packUnorm.xhtml)

---

<a id="shader-func-unpackunorm2x16"></a>

vec2 **unpackUnorm2x16**(uint v) [🔗](#shader-func-unpackunorm2x16)

> Unpack floating-point values from an unsigned integer.

> Unpack single 32-bit unsigned integers into a pair of 16-bit unsigned integers.
> Then, each component is converted to a normalized floating-point value to generate the returned two-component vector.

> The conversion for unpacked fixed point value f to floating-point is performed as follows:

> > f / 65535.0

> The first component of the returned vector will be extracted from the least significant bits of the input; the last component will be extracted from the most significant bits.

> * **param v:**
>   An unsigned integer containing packed floating-point values.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/unpackUnorm.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/unpackUnorm.xhtml)

---

<a id="shader-func-packsnorm2x16"></a>

uint **packSnorm2x16**(vec2 v) [🔗](#shader-func-packsnorm2x16)

> Packs floating-point values into an unsigned integer.

> Convert each component of the normalized floating-point value `v` into 16-bit integer values and then packs the results into a 32-bit unsigned integer.

> The conversion for component c of `v` to fixed-point is performed as follows:

> ```gdscript
> round(clamp(c, -1.0, 1.0) * 32767.0)
> ```

> The first component of the vector will be written to the least significant bits of the output; the last component will be written to the most significant bits.

> * **param v:**
>   A vector of values to be packed into an unsigned integer.
> * **return:**
>   Unsigned 32 bit integer containing the packed encoding of the vector.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/packUnorm.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/packUnorm.xhtml)

---

<a id="shader-func-unpacksnorm2x16"></a>

vec2 **unpackSnorm2x16**(uint v) [🔗](#shader-func-unpacksnorm2x16)

> Unpacks floating-point values from an unsigned integer.

> Unpacks single 32-bit unsigned integers into a pair of 16-bit signed integers.
> Then, each component is converted to a normalized floating-point value to generate the returned two-component vector.

> The conversion for unpacked fixed point value f to floating-point is performed as follows:

> > clamp(f / 32727.0, -1.0, 1.0)

> The first component of the returned vector will be extracted from the least significant bits of the input; the last component will be extracted from the most significant bits.

> * **param v:**
>   An unsigned integer containing packed floating-point values.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/unpackUnorm.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/unpackUnorm.xhtml)

---

<a id="shader-func-packunorm4x8"></a>

uint **packUnorm4x8**(vec4 v) [🔗](#shader-func-packunorm4x8)

> Packs floating-point values into an unsigned integer.

> Converts each component of the normalized floating-point value `v` into 16-bit integer values and then packs the results into a 32-bit unsigned integer.

> The conversion for component c of `v` to fixed-point is performed as follows:

> ```gdscript
> round(clamp(c, 0.0, 1.0) * 255.0)
> ```

> The first component of the vector will be written to the least significant bits of the output; the last component will be written to the most significant bits.

> * **param v:**
>   A vector of values to be packed into an unsigned integer.
> * **return:**
>   Unsigned 32 bit integer containing the packed encoding of the vector.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/packUnorm.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/packUnorm.xhtml)

---

<a id="shader-func-unpackunorm4x8"></a>

vec4 **unpackUnorm4x8**(uint v) [🔗](#shader-func-unpackunorm4x8)

> Unpacks floating-point values from an unsigned integer.

> Unpacks single 32-bit unsigned integers into four 8-bit unsigned integers.
> Then, each component is converted to a normalized floating-point value to generate the returned four-component vector.

> The conversion for unpacked fixed point value f to floating-point is performed as follows:

> > f / 255.0

> The first component of the returned vector will be extracted from the least significant bits of the input; the last component will be extracted from the most significant bits.

> * **param v:**
>   An unsigned integer containing packed floating-point values.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/unpackUnorm.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/unpackUnorm.xhtml)

---

<a id="shader-func-packsnorm4x8"></a>

uint **packSnorm4x8**(vec4 v) [🔗](#shader-func-packsnorm4x8)

> Packs floating-point values into an unsigned integer.

> Convert each component of the normalized floating-point value `v` into 16-bit integer values and then packs the results into a 32-bit unsigned integer.

> The conversion for component c of `v` to fixed-point is performed as follows:

> ```gdscript
> round(clamp(c, -1.0, 1.0) * 127.0)
> ```

> The first component of the vector will be written to the least significant bits of the output; the last component will be written to the most significant bits.

> * **param v:**
>   A vector of values to be packed into an unsigned integer.
> * **return:**
>   Unsigned 32 bit integer containing the packed encoding of the vector.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/packUnorm.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/packUnorm.xhtml)

---

<a id="shader-func-unpacksnorm4x8"></a>

vec4 **unpackSnorm4x8**(uint v) [🔗](#shader-func-unpacksnorm4x8)

> Unpack floating-point values from an unsigned integer.

> Unpack single 32-bit unsigned integers into four 8-bit signed integers.
> Then, each component is converted to a normalized floating-point value to generate the returned four-component vector.

> The conversion for unpacked fixed point value f to floating-point is performed as follows:

> > clamp(f / 127.0, -1.0, 1.0)

> The first component of the returned vector will be extracted from the least significant bits of the input; the last component will be extracted from the most significant bits.

> * **param v:**
>   An unsigned integer containing packed floating-point values.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/unpackUnorm.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/unpackUnorm.xhtml)

---

## Bitwise functions

| <br/><br/><br/>   | [bitfieldExtract](#shader-func-bitfieldextract)( value, int offset, int bits)<br/><br/><br/>[bitfieldExtract](#shader-func-bitfieldextract)( value, int offset, int bits)<br/><br/>             | Extracts a range of bits from an integer.                                     |
|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| <br/><br/><br/>   | [bitfieldInsert](#shader-func-bitfieldinsert)( base,  insert, int offset, int bits)<br/><br/><br/>[bitfieldInsert](#shader-func-bitfieldinsert)( base,  insert, int offset, int bits)<br/><br/> | Insert a range of bits into an integer.                                       |
| <br/><br/><br/>   | [bitfieldReverse](#shader-func-bitfieldreverse)( value)<br/><br/><br/>[bitfieldReverse](#shader-func-bitfieldreverse)( value)<br/><br/>                                                         | Reverse the order of bits in an integer.                                      |
| <br/><br/><br/>   | [bitCount](#shader-func-bitcount)( value)<br/><br/><br/>[bitCount](#shader-func-bitcount)( value)<br/><br/>                                                                                     | Counts the number of 1 bits in an integer.                                    |
| <br/><br/><br/>   | [findLSB](#shader-func-findlsb)( value)<br/><br/><br/>[findLSB](#shader-func-findlsb)( value)<br/><br/>                                                                                         | Find the index of the least significant bit set to 1 in an integer.           |
| <br/><br/><br/>   | [findMSB](#shader-func-findmsb)( value)<br/><br/><br/>[findMSB](#shader-func-findmsb)( value)<br/><br/>                                                                                         | Find the index of the most significant bit set to 1 in an integer.            |
| <br/><br/><br/>   | [imulExtended](#shader-func-imulextended)( x,  y, out  msb, out  lsb)<br/><br/><br/>[umulExtended](#shader-func-umulextended)( x,  y, out  msb, out  lsb)<br/><br/>                             | Multiplies two 32-bit numbers and produce a 64-bit result.                    |
|                   | [uaddCarry](#shader-func-uaddcarry)( x,  y, out  carry)                                                                                                                                         | Adds two unsigned integers and generates carry.                               |
|                   | [usubBorrow](#shader-func-usubborrow)( x,  y, out  borrow)                                                                                                                                      | Subtracts two unsigned integers and generates borrow.                         |
|                   | [ldexp](#shader-func-ldexp)( x, out  exp)                                                                                                                                                       | Assemble a floating-point number from a value and exponent.                   |
|                   | [frexp](#shader-func-frexp)( x, out  exp)                                                                                                                                                       | Splits a floating-point number (`x`) into significand integral<br/>components |

### Bitwise function descriptions

<a id="shader-func-bitfieldextract"></a>

 **bitfieldExtract**( value, int offset, int bits) [🔗](#shader-func-bitfieldextract)

> Extracts a subset of the bits of `value` and returns it in the least significant bits of the result.
> The range of bits extracted is `[offset, offset + bits - 1]`.

> The most significant bits of the result will be set to zero.

> #### NOTE
> If bits is zero, the result will be zero.

> #### WARNING
> The result will be undefined if:

> - offset or bits is negative.
> - if the sum of offset and bits is greater than the number of bits used to store the operand.

> * **param value:**
>   The integer from which to extract bits.
> * **param offset:**
>   The index of the first bit to extract.
> * **param bits:**
>   The number of bits to extract.
> * **return:**
>   Integer with the requested bits.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/bitfieldExtract.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/bitfieldExtract.xhtml)

---

 **bitfieldExtract**( value, int offset, int bits) [🔗](#shader-func-bitfieldextract)

> [Component-wise Function](#shading-componentwise).

> Extracts a subset of the bits of `value` and returns it in the least significant bits of the result.
> The range of bits extracted is `[offset, offset + bits - 1]`.

> The most significant bits will be set to the value of `offset + base - 1` (i.e., it is sign extended to the width of the return type).

> #### NOTE
> If bits is zero, the result will be zero.

> #### WARNING
> The result will be undefined if:

> - offset or bits is negative.
> - if the sum of offset and bits is greater than the number of bits used to store the operand.

> * **param value:**
>   The integer from which to extract bits.
> * **param offset:**
>   The index of the first bit to extract.
> * **param bits:**
>   The number of bits to extract.
> * **return:**
>   Integer with the requested bits.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/bitfieldExtract.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/bitfieldExtract.xhtml)

---

<a id="shader-func-bitfieldinsert"></a>

 **bitfieldExtract**( value, int offset, int bits) [🔗](#shader-func-bitfieldinsert)

 **bitfieldInsert**( base,  insert, int offset, int bits) [🔗](#shader-func-bitfieldinsert)

> [Component-wise Function](#shading-componentwise).

> Inserts the `bits` least significant bits of `insert` into `base` at offset `offset`.

> The returned value will have bits [offset, offset + bits + 1] taken from [0, bits - 1] of `insert` and
> all other bits taken directly from the corresponding bits of base.

> #### NOTE
> If bits is zero, the result will be the original value of base.

> #### WARNING
> The result will be undefined if:

> - offset or bits is negative.
> - if the sum of offset and bits is greater than the number of bits used to store the operand.

> * **param base:**
>   The integer into which to insert `insert`.
> * **param insert:**
>   The value of the bits to insert.
> * **param offset:**
>   The index of the first bit to insert.
> * **param bits:**
>   The number of bits to insert.
> * **return:**
>   `base` with inserted bits.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/bitfieldInsert.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/bitfieldInsert.xhtml)

---

<a id="shader-func-bitfieldreverse"></a>

 **bitfieldReverse**( value) [🔗](#shader-func-bitfieldreverse)

 **bitfieldReverse**( value) [🔗](#shader-func-bitfieldreverse)

> [Component-wise Function](#shading-componentwise).

> Reverse the order of bits in an integer.

> The bit numbered `n` will be taken from bit `(bits - 1) - n` of `value`, where bits is the total number of bits used to represent `value`.

> * **param value:**
>   The value whose bits to reverse.
> * **return:**
>   `value` but with its bits reversed.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/bitfieldReverse.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/bitfieldReverse.xhtml)

---

<a id="shader-func-bitcount"></a>

 **bitCount**( value) [🔗](#shader-func-bitcount)

 **bitCount**( value) [🔗](#shader-func-bitcount)

> [Component-wise Function](#shading-componentwise).

> Counts the number of 1 bits in an integer.

> * **param value:**
>   The value whose bits to count.
> * **return:**
>   The number of bits that are set to 1 in the binary representation of `value`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/bitCount.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/bitCount.xhtml)

---

<a id="shader-func-findlsb"></a>

 **findLSB**( value) [🔗](#shader-func-findlsb)

 **findLSB**( value) [🔗](#shader-func-findlsb)

> [Component-wise Function](#shading-componentwise).

> Find the index of the least significant bit set to `1`.

> #### NOTE
> If `value` is zero, `-1` will be returned.

> * **param value:**
>   The value whose bits to scan.
> * **return:**
>   The bit number of the least significant bit that is set to 1 in the binary representation of value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/findLSB.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/findLSB.xhtml)

---

<a id="shader-func-findmsb"></a>

 **findMSB**( value) [🔗](#shader-func-findmsb)

 **findMSB**( value) [🔗](#shader-func-findmsb)

> [Component-wise Function](#shading-componentwise).

> Find the index of the most significant bit set to 1.

> #### NOTE
> For signed integer types, the sign bit is checked first and then:
> : - For positive integers, the result will be the bit number of the most significant bit that is set to 1.
>   - For negative integers, the result will be the bit number of the most significant bit set to 0.

> #### NOTE
> For a value of zero or negative 1, -1 will be returned.

> * **param value:**
>   The value whose bits to scan.
> * **return:**
>   The bit number of the most significant bit that is set to 1 in the binary representation of value.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/findMSB.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/findMSB.xhtml)

---

<a id="shader-func-imulextended"></a>

 **imulExtended**( x,  y, out  msb, out  lsb) [🔗](#shader-func-imulextended)

> [Component-wise Function](#shading-componentwise).

> Perform 32-bit by 32-bit signed multiplication to produce a 64-bit result.

> The 32 least significant bits of this product are returned in `lsb` and the 32 most significant bits are returned in `msb`.

> * **param x:**
>   The first multiplicand.
> * **param y:**
>   The second multiplicand.
> * **param msb:**
>   The variable to receive the most significant word of the product.
> * **param lsb:**
>   The variable to receive the least significant word of the product.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/umulExtended.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/umulExtended.xhtml)

---

<a id="shader-func-umulextended"></a>

 **umulExtended**( x,  y, out  msb, out  lsb) [🔗](#shader-func-umulextended)

> [Component-wise Function](#shading-componentwise).

> Perform 32-bit by 32-bit unsigned multiplication to produce a 64-bit result.

> The 32 least significant bits of this product are returned in `lsb` and the 32 most significant bits are returned in `msb`.

> * **param x:**
>   The first multiplicand.
> * **param y:**
>   The second multiplicand.
> * **param msb:**
>   The variable to receive the most significant word of the product.
> * **param lsb:**
>   The variable to receive the least significant word of the product.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/umulExtended.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/umulExtended.xhtml)

---

<a id="shader-func-uaddcarry"></a>

 **uaddCarry**( x,  y, out  carry) [🔗](#shader-func-uaddcarry)

> [Component-wise Function](#shading-componentwise).

> Add unsigned integers and generate carry.

> adds two 32-bit unsigned integer variables (scalars or vectors) and generates a 32-bit unsigned integer result, along with a carry output.
> The value carry is .

> * **param x:**
>   The first operand.
> * **param y:**
>   The second operand.
> * **param carry:**
>   0 if the sum is less than 2<sub>32</sub>, otherwise 1.
> * **return:**
>   `(x + y) % 2^32`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/uaddCarry.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/uaddCarry.xhtml)

---

<a id="shader-func-usubborrow"></a>

 **usubBorrow**( x,  y, out  borrow) [🔗](#shader-func-usubborrow)

> [Component-wise Function](#shading-componentwise).

> Subtract unsigned integers and generate borrow.

> * **param x:**
>   The first operand.
> * **param y:**
>   The second operand.
> * **param borrow:**
>   `0` if `x >= y`, otherwise `1`.
> * **return:**
>   The difference of `x` and `y` if non-negative, or 2<sub>32</sub> plus that difference otherwise.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/usubBorrow.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/usubBorrow.xhtml)

---

<a id="shader-func-ldexp"></a>

 **ldexp**( x, out  exp) [🔗](#shader-func-ldexp)

> [Component-wise Function](#shading-componentwise).

> Assembles a floating-point number from a value and exponent.

> #### WARNING
> If this product is too large to be represented in the floating-point
> type, the result is undefined.

> * **param x:**
>   The value to be used as a source of significand.
> * **param exp:**
>   The value to be used as a source of exponent.
> * **return:**
>   `x * 2^exp`

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/ldexp.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/ldexp.xhtml)

---

<a id="shader-func-frexp"></a>

 **frexp**( x, out  exp) [🔗](#shader-func-frexp)

> [Component-wise Function](#shading-componentwise).

> Extracts `x` into a floating-point significand in the range `[0.5, 1.0)` and in integral exponent of two, such that:

> ```gdscript
> x = significand * 2 ^ exponent
> ```

> For a floating-point value of zero, the significand and exponent are both zero.

> #### WARNING
> For a floating-point value that is an infinity or a floating-point NaN, the results are undefined.

> * **param x:**
>   The value from which significand and exponent are to be extracted.
> * **param exp:**
>   The variable into which to place the exponent of `x`.
> * **return:**
>   The significand of `x`.

> [https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/frexp.xhtml](https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/frexp.xhtml)

---
