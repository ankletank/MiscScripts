# bbUpdateRunScripts
scripts for work

Using the bash scripts

UPDATE SCRIPT == refreshBb.sh
First, open the refreshBb.sh and configure the root directory paths


Script Useage
./refreshBb.sh
this will run everything. It will only do so if it hasn’t already ran for the day. To force run after the first run of the day
you will need to delete ./refreshBbLastRun.txt file. I intend for this to be used in conjunction with cron to run this in the mornings automatically

Script Useage
./refereshBb.sh -g
or
./refereshBb.sh —goodmorning
Will only run the 'learnUtil git pull' and then the 'git_goodMorning git’ scripts.

Script Useage
./refreshBb.sh -r
or
./refreshBb.sh —router
Will only run git pull in the Ultra router directory.

Script Useage
./refreshBb.sh -u
or
./refreshBb.sh —update
Will only run the update.sh script

Script Useage
./refreshBb.sh -c
or
./refreshBb.sh —clean
Will only run the update.sh script using the —clean parameter


Start learn Script == runLearn.sh 

Script Useage
./runLearn.sh
runs all the commands to start a learn intstallation including
learn.util/startLearn
/ultra-router/start
/ultra-ui/grunt develop


TO SCHEDULE THE UPDATE SCRIPTS TO RUN AT A CERTAIN TIME EVERY DAY

To start a newly added plist schedule run
launchctl load ~/Library/LaunchAgents/net.ryan.refresh.plist 
To unload (stop) a plist schedule run the following
launchctl unload ~/Library/LaunchAgents/net.ryan.refresh.plist

PLIST file for launchd. Create a file named similar to the example of net.ryan.refresh.plist. Copy paste the xml below
into the file customizing it to your needs. Put this file in the user's LaunchAgents folder (~/Library/LaunchAgents/)
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Disabled</key>
	<false/>
	<key>EnvironmentVariables</key>
	<dict>
		<key>PATH</key>
		<string>/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin</string>
	</dict>
	<key>Label</key>
	<string>net.ryan.refresh</string>
	<key>ProgramArguments</key>
	<array>
		<string>/Users/rallen/./refreshBb.sh</string>
	</array>
	<key>StartCalendarInterval</key>
	<array>
		<dict>
			<key>Hour</key>
			<integer>8</integer>
			<key>Minute</key>
			<integer>56</integer>
		</dict>
	</array>
</dict>
</plist>
