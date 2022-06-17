#!/bin/bash

/home/pi/bin/snuff ncftp

cd /home/gerhardt/RadarData/2021_FieldCampaings/NorthamLT_PM10
ncftp ecostat << EOF
cd Northam_ES642_PM10
get -r RawData
EOF

/home/pi/bin/snuff ncftp

cd /home/gerhardt/RadarData/2021_FieldCampaings/NorthamLT_PM25
ncftp ecostat << EOF
cd DES07
get -r RawData
EOF

/home/pi/bin/snuff ncftp

cd /home/gerhardt/RadarData/2021_FieldCampaings/06_VaalLCS01_PM25
ncftp ecostat << EOF
cd LCS01
get -r RawData
EOF

/home/pi/bin/snuff ncftp

cd /home/gerhardt/RadarData/2021_FieldCampaings/07_VaalLCS02_PM25
ncftp ecostat << EOF
cd LCS02
get -r RawData
EOF


/home/pi/bin/snuff ncftp

cd /home/gerhardt/RadarData/2021_FieldCampaings/WatervalLT_PM10
ncftp ecostat << EOF
cd Waterval_ES642_PM10
get -r RawData
EOF

/home/pi/bin/snuff ncftp

cd /home/gerhardt/RadarData/2021_FieldCampaings/WatervalLT_PM25
ncftp ecostat << EOF
cd DES08
get -r RawData
EOF
