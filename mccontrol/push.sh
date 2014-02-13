#!/bin/bash
#push.sh
# mcControl / MultiCraft easy plugin Updater
# push (update plugins) bash File

pluginname=$2
ServerID=$3

push_plugin () {
#If the file is not .jar
if [ $pluginname == "list" ]
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
		echo "Only .jar Files can be Pushed"
		exit
#main function
#check if the file exist
	elif [ ! -e $mc_path/plugins/$pluginname ]
		then
			echo "This plugin does NOT already exist. Use - add - instead."
	else
	#if there is no URL specified
		if [ [ $# != 3 ] ]
			then
				echo "You need to specify a ServerID"
		elif [[ $ServerID != *[!0-9]* ]] && [ [ $# == 3 ] ]
			then
				if [ -e $mc_path/servers/server$ServerID ]
					then
						echo"The specified server does not exist."
				else
				cp $mc_path/plugins/$pluginname $mc_path/servers/server$ServerID/plugins/$pluginname
					if [ $? -ne 0 ]
						then
							echo "There was an error while Pushing your plugin"
					else
						echo "..Plugin was Updated"
					fi
				fi
		elif [ $ServerID == "all" ] && [ [ $# == 3 ] ]
			then
				for i in "${serversIDarray[@]}"
					do
						if [ -e $mc_path/servers/server$i/$pluginname ]
							then
								cp $mc_path/plugins/$pluginname $mc_path/servers/server$i/plugins/$pluginname
								if [ $? -ne 0 ]
									then
										echo "There was an error while Pushing your plugin to Server$ServerID"
								else
									echo "..Plugin was Updated on Server$ServerID"
								fi
						fi
					done
		else
			echo "Unknown ServerID format"
		fi
fi	
}	