#!/bin/bash

##############################################
## Set the root directory paths here        ##

learnUtilPath=/Users/rallen/learn.util
ultraRouterPath=/Users/rallen/ultra-router
ultraUiPath=/Users/rallen/work/git/ultra-ui

##############################################

flag=true

if [ ! -d "$learnUtilPath" ]; then
	emsg="learn.util directory not found."
	flag=false
fi

if [ ! -d "$ultraRouterPath" ]; then
	emsg="$emsg ultra-router directory not found."
	flag=false;
fi

if [ ! -d "$ultraUiPath" ]; then
	emsg="$emsg ultra-ui directory not found."
	flag=false
fi

if [ "$emsg" ]; then
echo "Not Doing it"
echo "You have issues: $emsg"
exit 1
fi

osascript <<END

tell application "Terminal"
    set a to do script "cd /Users/rallen/learn.util;startLearn;"
    repeat
     delay 0.1
      if not busy of a then exit repeat
    end repeat
    set c to do script "cd /Users/rallen/ultra-router;./start;"
    set b to do script "cd /Users/rallen/work/git/ultra-ui;grunt develop;"
end tell

END

