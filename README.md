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
- Screen-space reflections (perhaps world-space reflections?)

*Control + Left Click on a image to open source image in new tab*

<a href="https://cdn.discordapp.com/attachments/837711298593685544/921693588876845096/2021-12-18_01.20.21.png">
	<img alt="Spawn - Custom - Cretoxyrina" src="https://cdn.discordapp.com/attachments/778098799192440882/922582925831192586/2021-12-18_01.20.21.jpg" width="90%">
	</a>

<p align="left">
    <a href="https://cdn.discordapp.com/attachments/705816123421098015/857316471586422824/bw-office.png">
        <img alt="Office - Black and White - JoubaMety" src="https://cdn.discordapp.com/attachments/705816123421098015/857316412171485244/bw-office.jpg" width="45%">
    </a>
    <a href="https://cdn.discordapp.com/attachments/705816123421098015/857316562667438080/bw-streetcorner.png">
        <img alt="Street Corner - Black and White - JoubaMety" src="https://cdn.discordapp.com/attachments/705816123421098015/857316487847739392/bw-streetcorner.jpg" width="45%">
    </a>
    <a href="https://cdn.discordapp.com/attachments/705816123421098015/857316711359447090/col-office.png">
        <img alt="Office - Color - JoubaMety" src="https://cdn.discordapp.com/attachments/705816123421098015/857316560183885834/col-office.jpg" width="45%">
    </a>
    <a href="https://cdn.discordapp.com/attachments/705816123421098015/857316867986817044/col-overlook.png">
        <img alt="Overlook - Color - JoubaMety" src="https://cdn.discordapp.com/attachments/705816123421098015/857316613606735893/col-overlook.jpg" width="45%">
    </a>
    <a href="https://cdn.discordapp.com/attachments/705816123421098015/857316757017460756/vhs-city.png">
        <img alt="City - VHS - shortnamesalex" src="https://cdn.discordapp.com/attachments/705816123421098015/857316616605270036/vhs-city.jpg" width="45%">
    </a>
    <a href="https://cdn.discordapp.com/attachments/705816123421098015/857316756837236756/vhs-skyline.png">
        <img alt="Skyline - VHS - shortnamesalex" src="https://cdn.discordapp.com/attachments/705816123421098015/857316616358592542/vhs-skyline.jpg" width="45%">
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
