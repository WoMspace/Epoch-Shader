#version 120

#define VSH

#include "lib/settings.glsl"

uniform int frameCounter;

varying vec2 texcoord;

#include "lib/antialiasing.glsl"

void main()
{
	gl_Position = ftransform();
	#if AA_MODE == AA_TAA
	//gl_Position.xy += doVertexTAA();
	#endif
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}