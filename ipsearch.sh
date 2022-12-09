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
grep_apache=$(grep -a $ip /usr/local/apache/logs/error_log)
if [ -z "$grep_apache" ]
then
	echo "No Results Found"
else
	echo "Results Found"
	echo "-------------"
	echo "-------------"
	sleep 2s
	echo $grep_apache
fi
sleep 1s

echo "--------------------"
echo "ModSec Log Results:"
grep_modsec=$(grep -a $ip /usr/local/apache/logs/modsec_audit.log)
if [ -z "$grep_modsec" ]
then
	echo "No Results Found"
else
	echo "Results Found"
	echo "-------------"
	echo ""
	sleep 2s
	echo $grep_modsec
fi
sleep 1s

echo "--------------------"
echo "cPanel Access Log Results:"
grep_cPanelAccess=$(grep -a $ip /usr/local/cpanel/logs/access_log)
if [ -z "$grep_cPanelAccess" ]
then
	echo "No Results Found"
else
	echo "Results Found"
	echo "-------------"
	echo ""
	sleep 2s
	echo $grep_cPanelAccess
fi
sleep 1s

echo "--------------------"

echo "cPanel Error Log Results:"
grep_cPanelError=$(grep -a $ip /usr/local/cpanel/logs/error_log)
if [ -z "$grep_cPanelError" ];
then 
	echo "No Results Found"
else
	echo "Results Found"
	echo "-------------"
	echo ""
	sleep 2s
	echo $grep_cPanelError
fi
sleep 1s

echo "--------------------"
echo "cPanel Stats Log Results:"
grep_cPanelStats=$(grep -a $ip /usr/local/cpanel/logs/stats_log)
if [ -z $grep_cPanelStats ]
then
	echo "No Results Found"
else
	echo "Results Found"
	echo "-------------"
	echo ""
	sleeps2
	echo $grep_cPanelStats
fi
sleep 1s

echo "--------------------"
echo "cPanel Check Service Log Results:"
grep_cPanelCheckService=$(grep -a $ip /var/log/chkservd.log)
if [ -z "$grep_cPanelCheckService" ]
then
	echo "No Results Found"
else
	echo "-------------"
	echo "Results Found"
	echo ""
	sleep 2s
	echo $grep_cPanelCheckService
fi
sleep 1s

echo "--------------------"
echo "Exim Main Log Results:"
grep_EximMainLog=$(grep -a $ip /var/log/exim_mainlog)
if [ -z "$grep_EximMainLog" ]
then
	echo "No Results Found"
else
	echo "-------------"
	echo "Results Found"
	echo ""
	sleep 2s
	echo $grep_EximMainLog
fi
sleep 1s

echo "--------------------"
echo "Exim Panic Log Results:"
grep_EximPanicLog=$(grep -a $ip /var/log/exim_paniclog)
if [ -z "$grep_EximPanicLog" ]
then
	echo "No Results Found"
else
	echo "-------------"
	echo "Results Found"
	echo ""
	sleep 2s
	echo $grep_EximPanicLog
fi
sleep 1s

echo "--------------------"
echo "Exim Reject Log Results:"
grep_EximReject=$(grep -a $ip /var/log/exim_rejectlog)
if [ -z "$grep_EximReject" ]
then
	echo "No Results Found"
else
	echo "-------------"
	echo "Results Found"
	echo ""
	sleep 2s
	echo $grep_EximReject
fi
sleep 1s

echo "--------------------"
echo "lfd Log Results:"
grep_lfd=$(grep -a $ip /var/log/lfd.log)
if [ -z "$grep_lfd" ]
then
	echo "No Results Found"
else
	echo "-------------"
	echo "Results Found"
	echo ""
	sleep 2s
	echo $grep_lfd
fi
sleep 1s

echo "--------------------"
echo "Thank you for using the IP search script!"
echo "--------------------"
sleep 3s

exit
