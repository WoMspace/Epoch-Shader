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
		retColor += texture2D(colortex0, vec2(hOffset, vOffset)).rgb;
	}
	retColor /= DOF_BOKEH_SAMPLES;
	#ifdef DOF_BOKEH_ONIONRING
		retColor += onionRingBokeh(blurAmount);
		retColor *= 0.5;
	#endif
	return retColor;
}