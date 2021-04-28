float getFragDepth(sampler2D depthTex, vec2 texcoord)
{
	float depth = texture2D(depthTex, texcoord).r;
	depth = pow(far+1,depth)-1;
	return depth;
}

float getCursorDepth()
{
	return pow(far+1,centerDepthSmooth)-1;
}

float getRoundFragDepth(sampler2D depthTex, vec2 texcoord)
{
	vec3 screenPos = vec3(texcoord, texture2D(depthTex, texcoord).r);
	vec3 clipPos = screenPos * 2.0 - 1.0;
	vec4 tmp = gbufferProjectionInverse * vec4(clipPos, 1.0);
	vec3 viewPos = tmp.xyz / tmp.w;
	return length(viewPos);
}