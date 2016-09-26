#!/bin/bash

###################################################################################
## if after running this script, you experience one of the scripts being run everytime a
## new terminal window is opened, you will need to change your terminal preferences
## to make windows open to the default path (I set mine to my home dir) in preferences 
## on the general tab. Set 'New windows open with' and 'New tabs open with' to 
## 'Default Profile' and 'Default Working Directory' in the corresponding pair of 
## drop downs. This worked for me, YMMV.
####################################################################################

#############################################################
### This is where to configure your root directory paths ####

learnutilPath="/Users/rallen/learn.util"
ultraUiPath="/Users/rallen/work/git/ultra-ui"
ultraRouterPath="/Users/rallen/ultra-router"

############################################################

for i in "$@"
do
case $i in
    -c|--clean)
      SET_CLEAN_FLAG=--clean
      runUpdate=1;
    ;;  
    -u|--update)
      runUpdate=1
    ;;  
    -g|--goodmorning)
      runGoodMorning=1
    ;;  
    -r|--router)
      runUltraRouter=1
    ;;  
esac
done

####################################################################
### If no parameters given then run all the scripts for the day. ###
if [ $# -eq 0 ]; then
    runAll=1
fi


#################################################################
### Check to make sure all the configured paths are reachable ###
if [ ! -d "$learnutilPath" ]; then 
  emsg="learnUtil Path not found"
fi 

if [ ! -d "$ultraUiPath" ]; then
  emsg="$emsg. Ultra Ui Path not found"
fi

if [ ! -d "$ultraRouterPath" ]; then
  emsg="$emsg. Ultra Router Path not found"
fi

if [ "$emsg" ]; then
  echo "You have issues: $emsg"
  echo "Check your refreshBb.config file."
  exit 1
fi


timestamp() {
  date +"%s"
}

#############################
### The meat and potatoes ###

function updateCmd () {
osascript <<-AppleScript
  tell application "Terminal"
   do script "cd $ultraUiPath;./update.sh $SET_CLEAN_FLAG"
  end tell
AppleScript
}


function goodMorning () {
osascript <<-AppleScript
 tell application "Terminal"
  set a to do script "cd $learnutilPath;git pull;"
  repeat 
   delay 0.1 
   if not busy of a then exit repeat
  end repeat
  set b to do script "cd $learnutilPath;git_goodMorning git;"
 end tell
AppleScript
}


function ultraRouter () {
osascript <<-AppleScript
 tell application "Terminal"
  set d to do script "cd $ultraRouterPath;git pull;"
  repeat
   delay 0.1
   if not busy of d then exit repeat
  end repeat
  set e to do script "cd $ultraRouterPath;git submodule update --init"
 end tell
AppleScript
}


#########################################################################################
### Parameter set flags to control what to run when not running everything is desired ###

if [ $runGoodMorning ]; then
    goodMorning
fi

if [ $runUpdate ]; then 
    updateCmd
fi

if [ $runUltraRouter ]; then
    ultraRouter
fi


################################################################
### The default behaviour of running everything happens here ###
if [ $runAll ]; then
    goodMorning
    updateCmd
    ultraRouter
fi

