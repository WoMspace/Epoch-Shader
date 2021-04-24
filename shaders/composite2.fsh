#version 120

/*
==== COMPOSITE2:PLAYBACK ====
- Image Transforms
- Rewind Effect
- Scanlines
- Ghosting
- Barrel Distortion
*/

#include "lib/settings.glsl"

uniform sampler2D colortex0;
uniform sampler2D colortex2;
#if (SCANLINE_MODE == 3 && defined(CRT_TEXTURE_ENABLED))
    uniform sampler2D colortex3;
#endif
uniform mat4 gbufferProjection;
uniform float viewWidth;
uniform float viewHeight;

const bool colortex2Clear = false;

varying vec2 texcoord;

#include "lib/color.glsl"
#include "lib/maths.glsl"

void main()
{
    vec2 uv = texcoord;

    #ifdef BARREL_DISTORTION_ENABLED
        float fov = 2 * atan(1 / gbufferProjection[0][0]);
        uv = distort(uv, BARREL_POWER * fov * 0.5);
		#if BARREL_CLIP_MODE == 1 //zoom
			uv = clip(uv);
			uv *= fov * 0.3;
			uv = unclip(uv);
		#endif
    #endif

    vec3 color = texture2D(colortex0, uv).rgb;

    #if SCANLINE_MODE != 0
		#if SCANLINE_MODE == 1 // WoMspace Scanlines
			if(mod(gl_FragCoord.y, SCANLINE_DISTANCE) < SCANLINE_THICKNESS)
			{
				color -= SCANLINE_STRENGTH;
			}
		#endif
		#if SCANLINE_MODE == 2 // SirBird Scanlines
			color *= 0.92+0.08*(0.05-pow(clamp(sin(viewHeight/2.*uv.y+frameCounter/5.),0.,1.),1.5));
		#endif
        #if SCANLINE_MODE == 3 //CRT Mode
			#ifdef CRT_TEXTURE_ENABLED // CRT TEXTURE (courtesy of s o u l n a t e#3527)
				vec2 CRTtexcoord = vec2(texcoord.x * (viewWidth/1500) * CRT_TEXTURE_SCALE, texcoord.y * (viewHeight/1500) * CRT_TEXTURE_SCALE);
				color *= texture2D(colortex3, CRTtexcoord).rgb;
			#else
				float moduloPixLoc = mod(gl_FragCoord.x, 3);
				if(mod(gl_FragCoord.y, 4) > 1)
				{
					if(moduloPixLoc > 0 && moduloPixLoc < 1)
					{
						color = vec3(color.r, 0.0, 0.0);
					}
					if(moduloPixLoc > 1 && moduloPixLoc < 2)
					{
						color = vec3(0.0, color.g, 0.0);
					}
					if(moduloPixLoc > 2 && moduloPixLoc < 3)
					{
						color = vec3(0.0, 0.0, color.b);
					}
				}
				else
				{
					color = vec3(CRT_BOOST);
				}
			#endif
		#endif
	#endif

    vec3 color2 = vec3(0.0);
    #ifdef GHOSTING_ENABLED
        color2 = texture2D(colortex2, texcoord).rgb;
        color2 = mix(color2, color, 1 - GHOSTING_STRENGTH);
        color = (color + color2)*0.5;
    #endif

    #ifdef BARREL_DISTORTION_ENABLED
		#if BARREL_CLIP_MODE == 0 //black bars
		if(uv.x < 0.0 || uv.x > 1.0) { color = vec3(0.0); }
		if(uv.y < 0.0 || uv.y > 1.0) { color = vec3(0.0); }
		#endif
		#if BARREL_CLIP_MODE == 2 //off
		// :)
		#endif
	#endif

    /* DRAWBUFFERS:02 */
    gl_FragData[0] = vec4(color, 1.0);
    gl_FragData[1] = vec4(color2, 1.0);
}