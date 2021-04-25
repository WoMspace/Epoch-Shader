#version 120

/*
==== COMPOSITE1:CAMERA ====
- DoF
- Bloom
- Grain
- Chroma Sampling
- Film Mode
- Interlacing
*/

#include "lib/settings.glsl"

uniform sampler2D colortex0;
uniform sampler2D noisetex;
uniform sampler2D colortex1;
uniform sampler2D depthtex0;
uniform mat4 gbufferProjection;

const bool colortex1Clear = false;
const bool colortex0MipmapEnabled = true;

varying vec2 texcoord;

#include "lib/depth.glsl"
#include "lib/blurs.glsl"
#include "lib/color.glsl"

void main()
{
    vec3 color = texture2D(colortex0, texcoord).rgb;

    #if DOF_MODE == 1 //mip blur
    color = mipBlur(sqrt(abs(getFragDepth(depthtex0, texcoord) - getCursorDepth())));
    #endif
    #if DOF_MODE == 2 //bokeh blur
    color = bokehBlur();
    #endif

    #if FILM_MODE != 0
        #if FILM_MODE == 1 // greyscale
            color = extractLuma(color, vec3(GREYSCALE_RED_CONTRIBUTION, GREYSCALE_GREEN_CONTRIBUTION, GREYSCALE_BLUE_CONTRIBUTION));
            color = contrast(color, FILM_BRIGHTNESS, FILM_CONTRAST);
        #endif
        #if FILM_MODE == 2 // color film
            color = colorFilm(color, 1.0);
        #endif
    #endif

    #if GRAIN_MODE != 0
        float noiseSeed = float(frameCounter) * 0.11;
		vec2 noiseCoord = texcoord + vec2(sin(noiseSeed), cos(noiseSeed));

        #if GRAIN_MODE == 1 // luma noise
		color -= vec3(texture2D(noisetex, noiseCoord).r)*GRAIN_STRENGTH;
        #endif
        #if GRAIN_MODE == 2 // chroma noise
        color -= texture2D(noisetex, noiseCoord).rgb*GRAIN_STRENGTH;
        #endif
    #endif

    #ifdef CHROMA_SAMPLING_ENABLED
        vec3 chroma = normalize(texture2DLod(colortex0, texcoord, CHROMA_SAMPLING_SIZE).rgb) * 2.0;
		color = chroma * extractLuma(color);
    #endif

    vec3 color2 = color;
    #ifdef INTERLACING_ENABLED
    if(mod(gl_FragCoord.y, INTERLACING_SIZE) > (INTERLACING_SIZE - 1.0)*0.5)
        {
            color = texture2D(colortex1, texcoord).rgb;
        }
    #endif


    /* DRAWBUFFERS:01 */
    gl_FragData[0] = vec4(color, 1.0);
    gl_FragData[1] = vec4(color2, 1.0);
}