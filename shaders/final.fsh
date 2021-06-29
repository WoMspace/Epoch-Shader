#version 120

#extension GL_ARB_shader_texture_lod : enable
#define FSH

/*
==== FINAL:ANTI-ALIASING ====
- FXAA
- TAA
*/

#include "lib/settings.glsl"

uniform sampler2D colortex0;
const bool colortex0MipmapEnabled = true;
uniform sampler2D colortex5;
const bool colortex5Clear = false;
uniform float viewWidth;
uniform float viewHeight;

varying vec2 texcoord;

#include "lib/antialiasing.glsl"

void main()
{
	vec3 color = texture2D(colortex0, texcoord).rgb;
	#if AA_MODE == AA_FXAA
		color = doFXAA(color);
	#elif AA_MODE == AA_TAA
	#endif



	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0);
}