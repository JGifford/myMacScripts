#!/bin/bash

# Erases an optical (re-writable) cd (or DVD)

# Add a quick check (do you really want to do this?)
# Add a check,wait,check loop to see if the drive isn't in. Max 5 retries or something

/usr/bin/sudo /usr/sbin/diskutil eraseOptical quick /dev/disk1