#!/usr/bin/env bash

for i in *.shp;do
  echo $i
  gdalwarp -cutline $i -crop_to_cutline -dstalpha /home/johanes/Desktop/Dar_Es_Salaam_Block02_1.tif $i.tif
done
wait
for i in *.tif; do
  echo $i
  gdal_translate $i $i.mbtiles -of MBTILES -co TILE_FORMAT=JPEG
done
for i in *.mbtiles; do
  echo $i
  gdaladdo -r average $i 2 4 8 16 32 64 128 256 512 1024
done
