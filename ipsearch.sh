#!/bin/bash

echo -e "-----------------------------------\n-----------------------------------"
echo "Scan for an IP within system logs!"
echo -e "-----------------------------------\n-----------------------------------"
sleep 1s
echo "Please provide required IP:"
read ip
echo -e "--------------------------------------\nIP provided: $ip - Scanning...\n--------------------------------------"
sleep 3s

echo -e "\n-------------------\nApache Error Log Results:\n-------------------"
grep_apache=$( grep -a $ip /usr/local/apache/logs/error_log )
if [ -z e"$grep_apache" ]
then
	echo -e "\nNo Results Found\n"
else
	echo -e "\nResults Found\n-------------\n"
	sleep 2s
	echo $grep_apache
	echo ""
fi
sleep 1s

echo -e "--------------------\nModSec Log Results:\n--------------------"
grep_modsec=$(grep -a $ip /usr/local/apache/logs/modsec_audit.log)
if [ -z "$grep_modsec" ]
then
	echo -e "\nNo Results Found\n"
else
	echo "Results Found\n-------------\n"
	sleep 2s
	echo $grep_modsec
	echo ""
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
	echo ""
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
	echo ""
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
	echo ""
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
	echo ""
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
	echo ""
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
	echo ""
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
	echo ""
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
	echo ""
fi
sleep 1s

echo "--------------------"
echo "Thank you for using the IP search script!"
echo "--------------------"
sleep 3s

exit
