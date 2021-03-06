#!/bin/bash
#add.sh
# mcControl / MultiCraft easy plugin Updater
# add (plugins or worlds) bash File

source /etc/mccontrol/config.cfg

#set variable
filename=$2
add_Url=$3
ServerID=$4

add_file () {
#If the file is not .jar or .zip
#if 'list' is triggered
if [ -z $filename ]
	then
		echo "You need to specify a File name or an Option (help - list)"
elif [ $filename == "list" ]
	then
		ls $mc_path/plugins
#if 'help' is triggered
elif [ $filename == "help" ]
	then
		echo "HELP TEXT HERE"
elif [[ $filename != *.jar* ]] && [[ $filename != *.zip* ]]
	then
		echo "Only .jar and .zip Files can be added"

#main function
#if the file is a .jar
		elif [[ $filename == *.jar* ]]
			then
			#check if the file already exist
				if [ -e $mc_path/plugins/$filename ]
					then
						echo "This plugin already exist. Use - update - instead."
										#if there is no Url specified
					elif [ -z $add_Url ]
							then
								echo "You need to specify the URL to download from"
						elif [ -n $add_Url ]
							then
								read -p "Does this plugin have a static update Link? (y/n) " RESP
									if [ "$RESP" = "y" ]
										then
									#remove repos line and add the new one
											filenamemjar="${filename%%????}"
											sed -i /$filenamemjar=.*/d /etc/mccontrol/urlRepos.txt
											echo "$filenamemjar=$add_Url" >> /etc/mccontrol/urlRepos.txt
									else
										echo "The plugin have no static URL to download from. You will have to enter the new URL each time you update the plugin"
										continue
									fi
								#download the plugin in the plugin folder
							wget -O $mc_path/plugins/$filename $add_Url
							if [ $? -ne 0 ]
								then
									echo "There was an error while adding your .jar file"
							else
								echo "..Done"
							fi
				fi
#if the file is a .zip
		elif [[ $filename == *.zip* ]]
			then
				if [ -z $ServerID ]
				#if the server ID is not specified
					then
						echo "You need to add the ServerID when adding a .zip file."
				elif [ -e $mc_path/servers/server$ServerID/${filename%%????} ]
				#if the File that will be unziped already exist in the specified server
					then	
						echo "This file already Exist in server$ServerID Please use another name."
					else
						wget -o /tmp/$filename $add_Url
						unzip /tmp/$filename -d $mc_path/servers/server$ServerID/${filename%%????}
							if [ $? -ne 0 ]
								then
									echo "There was an error while adding your .zip file"
							else
								echo "..Done Unzipping"
							fi
				fi
			
			
fi	
}					