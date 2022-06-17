#!/bin/bash

cat /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/02_NorthamLT_PM10/RawData/ES642* >> /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/2021_AllLocations_DailyData/"ES642_NorthamLT_PM10_$(date +%Y%m%d_%H%M).csv"

cat /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/03_NorthamLT_PM25/RawData/ES642* >> /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/2021_AllLocations_DailyData/"ES642_NorthamLT_PM25_$(date +%Y%m%d_%H%M).csv"

cat /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/04_WatervalLT_PM10/RawData/ES642* >> /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/2021_AllLocations_DailyData/"ES642_WatervalLT_PM10_$(date +%Y%m%d_%H%M).csv"

cat /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/05_WatervalLT_PM25/RawData/ES642* >> /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/2021_AllLocations_DailyData/"ES642_WatervalLT_PM25_$(date +%Y%m%d_%H%M).csv"

cat /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/06_VaalLCS01_PM25/RawData/ES642* >> /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/2021_AllLocations_DailyData/"ES642_VaalLCS01_PM25_$(date +%Y%m%d_%H%M).csv"

cat /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/07_VaalLCS02_PM25/RawData/ES642* >> /home/gerhardt/CRG2020_DATA/ES642/2021_FieldCampaings/2021_AllLocations_DailyData/"ES642_VaalLCS02_PM25_$(date +%Y%m%d_%H%M).csv"

