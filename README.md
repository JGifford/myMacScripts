myMacScripts
============
A repository of Mac Scripts that I use on the various Macs in my home network.

+ Scripts
  * powerCheck
  * eraseOptical
  * startVMheadless (not yet released)
  * twitterDM       (not yet released)
+ Installing
  * install.sh
+ To-do List

Scripts
-------

### powerCheck
> When coupled with a crontab entry, periodically checks the system's power
> sources for changes (e.g., AC Power to Battery Power) and sends an alert
> (if configured) or just logs to a logfile.

### eraseOptical
> Erases an optical device from the commandline rather than using the
> Disk Utility GUI.
>
> (I have several CD-RW that I use in my car, the one that can't play my iPod.)

### startVMheadless (not yet released)
> Starts a VirtualBox guest (headless) upon reboot of your Mac.

### twitterDM       (not yet released)
> Sends a Twitter DM (possibly to yourself). Useful as an alerting mechanism.
> Makes use of http://supertweet.net

Installing
----------

###install.sh

All installations go into $HOME/bin (currently).
Some make use of $HOME/tmp (which is created if doesn't exist).

Usage:

	install.sh {eraseOptical|powerCheck}

To-do List

+ Perhaps add an option (`-d|--destination` ?) to install.sh allowing an
alternate installation destination.
+ Perhaps add an option (`-d|--delete` or `-u|--uninstall` ?) to cleanly
uninstall.

===
END