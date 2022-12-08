#! /bin/bash

echo ""
echo "--------------------"
echo "--------------------"
echo "Scan for an IP within system logs!"
echo "--------------------"
echo "--------------------"
sleep 3s
echo "Please provide required IP:"
read ip
echo "--------------------"
echo "IP provided: $ip - Beginning Scan"
echo "--------------------"
sleep 3s

echo "Apache Error Log Results:"
grep $ip /usr/local/apache/logs/error_log
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
grep1=grep $ip /usr/local/cpanel/logs/error_log
if [ -z $grep1 ];
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
