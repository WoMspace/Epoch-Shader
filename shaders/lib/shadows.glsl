#include "bokeh.glsl"
float getDistortionFactor(vec2 uv)
{
	return pow(abs(uv.x * uv.x * uv.x) + abs(uv.y * uv.y * uv.y), 1.0 / 3.0) + SHADOW_DISTORTION_FACTOR;
}

vec2 distort(vec2 uv, float factor)
{
	return vec2(uv / factor);
}
vec2 distort(vec2 uv)
{
	return distort(uv, getDistortionFactor(uv));
}

float InterleavedGradientNoise(vec2 p) { //Thanks Tech!
    vec3 magic = vec3(0.06711056, 0.00583715, 52.9829189);
    return fract(magic.z * fract(dot(p, magic.xy)));
}

mat2 rotate(float angle){
    return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

#ifdef VSH
vec4 calculateShadowUV()
{
	vec4 viewPos = gl_ModelViewMatrix * gl_Vertex;
	vec4 playerPos = gbufferModelViewInverse * viewPos;
	vec4 shadowPos = shadowProjection * (shadowModelView * playerPos);
	shadowPos = shadowPos / shadowPos.w;
	float distortionFactor = getDistortionFactor(shadowPos.xy);
	shadowPos.xy = distort(shadowPos.xy, distortionFactor);
	shadowPos.xyz = shadowPos.xyz * 0.5 + 0.5;
	shadowPos.z -= SHADOW_BIAS * (distortionFactor * distortionFactor); // / abs(lightDot);
	return shadowPos;
}
#endif

#ifdef FSH
float calculateShadows(sampler2D shadowtex0, vec4 shadowPos)
{
	#ifdef SHADOW_FILTER_ENABLED
		float shadow = 1.0;
		mat2 sampleRotation = rotate(InterleavedGradientNoise(gl_FragCoord.xy) * pi * 2.0);
		for(int i = 0; i < SHADOW_FILTER_SAMPLES; i++)
		{
			float sampleDepth = texture2D(shadowtex0, 0.001 * (sampleRotation * shadowFilterSamples[i]) + shadowPos.xy).r;
			if(sampleDepth < shadowPos.z)
			{
				shadow -= shadow_sample_darkness;
			}
		}
		return shadow;
	#else
		float sampleDepth = texture2D(shadowtex0, shadowPos.xy).r;
		if(sampleDepth < shadowPos.z)
		{
			return 0.0;
		}
		else return 1.0;
	#endif
}
#endif