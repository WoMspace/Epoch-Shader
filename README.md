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
- Dimensional rewind effect
- Light leaks
- Anamorphic effects
- Other lens effects
	- Flares
- Flashlight
- Physical-ish sky

<p align="left">
    <a href="https://raw.githubusercontent.com/WoMspace/Epoch-Shader/main/screenshots/bw-office.png" target="_blank" rel="noopener noreferrer">
        <img alt="Office - Black and White - JoubaMety" src="screenshots/bw-office.jpg" width="45%">
    </a>
    <a href="https://raw.githubusercontent.com/WoMspace/Epoch-Shader/main/screenshots/bw-streetcorner.png" target="_blank" rel="noopener noreferrer">
        <img alt="Street Corner - Black and White - JoubaMety" src="screenshots/bw-streetcorner.jpg" width="45%">
    </a>
    <a href="https://raw.githubusercontent.com/WoMspace/Epoch-Shader/main/screenshots/col-office.png" target="_blank" rel="noopener noreferrer">
        <img alt="Office - Color - JoubaMety" src="screenshots/col-office.jpg" width="45%">
    </a>
    <a href="https://raw.githubusercontent.com/WoMspace/Epoch-Shader/main/screenshots/col-overlook.png" target="_blank" rel="noopener noreferrer">
        <img alt="Overlook - Color - JoubaMety" src="screenshots/col-overlook.jpg" width="45%">
    </a>
    <a href="https://raw.githubusercontent.com/WoMspace/Epoch-Shader/main/screenshots/vhs-city.png" target="_blank" rel="noopener noreferrer">
        <img alt="City - VHS - shortnamesalex" src="screenshots/vhs-city.jpg" width="45%">
    </a>
    <a href="https://raw.githubusercontent.com/WoMspace/Epoch-Shader/main/screenshots/vhs-skyline.png" target="_blank" rel="noopener noreferrer">
        <img alt="Skyline - VHS - shortnamesalex" src="screenshots/vhs-skyline.jpg" width="45%">
    </a>
</p>

### BUFFER USAGE:

buffer|Read|Write|composite0|composite3|composite6|composite15
------|----|-----|----------|----------|----------|-----------
colortex0|0 3 6 15|GB 0 3 6 15|color.rgb, coc.a|color.rgb, filmspot.a|color.rgb|color.rgb
colortex1|3 15|3 15|N/A|color.rgb delayed|N/A|exposure.a
colortex2|GB 3 6|6|N/A|N/A|color.rgb accum|N/A
colortex3|2|6|N/A|N/A|CRT Texture|N/A
colortex4|3|0 1 2|N/A|Bloom|N/A|N/A
