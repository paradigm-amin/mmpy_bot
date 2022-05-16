#! /bin/sh
# Declaring & Initializing Variables
computerDir="/Users/aminelabida/workRepository/"
projectDir="/Users/aminelabida/workRepository/mmpy_bot/"
myPluginFile="${projectDir}my_plugin.py"
scriptDir="${projectDir}assets/scripts/"
repositoryDir="${computerDir}mmpy_bot/assets/config/"
listenFile="${repositoryDir}tmp/listenText.txt"
responseFile="${repositoryDir}tmp/responseText.txt"
masterFile="${repositoryDir}master/masterMessage.txt"
tagListenFile=$(tail -n 1 $listenFile)
tagResponseFile=$(tail -n 1 $responseFile)

# Connect to MySQL DB, and execute the queries
function startScripts(){
/bin/bash "$scriptDir/getLatestData.sh";
/bin/bash "$scriptDir/moveLatestData.sh";
/bin/bash "$scriptDir/mergeData.sh";

}

# Connect to MySQL DB, and execute the queries
function checkData(){
        queryDB1=$(mysql -sN -uroot -hlocalhost -e "SELECT DISTINCT responseText FROM mattermostbot_dev1.ap_messages_request WHERE status = 1 ;")
        
        queryLocal1=$(sed -n 'p;n' $responseFile)

        if [[ $queryLocal1 == $queryDB1 ]] ;
        then
        status=1;
        else
        status=0;
        fi

        queryDB2=$(mysql -sN -uroot -hlocalhost -e "SELECT DISTINCT listenText FROM mattermostbot_dev1.ap_messages_request WHERE status = 1 ;")
        queryLocal2=$(sed -n 'p;n' $listenFile)
        
#        echo "$queryDB1"
#        echo " "
#
#        echo "$queryLocal1"
#        echo " "
#
#        echo "$queryDB2"
#        echo " "
#
#        echo "$queryLocal2"
#        echo " "

        if [[ $queryLocal2 == $queryDB2 ]] ;
        then
        status2=1;
        else
        status2=0;
        fi
        
        if [ $status -ne 0 ] && [ $status2 -ne 0 ];  then
        successReport
        exit
        else
        errorReport
        fi
        
}

startScripts
