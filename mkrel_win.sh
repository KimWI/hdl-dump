#!/bin/sh

make clean

make RELEASE=yes

rm -rf rel
mkdir -p rel
mv hdl_dump.exe rel/

make clean

cd gui
make clean
make RELEASE=yes
mv hdl_dumb.exe ../rel/
upx -9 ../rel/hdl_dumb.exe
make clean
cd ../

cd svr
make clean
make
mv IOP_PKTDRV.elf ../rel/
ps2-packer ../rel/IOP_PKTDRV.elf ../rel/hdl_svr_093.elf
rm -rf ../rel/IOP_PKTDRV.elf
make clean
cd ../

cp open-ps2-loader/diskload.elf rel/boot.elf
cp README rel/README.txt

cd rel/
zip -9 hdl_dumx.zip hdl_* boot.elf README.txt
cd ../
