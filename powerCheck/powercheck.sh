#!/bin/bash

# --------
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# --------
#
# Written by J Gifford < http://JeffreyGifford.com >
# A script to monitor the power status (Battery Power vs AC Power)
# for Macintosh systems
# Works with both MacBook hardware and Mac Mini hardware
# (using an APC UPS connected via USB)
# Do **NOT** use APC PowerChute or apcupsd with this script!!
#
# Tested under Mac OS X 10.6.8 and 10.6.7 (or use: uname -v   )
# Darwin Kernel Version 10.8.0: Tue Jun  7 16:33:36 PDT 2011; root:xnu-1504.15.3~1/RELEASE_I386
# Darwin Kernel Version 10.7.0: Sat Jan 29 15:17:16 PST 2011; root:xnu-1504.9.37~1/RELEASE_I386




# Usage:
# Add to crontab (use crontab -e) in a similar fashion to this:
# 0,5,10,15,20,25,30,35,40,45,50,55 * * * *       $HOME/bin/powercheck.sh >> $HOME/tmp/powercheck.log 2>&1
# (one line, no leading whitespace)
# This crontab entry checks for changes in the system's power every
# five minutes
# logging any DEBUG statements into $HOME/tmp/powercheck.log
#
# Requirements:
#   - install this script as $HOME/bin/powercheck.sh with permissions of 0755
#   - provide a space for the logfile
#     Example:
#         sudo install -d -m 0755 $HOME/bin
#         sudo install -c -b -m 0755 powercheck.sh $HOME/bin
#         sudo install -d -m 0755 $HOME/tmp
#   - an Alert Script to forward the Alert Text
#     Should take the Alert Text as the sole argument
#     Specify this Alert Script as $alert_script, below#
#

# ---------------------------------------------------------
# Below are some variables you can modify
# Where to store the previous power status
STATUSFILE=~/tmp/lastpowerstatus
#
# The Alert Script: Takes one argument: the Alert Text
# This script should take the Alert Text and forward it on as desired
alert_script=~/bin/tw-dm-me.sh
#
# If debugging is not needed, set DEBUG to ""
# If debugging is needed, set DEBUG to anything
debug="true"
#
# That's all, stop editing!
# ---------------------------------------------------------
#
# Gather Power Management settings currently in use
STATUS=$(/usr/bin/pmset -g | /usr/bin/grep \* | \
    /usr/bin/awk ' { print $1" "$2 }')
# ======================
# Possible STATUS values
#STATUS="Battery Power"
#STATUS="UPS Power"
#STATUS="AC Power"
#STATUS="Unknown State"
# ======================
LASTPOWERSTATUS=$(cat $STATUSFILE)
# Initialize ALERT
ALERT=""
# ---------------------------------------------------------

if [ $debug ]; then
    /bin/date
    echo "Current Status:  "$STATUS
    echo "Previous Status: "$LASTPOWERSTATUS
fi

case $STATUS in
    $LASTPOWERSTATUS)
        # Debug information
        if [ $debug ]; then
	    echo "No Change"
	fi
	# Set the alert text
        ALERT=""
	;;

    "UPS Power") # for systems with a UPS and **NOT** running apcupsd
	# Debug information
        if [ $debug ]; then
	    echo "Changed to $STATUS"
	fi
	# Set the alert text
	ALERT="Changed to $STATUS at `/bin/date`"
	;;

    "Battery Power") # for portable systems (e.g. MacBook)
	# Debug information
        if [ $debug ]; then
	    echo "Changed to $STATUS"
	fi
	# Set the alert text
	ALERT="Changed to $STATUS at `/bin/date`"
	;;

    "AC Power")
	# Debug information
        if [ $debug ]; then
	    echo "Changed to $STATUS"
	fi
	# Set the alert text
	ALERT="Changed to $STATUS at `/bin/date`"
	;;

    *)
	# Debug information
        if [ $debug ]; then
	    echo "Unknown State"
	fi
	# Set the alert text
	ALERT="Unknown state; better take a look."
	;;
esac

if [ "$ALERT" ]; then
    $alert_script "$ALERT" >> /dev/null 2>&1
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
	echo "Error occured while trying to send alert: $RETVAL"
    fi
fi

# Debug information
if [ $debug ]; then
    if [ "$ALERT" ]; then
	echo "Alert: "$ALERT
    else
	echo "Alert: <none sent>"
    fi
    echo ""
fi

# output current status as STATUSFILE
# overwrite existing contents
echo $STATUS > $STATUSFILE

exit 0