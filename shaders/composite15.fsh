#version 120

#include "lib/settings.glsl"
const int RGBA16F = 0;

uniform sampler2D colortex0;
const bool colortex0MipmapEnabled = true;
const int colortex0Format = RGBA16F;
const int colortex1Format = RGBA16F;
const bool colortex1Clear = false;
uniform sampler2D colortex1;
uniform float frameTime;
varying vec2 texcoord;

#include "lib/tonemapping.glsl"
#include "lib/color.glsl"
#include "lib/maths.glsl"

void main()
{
	vec3 color;
	#ifdef CHROMATIC_ABERRATION_ENABLED
	vec2 uvGreen = clip(texcoord);
	vec2 uvBlue = uvGreen;
	uvGreen *= 1.0 + CHROMATIC_ABERRATION_STRENGTH;
	uvBlue *= CHROMATIC_ABERRATION_STRENGTH * 2.0 + 1.0;
	uvGreen = unclip(uvGreen);
	uvBlue = unclip(uvBlue);
	color.r = texture2D(colortex0, texcoord).r;
	color.g = texture2D(colortex0, uvGreen).g;
	color.b = texture2D(colortex0, uvBlue).b;
	#else
	color = texture2D(colortex0, texcoord).rgb;
	#endif

	vec3 exposureSamples = texture2DLod(colortex0, vec2(0.5), 8.0).rgb;
	exposureSamples += texture2DLod(colortex0, vec2(0.5), 10.0).rgb;
	exposureSamples /= 2.0;
	float screenLuminance = dot(vec3(1.0), exposureSamples) * HDR_EXPOSURE_VALUE;
	float temporalLuminance = texture2D(colortex1, vec2(0.5)).a;
	temporalLuminance = clamp(mix(temporalLuminance, screenLuminance, frameTime * 3.0), HDR_EXPOSURE_MAXIMUM, HDR_EXPOSURE_MINIMUM);
	float screenExposure = 1.0 / temporalLuminance;

	color = tonemapSelector(color * screenExposure * 0.35);

	vec3 color1 = texture2D(colortex1, texcoord).rgb;

	/* DRAWBUFFERS:01 */
	gl_FragData[0] = vec4(color, 1.0);
	gl_FragData[1] = vec4(color1, temporalLuminance);
}