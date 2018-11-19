# Build Pixel32 FAT partition image on a Docker

It's exactly what it reads: Use Docker to build a FAT partition image with the [Pixel32](http://github.com/murilopolese/kano-pixel-kit-pixel32) files in it.

# How to use it?

Assuming you have Docker installed first install the docker image:

```shell
docker pull murilopolese/pixel32-build
```

Then find a comfortable folder on your computer and type the following command:

```shell
docker run -v $(pwd)/build:/build murilopolese/pixel32-build
```

This will output the file `pixel32.img` on the folder `build` (it will create this folder if doesn't exist). We will use this file to Flash your Pixel Kit alongside with the [MicroPython firmware](https://micropython.org/download#esp32).

Flashing it on your Pixel Kit using `esptool` should be something like this:

```shell
esptool.py -p /dev/your_pixelkit_port write_flash 0x1000 micropython_firmware.bin 0x200000 pixel32.img
```

**IMPORTANT**: ESP32 MicroPython's filesystem starts at memory location `0x200000` as it's [hard coded](https://github.com/micropython/micropython/blob/v1.9.4/ports/esp32/modesp.c#L99).

**COOL STUFF**: You can mount the `pixel32.img` on your computer to add, remove or modify the files and then flash it again on your Pixel Kit ;)

# Why using a Docker?

Because it will automate the following tasks for us:

- Install system dependencies: `nodejs`, `yarn`, `dosfstools` and `mtools`.
- Download and build web interface for the latest version (TODO) of [Pixel32](http://github.com/murilopolese/kano-pixel-kit-pixel32).
- Create an `pixel32.img` file and format it as a FAT filesystem. ([Solution found here](https://forum.micropython.org/viewtopic.php?f=18&t=4750&p=27423&hilit=mount+files#p27423))
- Copy all the relevant files to the `pixel32.img` without having to mount it. ([Solution found here](https://stackoverflow.com/questions/22385189/add-files-to-vfat-image-without-mounting))

# TODO

- Merge `pixel32.img` with MicroPython binary so we have only one single file to flash on Pixel Kit.
