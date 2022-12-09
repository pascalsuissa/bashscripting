#!/bin/bash

echo ""
echo "-----------------------------------"
echo "-----------------------------------"
echo "Scan for an IP within system logs!"
echo "-----------------------------------"
echo "-----------------------------------"
sleep 1s
echo "Please provide required IP:"
read ip
echo "------------------------------"
echo "IP provided: $ip - Scanning..."
echo "------------------------------"
sleep 3s

echo "--------------------"
echo "Apache Error Log Results:"
grep1=$(grep ip /usr/local/apache/logs/error_log)
if [$grep1 -eq ""]
then
	echo "No Results Found"
fi
sleep 1s
echo "--------------------"

echo "ModSec Log Results:"
grep $ip /usr/local/apache/logs/modsec_audit.log
sleep 1s

echo "--------------------"

echo "cPanel Access Log Results:"
grep $ip /usr/local/cpanel/logs/access_log
sleep 1s

echo "--------------------"

echo "cPanel Error Log Results:"
grep4=$(grep $ip /usr/local/cpanel/logs/error_log)
if [$grep4 -eq ""];
then 
	echo "No results found"
fi
sleep 1s

echo "--------------------"

echo "cPanel Stats Log Results:"
grep $ip /usr/local/cpanel/logs/stats_log
sleep 1s

echo "--------------------"

echo "cPanel Check Service Log Results:"
grep $ip /var/log/chkservd.log
sleep 1s

echo "--------------------"

echo "Exim Main Log Results:"
grep $ip /var/log/exim_mainlog
sleep 1s

echo "--------------------"

echo "Exim Panic Log Results:"
grep $ip /var/log/exim_paniclog
sleep 1s

echo "--------------------"

echo "Exim Reject Log Results:"
grep $ip /var/log/exim_rejectlog
sleep 1s

echo "--------------------"

echo "lfd Log Results:"
grep $ip /var/log/lfd.log
sleep 1s

echo "--------------------"

echo "Thank you for using the IP search script!"
sleep 3s

exit
