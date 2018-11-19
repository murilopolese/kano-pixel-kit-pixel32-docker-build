# Clean old folders if any
echo 'Removing old repository at /pixel32'
rm -rf /pixel32
# clone Pixel32 repo
cd /
git clone https://github.com/murilopolese/kano-pixel-kit-pixel32.git pixel32

# Install front end dependencies and build it
cd /pixel32/www && git checkout v0.2.2
cd /pixel32/www && yarn install && yarn build

cd /
mkdir -p /build

# Create a disk image and format it as FAT
# https://forum.micropython.org/viewtopic.php?f=18&t=4750&p=27423&hilit=mount+files#p27423
echo 'Creating a disk image and format it as FAT'
rm -rf /build/pixel32.img
dd if=/dev/zero of=/build/pixel32.img bs=1M count=2
mkfs.fat -S 4096 -f 1 -s 1 /build/pixel32.img

# Move files to FAT image file without having to mount it
# https://stackoverflow.com/questions/22385189/add-files-to-vfat-image-without-mounting
echo 'Moving files to FAT image file without having to mount it'
mcopy -i build/pixel32.img pixel32/www/dist/index.html.gz ::index.html
mcopy -i build/pixel32.img pixel32/python/src/boot.py ::boot.py
mcopy -i build/pixel32.img pixel32/python/src/main.py ::main.py
mcopy -i build/pixel32.img pixel32/python/src/microDNSSrv.py ::microDNSSrv.py
mcopy -i build/pixel32.img pixel32/python/src/microWebSrv.py ::microWebSrv.py
mcopy -i build/pixel32.img pixel32/python/src/PixelKit.py ::PixelKit.py
mcopy -i build/pixel32.img pixel32/python/src/PixelTurtle.py ::PixelTurtle.py
mcopy -i build/pixel32.img pixel32/python/src/webrepl_cfg.py ::webrepl_cfg.py

echo "DONE!"
