#! /bin/sh
# Declaring & Initializing Variables
computerDir="/Users/aminelabida/workRepository/"
repositoryDir="${computerDir}mmpy_bot/assets/config/"
listenFile="${repositoryDir}tmp/listenText.txt"
responseFile="${repositoryDir}tmp/responseText.txt"
masterFile="${repositoryDir}master/masterMessage.txt"
tagListenFile=$(tail -n 1 $listenFile)
tagResponseFile=$(tail -n 1 $responseFile)
status=0
status2=0


# Function that checks if the files are on the latest status
function checkStatus(){
        lastMessageRequestID=$(mysql -sN -uroot -hlocalhost -e "SELECT MAX(id_messagesRequest) FROM mattermostbot_dev1.ap_messages_request WHERE status != 0;")
        if [ $lastMessageRequestID -lt $tagResponseFile ]
        then
                rm $responseFile
                rm $listenFile
                checkResponseListen
        elif [ $lastMessageRequestID -gt $tagResponseFile ]
        then
                fetchData
        elif [ $lastMessageRequestID -eq $tagResponseFile ]
        then
       
                statusReporting
        else
                errorReport
        fi
            
}

# Checking Response to Listen
function checkResponseListen(){
        if [ -z "$tagListenFile" ];
        then
                echo "No master files exist"
                tagResponseFile=0
                tagListenFile=1
                checkStatus
        elif  [ $tagListenFile -ne $tagResponseFile ];
        then
                echo "Masterfiles dont correlate"
                echo "Deleting files"
                rm $responseFile
                rm $listenFile
                
        elif  [ $tagListenFile -eq $tagResponseFile ];
        then
                checkStatus
                
        else
                echo "Something went wrong in the master files... will delete"
                errorReport
        fi
}

# Connect to MySQL DB, and execute the queries
function fetchData(){
        echo "Fetching data ***"
        while [ $tagListenFile -ne $tagResponseFile ] || [ $lastMessageRequestID -gt $tagResponseFile ]
        do
        echo "$lastMessageRequestID"
        if [ $lastMessageRequestID -gt $tagResponseFile ];
        then
        tagResponseFile=$((tagResponseFile + 1))
        echo $tagResponseFile
        mysql -sN -uroot -hlocalhost -e "SELECT DISTINCT responseText FROM mattermostbot_dev1.ap_messages_request WHERE status = 1 AND id_messagesRequest= ${tagResponseFile};" >> $responseFile
        echo $tagResponseFile >> $responseFile
        mysql -sN -uroot -hlocalhost -e "SELECT DISTINCT listenText FROM mattermostbot_dev1.ap_messages_request WHERE status = 1 AND id_messagesRequest= ${tagListenFile};" >>  $listenFile
        echo $tagListenFile >> $listenFile
        
        tagListenFile=$((tagListenFile + 1))
        
        else
            statusReporting
        fi
        
        done
        
}

# Giving the user a report of the lastest stand of the files
function statusReporting(){
                echo "The master files are up to date"
                exit 1
}

# Giving the user a report of the lastest stand of the files
function errorReport(){
                echo "Something went wrong in the master files... s delete"
                rm $responseFile
                rm $listenFile
                checkResponseListen
}

# Giving the user a report of the lastest stand of the files
function successReport(){
                echo "Everything is checked"
                exit 1
}

# Call on function to start script
checkResponseListen
