









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
