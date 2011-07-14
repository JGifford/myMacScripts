powerCheck
==========
When coupled with a crontab entry, periodically checks the system's power
sources for changes (e.g., AC Power to Battery/UPS Power) and sends an alert
(if configured) or just logs to a logfile.

Should **NOT** be used with apcupsd. If you have an APC UPS, just use the USB
cable provided. No need for apcupsd or PowerChute.

_Note_: This script does **NOT** provide autoshutdown functionality, only
warning alerts via $alert_script !!!!

+ Setting up `powercheck.sh`
+ To-do List

Setting up `powercheck.sh`
--------------------------
The quick, brown fox, jumped over the lazy dogs.

To-do List
----------

+ Check for apcupsd and handle this case
