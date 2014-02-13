#!/bin/bash
#update.sh
# mcControl / MultiCraft easy plugin Updater
# update (plugins) bash File

source /etc/mccontrol/config.cfg
source /etc/mccontrol/urlRepos.txt

pluginname=$2
URL=$3

update_plugin () {
if [ -z $filename ]
	then
		echo "You need to specify a File name to Update"
#If the file is not .jar
elif [ $pluginname == "list" ]
#if 'list' is triggered
	then
		ls $mc_path/plugins
elif [ $pluginname == "help" ]
#if 'help' is triggered
	then
		echo "HELP TEXT HERE"
#Check if the file is a .jar
elif [[ $pluginname != *.jar* ]]
	then
		echo "Only .jar Files can be Updated"
		exit
#main function
#if the file is a .jar
	elif [[ $pluginname == *.jar* ]]
		then
		#check if the file already exist
			if [ ! -e $mc_path/plugins/$pluginname ]
				then
					echo "This plugin does NOT already exist. Use - add - instead."
				else
				#if there is no URL specified
					if [ -z $URL ]
						then
						pluginnamemjar=${pluginname%%????}
							if [ ${pluginnamemjar} ]
								then
									urlns=${!pluginnamemjar}
									wget -O $mc_path/plugins/$pluginname $urlns
								if [ $? -ne 0 ]
									then
										echo "There was an error while Updating your plugin"
								else
									echo "..Done Updating"
								fi
							else
								echo "This plugin doesnt have a static URL. You need to specify it."
							fi
					elif [ -n $URL ]
						then
							wget -O $mc_path/plugins/$pluginname $URL
								if [ $? -ne 0 ]
									then
										echo "There was an error while Updating your plugin"
								else
									echo "..Done Updating"
								fi
						
					fi
			fi		
fi
}