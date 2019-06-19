#!/usr/bin/env bash

RAW=$(/usr/local/bin/OpenCorsairLink --device 0)

function simple() {
	echo $(echo "$RAW" | grep "$1" | cut -d ':' -f2 | cut -d ' ' -f 2)
}
function rail() {
	echo $(echo "$RAW" | grep -A 3 "Output ${1}v" | grep "$2" | tr -s ' ' | cut -d ' ' -f 2)
}

temp_0=$(simple "Temperature 0")
temp_1=$(simple "Temperature 1")
powered=$(simple "Powered")
uptime=$(simple "Uptime")
supply=$(simple "Supply Voltage")
total_watts=$(simple "Total Watts")

# 12V Rail
volts_12v=$(rail "12" "Voltage")
amps_12v=$(rail "12" "Amps")
watts_12v=$(rail "12" "Watts")

# 5V Rail
volts_5v=$(rail "5" "Voltage")
amps_5v=$(rail "5" "Amps")
watts_5v=$(rail "5" "Watts")

# 3.3V Rail
volts_3_3v=$(rail "3.3" "Voltage")
amps_3_3v=$(rail "3.3" "Amps")
watts_3_3v=$(rail "3.3" "Watts")

# InfluxDB output
echo "power_supply temp_0=$temp_0,temp_1=$temp_1,total_time=$powered,uptime+$uptime,supply_volts=$supply,total_watts$total_watts,12v_volts=$volts_12v,12v_amps=$amps_12v,12v_watts=$watts_12v,5v_volts=$volts_5v,5v_amps=$amps_5v,5v_watts=$watts_5v,3.3v_volts=$volts_3_3v,3.3v_amps=$amps_3_3v,3.3v_watts$watts_3_3v $(date '+%s%N')"

# CSV output
#echo "measurement,temp_0,temp_1,total_time,uptime,supply_voltage,total_watts,12v_volts,12v_amps,12v_watts,5v_volts,5v_amps,5v_watts,3.3v_volts,3.3v_amps,3.3v_watts"
#echo "power_supply,$temp_0,$temp_1,$powered,$uptime,$supply,$total_watts,$volts_12v,$amps_12v,$watts_12v,$volts_5v,$amps_5v,$watts_5v,$volts_3_3v,$amps_3_3v,$watts_3_3v"
