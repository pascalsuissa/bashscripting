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
grep_apache=$( grep --color='always' -a $ip /usr/local/apache/logs/error_log | tail -10 )
if [ -z "$grep_apache" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 2s
	echo $grep_apache
	echo ""
fi
sleep 1s

echo -e "--------------------\nModSec Log Results:\n--------------------"
grep_modsec=$( grep -a --color='always' $ip /usr/local/apache/logs/modsec_audit.log | tail -10 )
if [ -z "$grep_modsec" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 2s
	echo $grep_modsec
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Access Log Results:\n--------------------"
grep_cPanelAccess=$( grep -a --color='always' $ip /usr/local/cpanel/logs/access_log | tail -10 )
if [ -z "$grep_cPanelAccess" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 2s
	echo $grep_cPanelAccess
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Error Log Results:\n--------------------"
grep_cPanelError=$( grep -a --color='always' $ip /usr/local/cpanel/logs/error_log | tail -10 )
if [ -z "$grep_cPanelError" ];
then 
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 2s
	echo $grep_cPanelError
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Stats Log Results:\n--------------------"
grep_cPanelStats=$( grep -a --color='always' $ip /usr/local/cpanel/logs/stats_log | tail -10 )
if [ -z "$grep_cPanelStats" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleeps2
	echo $grep_cPanelStats
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Check Service Log Results:\n--------------------"
grep_cPanelCheckService=$( grep -a --color='always' $ip /var/log/chkservd.log | tail -10 )
if [ -z "$grep_cPanelCheckService" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 2s
	echo $grep_cPanelCheckService
	echo ""
fi
sleep 1s

echo -e "--------------------\nExim Main Log Results:\n--------------------"
grep_EximMainLog=$( grep -a --color='always' $ip /var/log/exim_mainlog | tail -10 )
if [ -z "$grep_EximMainLog" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 2s
	echo $grep_EximMainLog
	echo ""
fi
sleep 1s

echo -e "--------------------\nExim Panic Log Results:\n--------------------"
grep_EximPanicLog=$( grep -a --color='always' $ip /var/log/exim_paniclog | tail -10 )
if [ -z "$grep_EximPanicLog" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 2s
	echo $grep_EximPanicLog
	echo ""
fi
sleep 1s

echo -e "--------------------\nExim Reject Log Results:\n--------------------"
grep_EximReject=$( grep -a --color='always' $ip /var/log/exim_rejectlog | tail -10 )
if [ -z "$grep_EximReject" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 2s
	echo $grep_EximReject
	echo ""
fi
sleep 1s

echo -e "-----------------\nlfd Log Results:\n-----------------"
grep_lfd=$( grep -a --color='always' $ip /var/log/lfd.log | tail -10 )
if [ -z "$grep_lfd" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 2s
	echo $grep_lfd
	echo ""
fi
sleep 1s

echo -e "------------------------------------------------------------------\nThat's the end of the script, I Hope you found what you were looking for!\n------------------------------------------------------------------"
sleep 3s

exit
