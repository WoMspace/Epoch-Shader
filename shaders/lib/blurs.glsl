#include "bokeh.glsl"

vec3 mipBlur(float blurAmount)
{
	return texture2DLod(colortex0, texcoord, clamp(blurAmount * 0.5 * gbufferProjection[1].y,0.0, 7.0)).rgb;
}

float hPixelOffset = 1/viewWidth;
float vPixelOffset = 1/viewHeight;

vec3 onionRingBokeh(float blurAmount) //adds the harsher edges to the bokeh.
{
	vec3 retColor = vec3(0.0);
	for(int i = 0; i < DOF_BOKEH_SAMPLES; i++)
	{
		float angle = (360.0 / DOF_BOKEH_SAMPLES) * i;
		float polarDistance = blurAmount;
		float hOffset = polarDistance * sin(angle) * hPixelOffset * (1.0/DOF_ANAMORPHIC);
		float vOffset = polarDistance * cos(angle) * vPixelOffset * DOF_ANAMORPHIC;
		retColor += texture2D(colortex0, vec2(hOffset + texcoord.x, vOffset + texcoord.y)).rgb;
	}
	return retColor / DOF_BOKEH_SAMPLES;
}

vec3 bokehBlur(float blurAmount) //simple and pretty fast bokeh blur.
{
	blurAmount *= gbufferProjection[1].y;
	vec3 retColor = vec3(0.0);
	for(int i = 0; i < DOF_BOKEH_SAMPLES; i++)
	{
		float hOffset = texcoord.x + bokehOffsets[i].x * hPixelOffset * blurAmount * (1.0 / DOF_ANAMORPHIC);
		float vOffset = texcoord.y + bokehOffsets[i].y * vPixelOffset * blurAmount * DOF_ANAMORPHIC;
		#ifdef DOF_BOKEH_MIPMAP
		retColor += texture2DLod(colortex0, vec2(hOffset, vOffset), blurAmount / 50.0).rgb;
		#else
		retColor += texture2D(colortex0, vec2(hOffset, vOffset)).rgb;
		#endif
	}
	retColor /= DOF_BOKEH_SAMPLES;
	#ifdef DOF_BOKEH_ONIONRING
		retColor += onionRingBokeh(blurAmount);
		retColor *= 0.5;
	#endif
	return retColor;
}


// vec3 gaussianHorizontal(sampler2D colortex, vec2 uv, float blurAmount)
// {
// 	vec2 onePixel = vec2(1.0 / viewWidth, 1.0 / viewHeight);
// 	vec3 retColor = vec3(0.0);
// 	float offset = 0.0;
// 	for(int i = -16; i < 16; i++)
// 	{
// 		offset = float(i) * onePixel.x + uv.x;
// 		retColor += texture2D(colortex, vec2(offset * blurAmount, uv.y)).rgb / gaussianKernel2[i];
// 	}
// 	return retColor / 18.0;
// }

 vec3 gaussianHorizontal(sampler2D gcolor, vec2 uv, float blurAmount)
{
    hPixelOffset *= blurAmount;
    vec3 color = vec3(0.0);
    for(int i = 0; i < 33; i++)
    {
        color += texture2D(gcolor, vec2(uv.x + (i * hPixelOffset), uv.y)).rgb * gaussianKernel2[i] * 0.25;
    }
    for(int i = 1; i < 33; i++)
    {
        color += texture2D(gcolor, vec2(uv.x - (i * hPixelOffset), uv.y)).rgb * gaussianKernel2[i] * 0.25;
    }
    return color;
}