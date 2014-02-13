#!/bin/bash
# mccontrol.sh
# mcControl / MultiCraft easy plugin Updater
# main bash file
# INCLUDES
source /etc/mccontrol/add.sh
source /etc/mccontrol/update.sh
source /etc/mccontrol/push.sh
source /etc/mccontrol/config.cfg
#assign Command Variable
optionchoice=$1

if [ $optionchoice == "add" ]
	then
		add_file $arg2 $arg3 $arg4
elif [ $optionchoice == "update" ]
	then
		update_plugin $arg2 $arg3
elif [ $optionchoice == "push" ]
	then
		push_plugin $arg2 $arg3
		
	


fi