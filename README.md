# plymouth-plantae-theme


## Instructions 


1. Install Plymouth themes and scripts dependencies:

```bash
apt install -y plymouth-themes imagemagick ffmpeg
```

2. Get this theme repository under /usr/share/plymouth/themes/plantae

```bash
cd /usr/share/plymouth/themes \
&& rm -rf ./plantae && mkdir ./plantae \
&& curl https://codeload.github.com/nelu/plymouth-plantae-theme/tar.gz/refs/heads/main | tar -xzvf - --strip 1 -C ./plantae
```
3. Move into your new theme folder and check available conversion scripts

```console
cd /usr/share/plymouth/themes/plantae
$ ls *.sh
gif-to-png.sh*  mp4-to-gif.sh*  mp4-to-png.sh*  set-loader.sh*
```


### Theme customisation

1. Put mp4 or gif into the "input" folder: video.mp4 video.gif
2. Run the set-loader.sh script for the file type you are using: mp4, gif

```shell
┌──(root💀kali)-[/usr/share/plymouth/themes/plantae]
└─# ./set-loader.sh
invalid argument type:  . valid: mp4|gif

┌──(root💀kali)-[/usr/share/plymouth/themes/plantae]
└─# ./set-loader.sh mp4
Writing png contents to: /usr/share/plymouth/themes/plantae/output
frame=   183 fps= 28 q=-0.0 Lsize=N/A time=00:00:03.00 bitrate=N/A speed=0.927x
Wrote 183 png contents to: /usr/share/plymouth/themes/plantae/loader-content
Done. Please run: 'update-initramfs -u' or 'plymouth-set-default-theme -R plantae' and reboot to see changes
```
3. To have the correct number of images in the sequence, open animated-boot.script and replace 
["imagesInSequence"](animated-boot.script#L7)
 value with the number output images from step 2:
```
imagesInSequence=183;
```
The converted output is found in "output" folder and animated-boot.script will read the image contents from "loader-content" folder

### Theme installation
- METHOD 1: the plymouth-set-default-theme command.
This method works for raspbian also
```console
$ plymouth-set-default-theme -R plantae
```
- METHOD 2: Install and set the theme:
```console
$ sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/plantae/plantae.plymouth 100

$ sudo update-alternatives --config default.plymouth
$ sudo update-initramfs -u
```
And select the number for your theme (I can't say this for sure but if the theme you want is under 0 for the auto mode, then I would select that as I think it boots in faster than manual)


Now reboot.

View available themes:
```console 
$ plymouth-set-default-theme -l
bgrt
kali
details
fade-in
futureprototype
glow
homeworld
joy
kali
lines
moonlight
plantae
slash
script
softwaves
solar
spacefun
spinfinity
spinner
text
tribar
```

If you want to install this on < Ubuntu 16.04, change the path from /usr/share/plymouth to /lib/plymouth/ . You need to do this on the eionix-cat.plymouth file also.

Also other possible perks:

I found some scripts that are supposed to improve the transitions etc between Plymouth and the other parts of the start up process. I don't know if they worked for me or not. I had trouble getting the plymouth-gdm thing working as it seems that it's primarily something to do with pre-gdm3 versions and I'm on Ubuntu 18.04

Anyway:

- Edit the file /etc/initramfs-tools/conf.d/splash and add this line:

`
FRAMEBUFFER=y
`

- To enable smooth transition you have to disable your display manager unit, e.g.

`
systemctl disable gdm.service
`

- Enable the respective DM-plymouth Unit (GDM, LXDM, SLiM units provided), e.g.

`
systemctl enable gdm-plymouth.service
`
### Theme demo
input/video.gif
![Alt Text](input/video.gif)

### Credits
https://github.com/jcklpe/Plymouth-Animated-Boot-Screen-Creator


