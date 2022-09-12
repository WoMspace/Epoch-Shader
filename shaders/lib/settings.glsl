#define EPOCH_VERSION 1.3

#define NORMALMAP_STRENGTH 1.0 // [0.01 0.05 0.1 0.5 1.0 5.0 10.0 50.0]
//#define NORMALS_LAB_AO_ENABLED // Should the labPBR texture Ambient Occlusion be used.
#define NORMALS_LAB_AO_STRENGTH 1.0 // How strong the labPBR ambient occlusion is. [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
//#define SPECULAR_EMISSIVE_ENABLED
#define SPECULAR_EMISSIVE_STRENGTH 6.0 // How strong the labPBR Emission is. [0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8 3.0 3.2 3.4 3.6 3.8 4.0 4.2 4.4 4.6 4.8 5.0 5.2 5.4 5.6 5.8 6.0 6.2 6.4 6.6 6.8 7.0 7.2 7.4 7.6 7.8 8.0]

#define SPECULARMAP_ENABLED = defined(SPECULAR_EMISSIVE_ENABLED)

#define HDR_BLOCKLIGHT_STRENGTH 2.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0 8.1 8.2 8.3 8.4 8.5 8.6 8.7 8.8 8.9 9.0 9.1 9.2 9.3 9.4 9.5 9.6 9.7 9.8 9.9 10.0]
#define HDR_BLOCKLIGHT_RED 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define HDR_BLOCKLIGHT_GREEN 0.6 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define HDR_BLOCKLIGHT_BLUE 0.2 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define HDR_SUNLIGHT_STRENGTH 7.5
#define HDR_SUNLIGHT_RED 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define HDR_SUNLIGHT_GREEN 0.9 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define HDR_SUNLIGHT_BLUE 0.8 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define HDR_MOONLIGHT_STRENGTH 0.05
#define HDR_MOONLIGHT_RED 0.2 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define HDR_MOONLIGHT_GREEN 0.2 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define HDR_MOONLIGHT_BLUE 0.3 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define HDR_AMBIENTLIGHT_STRENGTH 1.0 // [0.0 0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5 10.0 10.5 11.0 11.5 12.0 12.5 13.0 13.5 14.0 14.5 15.0 15.5 16.0 16.5 17.0 17.5 18.0 18.5 19.0 19.5 20.0]
#define HDR_MINLIGHT 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.2 2.4 2.6 2.8 3.0 3.5 4.0 5.0 6.0 8.0 10.0]
#define HDR_EXPOSURE_VALUE 0.6 // [0.0 0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8 3.0 3.2 3.4 3.6 3.8 4.0 4.2 4.4 4.6 4.8 5.0 5.2 5.4 5.6 5.8 6.0 6.2 6.4 6.6 6.8 7.0 7.2 7.4 7.6 7.8 8.0 8.2 8.4 8.6 8.8 9.0 9.2 9.4 9.6 9.8 10.0 10.2 10.4 10.6 10.8 11.0 11.2 11.4 11.6 11.8 12.0 12.2 12.4 12.6 12.8 13.0 13.2 13.4 13.6 13.8 14.0 14.2 14.4 14.6 14.8 15.0 15.2 15.4 15.6 15.8 16.0 16.2 16.4 16.6 16.8 17.0 17.2 17.4 17.6 17.8 18.0 18.2 18.4 18.6 18.8 19.0 19.2 19.4 19.6 19.8 20.0]
#define HDR_EXPOSURE_MAXIMUM 0.01 // [0.0 0.005 0.01 0.03 0.05 0.1 0.15 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8 3.0 3.5 4.0 4.5 5.0 6.0 7.0 8.0 9.0 10.0 12.0 14.0 16.0 18.0 20.0 25.0 30.0 40.0 50.0 75.0 100.0]
#define HDR_EXPOSURE_MINIMUM 5.0 // [0.01 0.0 3 0.05 0.1 0.15 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8 3.0 3.5 4.0 4.5 5.0 6.0 7.0 8.0 9.0 10.0 12.0 14.0 16.0 18.0 20.0 25.0 30.0 40.0 50.0 75.0 100.0]

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

#define SHADOWS_ENABLED // :grimacing:
const int shadowMapResolution = 2048; // [512 1024 2048 4096 8192]
#define SHADOW_DISTORTION_FACTOR 0.1 // [0.01 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define SHADOW_BIAS 0.02 //sis idek [0.0 0.01 0.02 0.03 0.04 0.05]
#define SHADOW_FILTER_SAMPLES 16 // [4 8 16 32 64]
const float shadow_sample_darkness = 1.0 / SHADOW_FILTER_SAMPLES;
// #define EXCLUDE_FOLIAGE
#define SHADOW_FILTER_ENABLED // Enable filtering on the shadows to make them look soft and less blocky.

#define DOF_DISABLED 0 // Really low quality. Really fast.
#define DOF_MIP 1 // Higher quality. Pretty fast.
#define DOF_BOKEH 2 // Very high quality. Slowest, but still fast.
#define DOF_MODE DOF_DISABLED // Mipmap is REALLY fast, but low quality. Bokeh is slowest, but REALLY high quality. [DOF_DISABLED DOF_MIP DOF_BOKEH]
#define LENS_LENGTH 35 //Lens length in mm. [5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300]
#define LENS_APERTURE 2.8 //F-stop of the lens. [1.8 2.0 2.2 2.5 2.8 3.2 3.5 4.0 4.5 5.0 5.6 6.3 7.1 8.0 9.0 10.0 11.0 13.0 14.0 16.0 18.0 20.0 22.0]
const float lens_aperture_diameter = LENS_LENGTH / LENS_APERTURE;
// #define DOF_BOKEH_ONIONRING
#define DOF_AUTOFOCUS -1
#define DOF_DISTANCE DOF_AUTOFOCUS // How should the focus be handled. [DOF_AUTOFOCUS 0 2 4 8 16 32 64 128 256 512]
//#define DOF_DISTANCE DOF_AUTOFOCUS // [DOF_AUTOFOCUS 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256]

const float centerDepthHalflife = 0.5; // How fast the focus should move. In seconds. [0.0 0.25 0.5 0.75 1.0 1.5 2.0 2.5 3.0 4.0 5.0]
#define DOF_ANAMORPHIC 1.0 // Aspect ratio of the bokeh. [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8 3.0]
#define DOF_BOKEH_SAMPLES 128 // How many samples to use for the bokeh. [32 64 128 256 512 1024 2048 34 55 89 144]
// #define DOF_BOKEH_MIPMAP // Smoothens a low bokeh sample count. Can make the bokeh pixellated.
// // #define DOF_BOKEH_NOISE // Makes the bokeh noisy, but smoother. BROKEN!

#define BLOOM_DISABLED -1
#define BLOOM_STRENGTH 1.0 // How strong should the bloom effect be. [0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0]
#define BLOOM_THRESHOLD 2.0 // Minimum brightness for the bloom effect to work. [ 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0 8.1 8.2 8.3 8.4 8.5 8.6 8.7 8.8 8.9 9.0 9.1 9.2 9.3 9.4 9.5 9.6 9.7 9.8 9.9 10.0]
#define BLOOM_QUALITY BLOOM_DISABLED // Quality of the bloom effect. QUALITY 3 IS FAIRLY INTENSIVE! [BLOOM_DISABLED 1 2 3]

// #define FLARES_ENABLED

#define CHROMATIC_ABERRATION_ENABLED // Fringing of the colors around the edges of the screen.
#define CHROMATIC_ABERRATION_STRENGTH 0.005 // How strong the chromatic aberration should be. [0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01]

#define LENS_FLARES_DISABLED 0
#define LENS_FLARES_SPHERICAL 1
#define LENS_FLARES_ANAMORPHIC 2
#define LENS_FLARES_MODE LENS_FLARES_ANAMORPHIC // [LENS_FLARES_DISABLED LENS_FLARES_SPHERICAL LENS_FLARES_ANAMORPHIC]
#define LENS_FLARES_STRENGTH 1.0 // [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.2 1.5 1.6 1.8 2.0]
#define LENS_FLARES_THRESHOLD 5.0 // [1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0]

#define CAMERA_AUTO -1
#define CAMERA_ISO CAMERA_AUTO // Currently doesn't do anything! [CAMERA_AUTO 50 100 200 400 800 1300 1600 3200 6400 12800 25600]
#define CAMERA_SHUTTER_SPEED CAMERA_AUTO // Currently doesn't do anything! [CAMERA_AUTO 30 60 125 250 500 2000 4000]
#define CAMERA_EXPOSURE_COMPENSATION -1.33 // [-3.0 -2.66 -2.33 -2.0 -1.66 -1.33 -1.0 -0.66 -0.33 0.0 0.33 0.66 1.0 1.33 1.66 2.0 2.33 2.66 3.0 ]
const float camera_shutter_speed = 1.0 / float(CAMERA_SHUTTER_SPEED);

#define FILM_DISABLED 0
#define FILM_GREYSCALE 1 // Black and white like a film camera.
#define FILM_COLOR 2 // Color film, like a Kodak Gold film.
#define FILM_THERMAL 3 // Thermal Camera :D
#define FILM_MODE FILM_DISABLED // Film emulation. [FILM_DISABLED FILM_GREYSCALE FILM_COLOR]
#define FILM_BRIGHTNESS 0.0 // How bright the image should be. [-1.0 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 -0.3 -0.2 -0.1 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define FILM_CONTRAST 1.0 // How much contrast the film-like image should have. [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0]

#define GREYSCALE_RED_CONTRIBUTION 1.0 // How much red should affect total luminance. [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GREYSCALE_GREEN_CONTRIBUTION 1.0 // How much green should affect total luminance. [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GREYSCALE_BLUE_CONTRIBUTION 1.0 // How much blue should affect total luminance. [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]

// //#define COLORFILM_SATURATION 1.0 // no idea how to implement this but it's important :P
#define COLORFILM_STRENGTH 1.0 // How strong the film color simulation should be. [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]

// #define FILM_IMPERFECTIONS_SHAKE_ENABLED // Film shakes a little bit, to simulate playback.
#define FILM_IMPERFECTIONS_SHAKE_STRENGTH 0.2 // Strength of the film shake effect. [0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
//#define FILM_IMPERFECTIONS_SPOTS_ENABLED // Small spots on the screen that appear and disappear.
#define FILM_IMPERFECTIONS_SPOTS_SIZE 3 // Radius of the spots in pixels. [1 3 5 7 9 11 13 15]
#define FILM_IMPERFECTIONS_SPOTS_AMOUNT 0.05 // How many spots should be generated. [0.01 0.02 0.03 0.04 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
//#define FILM_IMPERFECTIONS_LINES_ENABLED // Lines that move around. Amount of movement is linked to framerate. Higher fps = less movement.
#define FILM_IMPERFECTIONS_LINES_STRENGTH 0.7 // Strength of the lines. [0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]

#define GRAIN_STRENGTH 0.15 // How strong the noise is. [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50]
#define GRAIN_PERFORMANCE 0.4 // The noise performance of the camera/film. [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define GRAIN_DISABLED 0
#define GRAIN_LUMA 1
#define GRAIN_CHROMA 2
#define GRAIN_MODE GRAIN_CHROMA // Should the grain effect be used. [GRAIN_DISABLED GRAIN_LUMA GRAIN_CHROMA]
const int noiseTextureResolution = 512; // Size of the noise texture. Smaller number = bigger noise. [64 128 256 512 1024 2048]

#define CHROMA_SAMPLING_DISABLED -1
#define CHROMA_SAMPLING_DOWNSAMPLE 1 
#define CHROMA_SAMPLING_SHIFT 2
#define CHROMA_SAMPLING_MODE CHROMA_SAMPLING_SHIFT // [CHROMA_SAMPLING_DISABLED CHROMA_SAMPLING_DOWNSAMPLE CHROMA_SAMPLING_SHIFT]
#define CHROMA_SAMPLING_SIZE 3.0// How big the chroma subsampling should be. Larger number = bigger artefacting.[1.0 2.0 3.0 4.0 5.0]

// #define QUANTISATION_ENABLED // Reduced color palette.
#define QUANTISATION_BITDEPTH 8 // How many values each color can have. [2 4 8 16 32]
const float quantisation_colors_perchannel = pow(2, float(QUANTISATION_BITDEPTH) / 4.0);
#define DITHERING_DISABLED 0
#define DITHERING_BAYER 1
#define DITHERING_BLUE 2
#define DITHERING_MODE DITHERING_DISABLED // Makes low bit-depth look higher bitdepth. [DITHERING_DISABLED DITHERING_BAYER DITHERING_BLUE]
#define DITHERING_STRENGTH 0.1 // [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]

#define INTERLACING_ENABLED // An interlacing effect. With help from Sir Bird.
#define INTERLACING_SIZE 4.0 // How big the interlaced lines are. Good for HiDPI displays. [2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 15.0 20.0 30.0 40.0 50.0]

// #define VHS_TRANSFORMS_ENABLED
#define PIXEL_SIZE_DISABLED -1
#define PIXEL_SIZE PIXEL_SIZE_DISABLED // How big the pixels should be, in on-screen pixels. [PIXEL_SIZE_DISABLED 2 4 8 16 32 64 128]

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

#define GHOSTING_ENABLED // Ghosting effect.
#define GHOSTING_STRENGTH 48.0 // The inverse strength of the ghosting. [1.0 1.5 2.0 3.0 4.0 6.0 8.0 12.0 16.0 24.0 32.0 48.0 64.0]

// #define GRADING_ENABLED // Post-processing color grading.
#define GRADING_HI_RED 1.0 // Red highlight strength [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GRADING_HI_GREEN 1.0 // Green highlight strength [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GRADING_HI_BLUE 1.0 // Blue highlight strength [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GRADING_MID_RED 1.0 // Red midtones strength [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GRADING_MID_GREEN 1.0 // Green midtones strength [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GRADING_MID_BLUE 1.0 // Blue midtones strength [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GRADING_LOW_RED 1.0 // Red shadow strength [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GRADING_LOW_GREEN 1.0 // Green shadow strength [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define GRADING_LOW_BLUE 1.0 // Blue shadow strength [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]

// #define BARREL_DISTORTION_ENABLED // Causes a rounding of the image.
#define BARREL_POWER -0.5 // How strong the lens distortion should be. Negative = Barrel Distortion. Positive = Pincushion Distortion. [-1.0 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 -0.3 -0.2 -0.1 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define BARREL_CLIP_BLACK 0
#define BARREL_CLIP_ZOOM 1
#define BARREL_CLIP_OFF 2
#define BARREL_CLIP_MODE BARREL_CLIP_BLACK // How should barrel distortion artefacts be fixed. Black fills in the broken areas with black. Zoom enlarges the image to hide the broken areas. [BARREL_CLIP_BLACK BARREL_CLIP_ZOOM BARREL_CLIP_OFF]

#define LUT_DISABLED -1
#define LUT_SELECTED LUT_DISABLED // [LUT_DISABLED 0 1 2 3 4 5 6 7 8 9]
const float lut_selected = float(LUT_SELECTED) / 10.0;
// #define HALD_CLUT
#define LUT_STRENGTH 1.0 // [ 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 ]
// #define LUT_CUSTOM
#define TONEMAP_BURGESS 0
#define TONEMAP_JESSIE 1
#define TONEMAP_ZOMBYE 2
#define TONEMAP_TECH 3
#define TONEMAP_OPERATOR TONEMAP_BURGESS // [TONEMAP_BURGESS TONEMAP_ZOMBYE TONEMAP_TECH]

//#define VERTEX_WAVING_WATER
//#define VERTEX_WAVING_LAVA
//#define VERTEX_WAVING_LEAVES
//#define VERTEX_WAVING_PLANTS
// #define VERTEX_WAVING_FIRE

// #define MOLLY_LIT_TRANSLUCENTS_ENABLED

// #define ANAGLYPH_3D_ENABLED
#define ANAGLYPH_3D_SEPARATION 1.0 // [0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0]