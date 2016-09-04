#!/system/bin/sh
# Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

# No path is set up at this point so we have to do it here.
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

# +++ bsp Shawn_Huang create symbolic link to vadc
FILES=`ls /sys/devices/soc.0/`
search_vadc=qpnp-vadc
bFound=0
for name in $FILES
do
        search_vadc_temp=${name:0:${#search_vadc}}
        if [ "$search_vadc"x = "${search_vadc_temp}"x ]; then
		bFound=1
		break
        fi
done

if [ "$bFound" == "1" ]; then
	mkdir -p /dev/therm/
	chmod 755 /dev/therm/
	mkdir -p /dev/therm/vadc
	chmod 755 /dev/therm/vadc
	ln -s /sys/devices/soc.0/$name/xo_therm /dev/therm/vadc/msm_therm
	ln -s /sys/devices/soc.0/$name/pa_therm0 /dev/therm/vadc/pa_therm0
fi
# --- bsp Shawn_Huang create symbolic link to vadc

start thermal-engine

# +++ BSP Shawn_Huang create symbolic link for run-in test
ln -s /sys/class/thermal/thermal_zone0/mtemp /data/data/Thermal0
ln -s /sys/class/thermal/thermal_zone1/mtemp /data/data/Thermal1
ln -s /sys/class/thermal/thermal_zone2/mtemp /data/data/Thermal2
ln -s /sys/class/thermal/thermal_zone3/mtemp /data/data/Thermal3
ln -s /sys/class/thermal/thermal_zone4/mtemp /data/data/Thermal4
ln -s /sys/class/thermal/thermal_zone5/temp /data/data/Thermal5
ln -s /sys/class/thermal/thermal_zone6/temp /data/data/Thermal6
ln -s /sys/class/thermal/thermal_zone7/temp /data/data/Thermal7
ln -s /dev/therm/vadc/pa_therm0 /data/data/Thermal8
ln -s /dev/therm/vadc/msm_therm /data/data/Thermal9
sleep 10
echo 10 > /data/data/ThermalCount
chmod 664 /data/data/ThermalCount
# --- BSP Shawn_Huang creat symbolic link for run-in test
