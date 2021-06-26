#include "bokeh/bokeh.glsl"

vec3 mipBlur(float blurAmount, sampler2D colortex)
{
	return texture2DLod(colortex, texcoord, clamp(blurAmount * 0.5 * gbufferProjection[1].y,0.0, 7.0)).rgb;
}

float hPixelOffset = 1/viewWidth;
float vPixelOffset = 1/viewHeight;

vec3 onionRingBokeh(float blurAmount, sampler2D colortex) //adds the harsher edges to the bokeh.
{
	vec3 retColor = vec3(0.0);
	for(int i = 0; i < DOF_BOKEH_SAMPLES; i++)
	{
		float angle = (360.0 / DOF_BOKEH_SAMPLES) * i;
		float polarDistance = blurAmount;
		float hOffset = polarDistance * sin(angle) * hPixelOffset * (1.0/DOF_ANAMORPHIC);
		float vOffset = polarDistance * cos(angle) * vPixelOffset * DOF_ANAMORPHIC;
		retColor += texture2D(colortex, vec2(hOffset + texcoord.x, vOffset + texcoord.y)).rgb;
	}
	return retColor / DOF_BOKEH_SAMPLES;
}

vec3 bokehBlur(float blurAmount, sampler2D colortex) //simple and pretty fast bokeh blur.
{
	blurAmount *= gbufferProjection[1].y;
	vec3 retColor = vec3(0.0);
	for(int i = 0; i < DOF_BOKEH_SAMPLES; i++)
	{
		float hOffset = texcoord.x + bokehOffsets[i].x * hPixelOffset * blurAmount * (1.0 / DOF_ANAMORPHIC);
		float vOffset = texcoord.y + bokehOffsets[i].y * vPixelOffset * blurAmount * DOF_ANAMORPHIC;
		#ifdef DOF_BOKEH_MIPMAP
		retColor += texture2DLod(colortex, vec2(hOffset, vOffset), blurAmount / 50.0).rgb;
		#else
		retColor += texture2D(colortex, vec2(hOffset, vOffset)).rgb;
		#endif
	}
	retColor /= DOF_BOKEH_SAMPLES;
	#ifdef DOF_BOKEH_ONIONRING
		retColor += onionRingBokeh(blurAmount, colortex);
		retColor *= 0.5;
	#endif
	return retColor;
}

vec3 gaussianBloom(sampler2D colortex, vec2 uv)
{
	//small pass. fastest.
	vec3 pass1 = vec3(0.0);
	for(int i = 0; i < 9; i++)
	{
		vec2 offset = uv;
		#ifdef GAUSSIAN_HORIZONTAL
		offset.x += float(i - 5) * hPixelOffset;
		#else
		offset.y += float(i - 5) * vPixelOffset;
		#endif

		pass1 += texture2D(colortex, offset).rgb * bloomKernelSmall[i];
	}
	vec3 pass2 = vec3(0.0);
	#if BLOOM_QUALITY >= 2
	for(int i = 0; i < 39; i++)
	{
		vec2 offset = uv;
		#ifdef GAUSSIAN_HORIZONTAL
		offset.x += float(i - 20) * hPixelOffset;
		#else
		offset.y += float(i - 520) * vPixelOffset;
		#endif

		pass2 += texture2D(colortex, offset).rgb * bloomKernelMedium[i];
	}
	#endif
	vec3 pass3 = vec3(0.0);
	#if BLOOM_QUALITY >=3
	for(int i = 0; i < 201; i++)
	{
		vec2 offset = uv;
		#ifdef GAUSSIAN_HORIZONTAL
		offset.x += float(i - 101) * hPixelOffset;
		#else
		offset.y += float(i - 101) * vPixelOffset;
		#endif

		pass3 += texture2D(colortex, offset).rgb * bloomKernelSmall[i];
	}
	#endif
	vec3 retColor = pass1 + pass2 + pass3;
	//retColor *= 30.0;
	return retColor;
}