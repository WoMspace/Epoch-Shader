# [Epoch](https://www.google.com/search?q=define+epoch)
## /ˈiːpɒk,ˈɛpɒk/
**noun:**

a particular period of time in history or a person's life.
	
*"the Victorian epoch"*

#### Features include
- Scanlines
- Chroma Subsampling
- Depth of Field
- B&W and Color film modes
- Among many others!

#### Todo:
- BIGFOOT AND UFOS!!!!!!
- Random digital and analogue glitches and transforms.
- HDR
- Tonemapping
- Dimensional rewind effect
- Light leaks
- Anamorphic effects
- Other lens effects
- Flashlight

![2021-04-24_23 47 55](https://user-images.githubusercontent.com/22845656/115974876-db9a6a80-a557-11eb-8b29-b5a40c35a700.png)
![2021-04-24_23 49 12](https://user-images.githubusercontent.com/22845656/115974863-c7566d80-a557-11eb-8d0f-ed69ce0e9405.png)

### BUFFER USAGE:

buffer|Read|Write|composite0|composite1|composite2
------|----|-----|----------|----------|----------
colortex0|012|012|color.rgb, coc.a|color.rgb, filmspot.a|color.rgb
colortex1|01|01|exposure.a|color.rgb delayed|N/A
colortex2|2|2|N/A|N/A|color.rgb accum
colortex3|2|N/A|N/A|N/A|CRT Texture