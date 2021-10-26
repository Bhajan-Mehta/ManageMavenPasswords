#!/bin/bash

# Variables
SETTTINGS_MASTER_FILE="settings-security.xml"
TEMP_PWD_FILE="passwords.txt"
SETTTINGS_FILE="settings.xml"
PWD_CHANGE_COUNTER=0;
MAX_RETRY=10;


currentDriectoryName=${PWD##*/} 
echo $currentDriectoryName

if [ $currentDriectoryName != ".m2" ]
then
	echo "============================================================================="
	echo "This utility program needs to executed from from <YOUR_PROFILE>/.m2 directory"
	echo "Moving this file to .m2 directory"
	echo "It will work, if you have admin writes to this directory"
	mv $0 ~/.m2
	echo "File moved to .m2 directory"
	cd ~/.m2
	echo "Auto execution is starting now again..."
	./$0
	exit 1;
fi

if [ ! -f $SETTTINGS_FILE ]
then
	echo "==========================================================================="
	echo "settings.xml file doesn't exit so no need to replace any passwords."
	echo "You can run this utility file when you have settings.xml file .m2 directory"
	echo "You can try this again once you set-up settings.xml file."
	echo "==========================================================================="
	exit 1;
else	
	cp $SETTTINGS_FILE $SETTTINGS_FILE.bak;
	echo "==========================================================================="
	echo "Backup file created for settings.xml in .m2 directory."
fi

if [ -f  $SETTTINGS_MASTER_FILE ]
then
	echo $SETTTINGS_MASTER_FILE "file exists, using existing one"
else
	echo "===========================================================================";
	echo "Need to create " $SETTTINGS_MASTER_FILE " file, please provide master password: ";
	read masterPassword;
	echo "You master password " $masterPassword ;
	encryptedMasterPassword=$(mvn --encrypt-master-password $masterPassword);
	echo "Encrpted Password is : " $encryptedMasterPassword
	
	fileFormat='<settingsSecurity>
  <master>%s</master>
</settingsSecurity>'
	printf "$fileFormat" "$encryptedMasterPassword" > $SETTTINGS_MASTER_FILE
	
fi
#read p 

grep -oP "<password>[^{](.*)</password>" $SETTTINGS_FILE | sed 's#<[^>]*>##g' > $TEMP_PWD_FILE
exec 0<$TEMP_PWD_FILE

while read line 
do
	echo ""
	inner_counter=1
	while [ $inner_counter -le $MAX_RETRY ]
	do
		enc_password=$(mvn --encrypt-password $line);
		echo $line " changed to " $enc_password;
		sed -i s/$line/$enc_password/g $SETTTINGS_FILE;
		if [ $? -eq 0 ] 
		then
			inner_counter=$(( $MAX_RETRY+1 ));
			PWD_CHANGE_COUNTER=$(( PWD_CHANGE_COUNTER + 1 ));
			echo "---- Successful -----";
		else
			echo "----- Retrying ----";
		fi
	done;
done
rm $TEMP_PWD_FILE

# echo "------- Counter value ----- " $PWD_CHANGE_COUNTER;

if [ $PWD_CHANGE_COUNTER -eq 0 ]
then
	echo "-----------------------------------------------------------------------";
	echo "No plain text passwords found, so there is nothing to replace";
	echo "Any password starting with { will not be relaced by this program."
	echo "-----------------------------------------------------------------------";
else
	plainTextPasswords=$(grep -oP "<password>[^{]</password>" settings.xml | wc -l);
	# echo "Numer of passwords in plain text after replacement: " $plainTextPasswords;
	if [ $plainTextPasswords -gt "0" ]
	then
		echo "=================================================================="
		echo "Below listed passwords need to update manually. User below command";
		echo "mvn --encrypt-password <PLAIN_TEXT_PASSWORD>"
		grep -oP "<password>[^{](.*)</password>" $SETTTINGS_FILE;
		echo "=================================================================="
	else
		echo "=================================================================="
		echo $PWD_CHANGE_COUNTER " passwords are replaced successfully.........."
		echo "=================================================================="
	fi

fi
