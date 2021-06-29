#ifdef FSH
struct LumaData
{
	float m, n, e, s, w;
	float ne, nw, se, sw;
	float highest, lowest, contrast;
};

vec3 doFXAA(vec3 color)
{
	vec2 PixelOffset = vec2(1.0 / viewWidth, 1.0 / viewHeight);
	LumaData l;
	l.m = texture2D(colortex0, texcoord).a;
	l.n = texture2D(colortex0, texcoord + vec2(0.0, PixelOffset.y)).a;
	l.e = texture2D(colortex0, texcoord + vec2(PixelOffset.x, 0.0)).a;
	l.s = texture2D(colortex0, texcoord + vec2(0.0, -PixelOffset.y)).a;
	l.w = texture2D(colortex0, texcoord + vec2(-PixelOffset.x, 0.0)).a;


	l.highest = max(l.n, max(l.e, max(l.s, l.w)));
	l.lowest = min(l.n, min(l.e, min(l.s, l.w)));
	l.contrast = l.highest - l.lowest;

	float contrastThreshold = 0.0312;
	float relativeThreshold = 0.25;
	if(l.contrast < relativeThreshold * l.highest)
	{
		//skip pixel
	}
	else
	{
		l.ne = texture2D(colortex0, texcoord + vec2(PixelOffset.x, PixelOffset.y)).a;
		l.se = texture2D(colortex0, texcoord + vec2(PixelOffset.x, -PixelOffset.y)).a;
		l.sw = texture2D(colortex0, texcoord + vec2(-PixelOffset.x, -PixelOffset.y)).a;
		l.nw = texture2D(colortex0, texcoord + vec2(-PixelOffset.x, PixelOffset.y)).a;
		float filter = 2.0 * (l.n + l.e + l.s + l.w);
		filter += l.ne + l.se + l.sw + l.nw;
		filter *= 1.0 / 12.0;
		filter = abs(filter - l.m);
		filter = clamp(filter / l.contrast, 0.0, 1.0);
		float blendFactor = smoothstep(0.0, 1.0, filter);
		blendFactor *= blendFactor;

		float horizontal =
			abs(l.n + l.s - 2 * l.m) * 2 +
			abs(l.ne + l.se - 2 * l.e) +
			abs(l.nw + l.sw - 2 * l.w);
		float vertical =
			abs(l.e + l.w - 2 * l.m) * 2 +
			abs(l.ne + l.nw - 2 * l.n) +
			abs(l.se + l.sw - 2 * l.s);
		bool isHorizontal = horizontal >= vertical;
		float pixelStep = isHorizontal ? PixelOffset.x : PixelOffset.y;
		float pLuma = isHorizontal ? l.n : l.e;
		float nLuma = isHorizontal ? l.s : l.w;
		float pGradient = abs(pLuma - l.m);
		float nGradient = abs(nLuma - l.m);
		if(pGradient < nGradient)
		{
			pixelStep = -pixelStep;
		}

		vec2 uv = texcoord;
		if(isHorizontal)
		{
			uv.y += pixelStep * blendFactor;
		}
		else
		{
			uv.x += pixelStep * blendFactor;
		}
		color = texture2DLod(colortex0, uv, 0.0).rgb;
	}
	return color;
}

// vec3 doTAA(vec3 color)
// {
// 	vec3 temporalBuffer = texture2D(colortex5, texcoord).rgb;
// 	color = mix(color, temporalBuffer, 0.99);
// 	return color;
// }
#endif
#ifdef VSH
vec2 doVertexTAA()
{
	return vec2(sin(frameCounter), cos(frameCounter)) * 0.01;
}
#endif