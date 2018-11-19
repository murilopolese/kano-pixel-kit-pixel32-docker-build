# Build Pixel32 MicroPython image on a Docker

It's exactly what it reads: Use Docker to build a [MicroPython](https://micropython.org) image with the [Pixel32](http://github.com/murilopolese/kano-pixel-kit-pixel32) files in it.

You will need internet connection.

# How to build?

Assuming you have Docker installed and running:

```shell
docker run -v $(pwd)/build:/build murilopolese/pixel32-build
```

# Why using a Docker for that?

Because it will automate the following tasks for us:

- Install system dependencies: `nodejs`, `yarn`, `dosfstools` and `mtools`.
- Download and build web interface for the latest version (TODO) of [Pixel32](http://github.com/murilopolese/kano-pixel-kit-pixel32).
- Create an `pixel32.img` file and format it as a FAT filesystem.
- Copy all the relevant files to the `pixel32.img` without having to mount it.

# TODO

- Merge `pixel32.img` with MicroPython binary.
