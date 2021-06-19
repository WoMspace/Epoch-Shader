#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.rgb = srgbToLinear(color.rgb);
	float normalDarkness = getNormals(normalmap, gbufferModelViewInverse, shadowLightPosition, tbn);
	#if !defined(MOLLY_LIT_TRANSLUCENTS_ENABLED) && defined(SHADOWS_ENABLED)
	color.rgb = applyLightmap(color.rgb, lmcoord, skyColor, worldTime, calculateShadows(shadowtex0, shadowPos), normalDarkness, gbufferModelView, sunPosition).rgb;
	#elif defined(MOLLY_LIT_TRANSLUCENTS_ENABLED)
	#else
	color.rgb = applyLightmap(color.rgb, lmcoord, skyColor, worldTime, 1.0, normalDarkness, gbufferModelView, sunPosition).rgb;
	#endif
	//color.a *= 1.25;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}