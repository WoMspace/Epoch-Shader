vec3 doFog(float depth, vec3 color)
{
	float viewPos = getRoundFragDepth(depthtex0, texcoord);
	vec3 customFogColor;
	float fogNearValue;
	float fogFarValue;

	if(isEyeInWater == 0) //air
	{
		customFogColor = fogColor;
		fogNearValue = FOG_NEAR;
		fogFarValue = FOG_END;
	}
	else if(isEyeInWater == 1) //water
	{
		customFogColor = vec3(WATER_FOG_R, WATER_FOG_G, WATER_FOG_B);
		fogNearValue = 0.0;
		fogFarValue = WATER_FOG_DISTANCE;
	}
	else if(isEyeInWater == 2) //lava
	{
		customFogColor = vec3(LAVA_FOG_R, LAVA_FOG_G, LAVA_FOG_B);
		fogNearValue = 0.0;
		fogFarValue = LAVA_FOG_DISTANCE;
	}
	if(texture2D(depthtex0, texcoord).r != 1.0)
	{
		color = mix(color, customFogColor, clamp(((length(viewPos)-fogNearValue)/fogFarValue), 0.0, 1.0));
	}
	return color;
}