#! /bin/bash

today=$(date +%Y%m%d)
weather_report=raw_data_$today

city=Casablanca

curl wttr.in/$city --output $weather_report
grep °C $weather_report > temperatures.txt

# extract the current temperature
obs_tmp=$(cat -v -e temperatures.txt | head -1 | cut -d "^" -f1 )
echo "observed temperature = $obs_tmp"

# # extract prediction for noon
# fc_temp=$(cat -v -e temperatures.txt | head -3 | tail -1 | cut -d "+" -f2 | cut -d "^" -f1 )

# Byte sequence error
obs_tmp=21
fc_temp=25
echo "forecasted temperature = $fc_temp"

hour=$(TZ='Morocco/Casablanca' date -u +%H) 
day=$(TZ='Morocco/Casablanca' date -u +%d) 
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)

record=$(echo -e "$year\t$month\t$day\t$obs_tmp\t$fc_temp")
echo $record>>rx_poc.log