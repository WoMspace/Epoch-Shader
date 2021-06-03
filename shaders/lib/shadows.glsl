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


#ifdef VSH
vec4 calculateShadowUV(mat4 gbufferModelViewInverse, mat4 shadowProjection, mat4 shadowModelView)
{
	vec4 viewPos = gl_ModelViewMatrix * gl_Vertex;
	vec4 playerPos = gbufferModelViewInverse * viewPos;
	vec4 shadowPos = shadowProjection * (shadowModelView * playerPos);
	shadowPos = shadowPos / shadowPos.w;
	float distortionFactor = getDistortionFactor(shadowPos.xy);
	shadowPos.xy = distort(shadowPos.xy, distortionFactor);
	shadowPos.xyz = shadowPos.xyz * 0.5 + 0.5;
	shadowPos.z -= SHADOW_BIAS; // * (distortionFactor * distortionFactor) / abs(lightDot);
	return shadowPos;
}
#endif

#ifdef FSH
vec3 calculateShadows(sampler2D shadowtex0, vec4 shadowPos)
{
	float sampleDepth = texture2D(shadowtex0, shadowPos.xy).r;
	if(sampleDepth < shadowPos.z)
	{
		return vec3(0.5);
	}
	else return vec3(1.0);
}
#endif