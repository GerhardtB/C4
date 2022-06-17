#!/usr/bin/bash
######################################################################################### 
# Author Helen Moor
# Purpose: download and reformat worldclim climate data and other spatial data, 
# to compile a GRASS GIS database for Europe (Worldclim) and Sweden (all data)
# adapted to MacOSX 9, MacBook
#########################################################################################


#### 1. Create GRASS database
## prepare GRASS:
# MacOS 9: to be able to open grass in commandline, first:
# - add to .bash-profile: 
#	export PATH="/usr/X11R6/bin:$PATH"
#	alias grass="open -a GRASS-6.4.app"
# - open GRASS in existing GISDATABASE, and type the following to set -text to default: 
#	g.gui -un gui=text


##################################################################################

#### 2. Get data and import data into Grassdb:

######### Location EUROPE (for Worldclim data only)
# enter grass in GISDATABASE: GRASSDB, Location: europeWGS84, MAPSET:PERMANENT
grass ~/Documents/GISdata/GRASSDB/europeWGS84/PERMANENT
# check:
g.gisenv
g.region -p # extent is europe (set up in qgis)
# change resolution to 30 arcsecs:
g.region nsres=0:00:30 ewres=0:00:30  

#############################################
######### WORLDCLIM DATA 
# download, unzip and save raster data from worldclim 
# (.bil, 30 arc sec resolution, epsg 4326):

# cd to input working directory:
cd ~/Documents/GISdata/Worldclim

# create folders to hold downloaded data:
mkdir worldclim_current_tmp  worldclim_future_tmp

######### CURRENT CONDITIONS:
#####  1. download 5 zip files for current climate: tmin, tmax, prec, bio1-9, bio10-19
cd ~/Documents/GISdata/Worldclim/worldclim_current_tmp

## download, unzip, fix header, remove .zip:

for layer in tmin tmax prec bio1-9 bio10-19; do	
	curl -L -O "http://biogeo.ucdavis.edu/data/climate/worldclim/1_4/grid/cur/"$layer"_30s_bil.zip"  
	unzip $layer"_30s_bil" 
	
	# if else statement for different filenaming with respect to zipfilename
	if [ "$layer" == tmin ] || [ "$layer" == tmax ] || [ "$layer" == prec ] ; then 
	
	# fix the problem with the missing header: 
        # (http://duncanjg.wordpress.com/2010/08/09/import-worldclim-data-into-grass/):
		for i in $(seq 1 12); do 
			echo -e "PIXELTYPE     SIGNEDINT\r" >>$layer"_"$i.hdr; # append "PIXELTYPE SIGNEDINT" to each hdr file
		done 

	elif [ "$layer" == bio1-9 ]; then
		for i in $(seq 1 9); do 
			echo -e "PIXELTYPE     SIGNEDINT\r" >>"bio_"$i.hdr;
		done 
	else
		for i in $(seq 10 19); do 
			echo -e "PIXELTYPE     SIGNEDINT\r" >>"bio_"$i.hdr;
		done 
	
	fi	
	rm $layer"_30s_bil.zip"
done

# check what is there:
gdalinfo $layer"_1.bil"

##### 2. cut all .bil files to europe extent (same as in location europeWGS84); output as Gtiff 

for layer in tmin tmax prec bio; do	
	if [ "$layer" == bio ]; then
		for i in $(seq 1 19); do
			gdalwarp -te -25.1 34.9 35 71.3 $layer"_"$i.bil eu_$layer"_"$i.tif
		done
	else 
		for i in $(seq 1 12); do
			gdalwarp -te -25.1 34.9 35 71.3 $layer"_"$i.bil eu_$layer"_"$i.tif
		done
	fi
done
	
# check:
gdalinfo "eu_"$layer"_1.tif"  

## remove original bil/hdr files:
rm *.hdr; rm *.bil

##### 3. import the tifs into GRASS

# tmin, tmax, prec: 12 files for 12 months
for layer in tmin tmax prec bio; do	
	for i in $(seq 1 12); do r.in.gdal -o input=eu_$layer"_"$i.tif output=$layer$i; done
done
# biovars: 19 files
layer=bio
for i in $(seq 1 19); do r.in.gdal -o input=eu_$layer"_"$i.tif output=$layer$i; done

# check:
g.list type=rast
r.info map=tmin1


######### FUTURE CONDITIONS:
# Climate scenario: 2070 (70), GCM: HadGEM2-AO (HD), RCP: rcp60 (60)
# cd to folder for future:
cd ~/Documents/GISdata/Worldclim/worldclim_future_tmp/
mkdir -p europetmp 

##### 1. download and unzip (these files are in .tif already; type=float32)

for layer in tn tx pr bi; do	
	curl -L -O "http://biogeo.ucdavis.edu/data/climate/cmip5/30s/hd60"$layer"70.zip"
	unzip "hd60"$layer"70.zip"
	rm "hd60"$layer"70.zip"
	# clip to Europe extent
	if [ "$layer" == bi ] ; then  
		for i in $(seq 1 19); do
			gdalwarp -te -25.1 34.9 35 71.3 "hd60"$layer"70"$i".tif" europetmp/"eu_hd60"$layer"70"$i".tif"
		done
	else
		for i in $(seq 1 12); do
			gdalwarp -te -25.1 34.9 35 71.3 "hd60"$layer"70"$i".tif" europetmp/"eu_hd60"$layer"70"$i".tif"
		done
	fi
	rm "hd60"$layer"70"*.tif  # clean up on the go
done

## remove original bil/hdr files:
rm *.hdr; rm *.bil

##### 2. import the tifs into GRASS

# tmin, tmax, prec: 12 files for 12 months 
for layer in tn tx pr; do	
	for i in $(seq 1 12); do r.in.gdal -o input=europetmp/eu_hd60$layer"70"$i.tif output=70hd60$layer$i; done
done
# biovars: 19 files
layer=bi
for i in $(seq 1 19); do r.in.gdal -o input=europetmp/eu_hd60$layer"70"$i.tif output=70hd60$layer$i; done

# check:
g.list type=rast
r.info map=tmin1