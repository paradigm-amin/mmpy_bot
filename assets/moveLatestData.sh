#! /bin/sh
# Declaring & Initializing Variables
computerDir="/Users/aminelabida/workRepository/"
repositoryDir="${computerDir}mmpy_bot/assets/config/"
masterDir="${repositoryDir}master/"
listenFile="${repositoryDir}tmp/listenText.txt"
responseFile="${repositoryDir}tmp/responseText.txt"
masterFile="${masterDir}masterMessage.txt"
tagListenFile=$(tail -n 1 $listenFile)
tagResponseFile=$(tail -n 1 $responseFile)

# Moving tmp data files to the master file location
function moveFiles(){

echo $tagListenFile
echo $tagResponseFile
        if  [ $tagListenFile -eq $tagResponseFile ];
        then
              cp $responseFile $masterDir
              cp $listenFile $masterDir
        else
              echo "No master files exist"
        fi
}
moveFiles
