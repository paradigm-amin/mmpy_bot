#! /bin/sh
# Declaring & Initializing Variables
computerDir="/Users/aminelabida/workRepository/"
projectDir="/Users/aminelabida/workRepository/mmpy_bot/"
myPluginFile="${projectDir}my_plugin.py"
repositoryDir="${computerDir}mmpy_bot/assets/config/"
listenFile="${repositoryDir}tmp/listenText.txt"
responseFile="${repositoryDir}tmp/responseText.txt"
masterFile="${repositoryDir}master/masterMessage.txt"
tagListenFile=$(tail -n 1 $listenFile)
tagResponseFile=$(tail -n 1 $responseFile)

# Connect to MySQL DB, and execute the queries
function addBotKeys(){
        
lineOne="    @listen_to(\"wake up\")"
lineTwo="    async def wake_up(self, message: Message):"
lineThree="         self.driver.reply_to(message, \"Im awake\")"

IFS=$'\n' read -d '' -r -a lines < $listenFile
for index in "${!lines[@]}"; do
        if [[ $((index % 2)) == 0 ]];
        then
        secondString="${lines[index]}"
        fi
done
:

IFS=$'\n' read -d '' -r -a lines2 < $responseFile
for index in "${!lines2[@]}"; do
        if [[ $((index % 2)) == 0 ]];
        then
        secondString2="${lines2[index]}"
        echo $secondString2
        fi
done
:

echo "${lineOne/wake up/$secondString}" >> $myPluginFile
echo "${lineTwo/wake_up/$secondString}" >> $myPluginFile
echo "${lineThree/Im awake/$secondString2}" >> $myPluginFile



        
}
addBotKeys
