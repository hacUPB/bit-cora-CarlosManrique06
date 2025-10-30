
Vertex

```cpp
OF_GLSL_SHADER_HEADER

// these are for the programmable pipeline system


uniform mat4 modelViewProjectionMatrix;
in vec4 position;

uniform float mouseRange;
uniform vec2 mousePos;

void main()
{
    vec4 pos = position;
    vec2 dir = mousePos - pos.xy; 
    float dist = distance(pos.xy, mousePos);

    if (dist > 0.0 && dist < mouseRange) {
        float distNorm = dist / mouseRange;
        distNorm = 1.0 - distNorm;
        dir *= distNorm * 0.5;
        pos.x += dir.x;
        pos.y += dir.y;
    }

    gl_Position = modelViewProjectionMatrix * pos;
}


```

Frag

```cpp
OF_GLSL_SHADER_HEADER


out vec4 outputColor;
uniform vec4 mouseColor;
uniform vec2 mousePos;

void main()
{
   
    float factor = gl_FragCoord.y / 600.0;
    outputColor = vec4(mouseColor.rgb * factor, 1.0);
}


```