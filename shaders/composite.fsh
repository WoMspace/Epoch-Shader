#version 120

/*
==== COMPOSITE0:WORLD ====
- Fog
*/

#include "lib/settings.glsl"

uniform sampler2D colortex0;
uniform sampler2D depthtex0;

varying vec2 texcoord;

#include "lib/depth.glsl"
#include "lib/fog.glsl"

void main()
{
    vec3 color = texture2D(colortex0, texcoord).rgb;

    #ifdef SHADER_FOG_ENABLED
    color = doFog(getRoundFragDepth(depthtex0, texcoord), color);
    #endif

    /* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4(color, 1.0);
}