#include "bokeh.glsl"
uniform float near;
uniform float viewWidth;
uniform float viewHeight;
uniform float aspectRatio;
uniform int frameCounter;
uniform float frameTimeCounter;

vec3 mipBlur(float blurAmount)
{
    return texture2DLod(colortex0, texcoord, clamp(blurAmount * 0.5 * gbufferProjection[1].y,0.0, 7.0)).rgb;
}

float hPixelOffset = 1/viewWidth;
float vPixelOffset = 1/viewHeight;

vec3 bokehBlur(float blurAmount) //simple bokeh blur, no depth testing
{
    vec3 retColor = vec3(0.0);
    for(int i = 0; i < DOF_BOKEH_SAMPLES; i++)
    {
        float hOffset = texcoord.x + bokehOffsets[i].x * hPixelOffset * blurAmount * DOF_STRENGTH * (1/DOF_ANAMORPHIC);
        float vOffset = texcoord.y + bokehOffsets[i].y * vPixelOffset * blurAmount * DOF_STRENGTH * DOF_ANAMORPHIC;
        retColor += texture2D(colortex0, vec2(hOffset, vOffset)).rgb / DOF_BOKEH_SAMPLES;
    }
    return retColor;
}
vec3 bokehBlur() //takes depth into account, doesn't use "blurAmount". WIP
{
    vec3 retColor = texture2D(colortex0, texcoord).rgb;
    int blurHits = 1;
    float cursorDepth = getCursorDepth();
    float fragDepth = getFragDepth(depthtex0, texcoord);
    float blurAmount = abs(fragDepth - cursorDepth) * gbufferProjection[1].y;
    for(int i = 0; i < DOF_BOKEH_SAMPLES; i++)
    {
        float hOffset = texcoord.x + bokehOffsets[i].x * hPixelOffset * blurAmount * DOF_STRENGTH * (1/DOF_ANAMORPHIC);
        float vOffset = texcoord.y + bokehOffsets[i].y * vPixelOffset * blurAmount * DOF_STRENGTH * DOF_ANAMORPHIC;
        vec2 sampleOffset = vec2(hOffset, vOffset);

        #ifdef DOF_BOKEH_MIPMAP
        retColor += texture2DLod(colortex0, sampleOffset, clamp(blurAmount * 0.3, 0.0, 4.0)).rgb;
        #else
        retColor += texture2D(colortex0, sampleOffset).rgb;
        #endif
        blurHits++;


    }
    return retColor / blurHits;
}