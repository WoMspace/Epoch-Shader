#define SHADER_FOG_ENABLED // Should the fog effect be used.
#define FOG_END far // How far away the fog should end. [32 64 128 far]
#define FOG_NEAR 32 // How far away the fog should start. [0 2 4 8 16 32 64]
#define WATER_FOG_R 0.1// Red channel of the water fog. [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define WATER_FOG_G 0.2// Green channel of the water fog. [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define WATER_FOG_B 0.5// Blue channel of the water fog. [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define WATER_FOG_DISTANCE 32.0 // How far the water fog should go. [16.0 32.0 64.0]
#define LAVA_FOG_R 1.0// Red channel of the water fog. [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define LAVA_FOG_G 0.5// Green channel of the water fog. [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define LAVA_FOG_B 0.0// Blue channel of the water fog. [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define LAVA_FOG_DISTANCE 2.0 // How far the lava fog should go. [1.0 2.0 4.0 8.0]
#define pi 3.14159 //pi babey

#define DOF_DISABLED 0 // Really low quality. Really fast.
#define DOF_MIP 1 // Higher quality. Pretty fast.
#define DOF_BOKEH 2 // Very high quality. Slowest, but still fast.
#define DOF_MODE DOF_DISABLED // Mipmap is REALLY fast, but low quality. Bokeh is slowest, but REALLY high quality. [DOF_DISABLED DOF_MIP DOF_BOKEH]
#define DOF_STRENGTH 0.5 // How strong the blur should be. [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8 3.0 3.5 4.0]
#define DOF_AUTOFOCUS -1
#define DOF_DISTANCE DOF_AUTOFOCUS // How should the focus be handled. [DOF_AUTOFOCUS 0 2 4 8 16 32 64 128 256 512]
const float centerDepthHalflife = 0.5; // How fast the focus should move. In seconds. [0.0 0.25 0.5 0.75 1.0 1.5 2.0]

#define DOF_ANAMORPHIC 1.0 // Aspect ratio of the bokeh. [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8 3.0]
#ifdef MC_GL_RENDERER_RADEON
    #define DOF_BOKEH_SAMPLES 128 // How many samples to use for the bokeh. [32 64 128 256 512 1024 2048]
#else
    #define DOF_BOKEH_SAMPLES 128 // How many samples to use for the bokeh. [32 64 128 256 512]
#endif
// #define DOF_BOKEH_MIPMAP // Smoothens a low bokeh sample count. Can make the bokeh pixellated.
// #define DOF_BOKEH_NOISE // Makes the bokeh noisy, but smoother. BROKEN!

// #define BLOOM_ENABLED // Should the bloom effect be used. Makes the image softer.
#define BLOOM_STRENGTH 1.0 // How strong should the bloom effect be. [0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0]
#define BLOOM_THRESHOLD 0.1 // Minimum brightness for the bloom effect to work. [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define BLOOM_QUALITY 1.0 // Quality of the bloom effect. [2.0 1.0 0.5 0.2]

#define FILM_DISABLED 0
#define FILM_GREYSCALE 1 // Black and white like a film camera.
#define FILM_COLOR 2 // Color film, like a Kodak Gold film.
#define FILM_MODE FILM_DISABLED // Film emulation. [FILM_DISABLED FILM_GREYSCALE FILM_COLOR]
#define FILM_BRIGHTNESS 0.0 // How bright the image should be. [-1.0 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 -0.3 -0.2 -0.1 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define FILM_CONTRAST 1.0 // How much contrast the film-like image should have. [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]

#define GREYSCALE_RED_CONTRIBUTION 1.0 // How much red should affect total luminance. [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GREYSCALE_GREEN_CONTRIBUTION 1.0 // How much green should affect total luminance. [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GREYSCALE_BLUE_CONTRIBUTION 1.0 // How much blue should affect total luminance. [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]

// //#define COLORFILM_SATURATION 1.0 // no idea how to implement this but it's important :P
#define COLORFILM_STRENGTH 1.0 // How strong the film color simulation should be. [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]


#define GRAIN_STRENGTH 0.15 // How strong the noise is. [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50]
#define GRAIN_DISABLED 0
#define GRAIN_LUMA 1
#define GRAIN_CHROMA 2
#define GRAIN_MODE GRAIN_CHROMA // Should the grain effect be used. [GRAIN_DISABLED GRAIN_LUMA GRAIN_CHROMA]
const int noiseTextureResolution = 512; // Size of the noise texture. Smaller number = bigger noise. [64 128 256 512 1024 2048]

#define CHROMA_SAMPLING_ENABLED // Should the chroma sub-sampling effect be used.
#define CHROMA_SAMPLING_SIZE 4.0// How big the chroma subsampling should be. Larger number = bigger artefacting.[1.0 2.0 3.0 4.0 5.0]

#define INTERLACING_ENABLED // An interlacing effect. With help from Sir Bird.
#define INTERLACING_SIZE 4.0 // How big the interlaced lines are. Good for HiDPI displays. [2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 15.0 20.0 30.0 40.0 50.0]

// #define VHS_IMAGE_TRANSFORMS

#define SCANLINE_MODE_OFF 0
#define SCANLINE_MODE_WOMSPACE 1
#define SCANLINE_MODE_SIRBIRD 2
#define SCANLINE_MODE_CRT 3
#define SCANLINE_MODE_CRT_TEXTURE 4
#define SCANLINE_MODE SCANLINE_MODE_WOMSPACE // Which Scanline effect to use. [SCANLINE_MODE_OFF SCANLINE_MODE_WOMSPACE SCANLINE_MODE_SIRBIRD SCANLINE_MODE_CRT]
#define SCANLINE_DISTANCE 5 // How many pixels between each line. [1 2 3 4 5 6 7 8 9 10 20 30 40 50 100 200]
#define SCANLINE_STRENGTH 0.1 // How strong the scanline effect is. [0.01 0.05 0.1 0.2 0.3 0.4 0.5]
#define SCANLINE_THICKNESS 1 // How thick the lines are. [1 2 3 4 5 6 7 8 9 10]
// #define CRT_TEXTURE_ENABLED // Should the CRT texture be used. Disabling this will use a pixel perfect, but less authentic CRT mode.
#define CRT_BOOST 0.1 // Boosts the brightness a bit to make it less dark. [0.0 0.1 0.2 0.3 0.4 0.5]
#define CRT_TEXTURE_SCALE 3.0 // How small should the CRT texture be. [1.0 2.0 3.0 4.0]
#if SCANLINE_MODE == 3
	#ifdef CRT_TEXTURE_ENABLED
		uniform sampler2D colortex4;
	#endif
#endif

#define GHOSTING_ENABLED // Ghosting effect.
#define GHOSTING_STRENGTH 0.7 // The strength of the ghosting. [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9]

// #define BARREL_DISTORTION_ENABLED // Causes a rounding of the image.
#define BARREL_POWER -0.5 // How strong the lens distortion should be. Negative = Barrel Distortion. Positive = Pincushion Distortion. [-1.0 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 -0.3 -0.2 -0.1 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define BARREL_CLIP_BLACK 0
#define BARREL_CLIP_ZOOM 1
#define BARREL_CLIP_OFF 2
#define BARREL_CLIP_MODE BARREL_CLIP_BLACK // How should barrel distortion artefacts be fixed. Black fills in the broken areas with black. Zoom enlarges the image to hide the broken areas. [BARREL_CLIP_BLACK BARREL_CLIP_ZOOM BARREL_CLIP_OFF]