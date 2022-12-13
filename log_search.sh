#!/bin/bash

#---------Start-Comments----------#

#This script is intended to scan log files offered by WHM's ConfigServer LFD page among other logs files within a Linux system.

#echo -e is intended to allow \n and to provide the function to drop lines, add text, all in one echo.

#If you are interested to evaluate whether a command resulted in no output, use [ -z "$variable" ], it is the same as 
#using [ "$variable" -eq "" ].

#grep -a is intended to retrieve actual results and not "binary found" which ocaccionaly will come up.

#tail -10 piped to the grep command is used to retrieve the last 10 hits of that file from our results.

#Make sure to use spaces around your tests and within your variables, don't hug them too tight.

# if [[ -f $0 ]] means if the script file exists and tests for it.
#rm -- $0 will remove it.

#---------End-Comments----------#

echo -e "\n\n"
echo "██╗      ██████╗  ██████╗     ███████╗██╗██╗     ███████╗    ███████╗ ██████╗ █████╗ ███╗   ██╗███╗   ██╗███████╗██████╗ "
echo "██║     ██╔═══██╗██╔════╝     ██╔════╝██║██║     ██╔════╝    ██╔════╝██╔════╝██╔══██╗████╗  ██║████╗  ██║██╔════╝██╔══██╗"
echo "██║     ██║   ██║██║  ███╗    █████╗  ██║██║     █████╗      ███████╗██║     ███████║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝"
echo "██║     ██║   ██║██║   ██║    ██╔══╝  ██║██║     ██╔══╝      ╚════██║██║     ██╔══██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗"
echo "███████╗╚██████╔╝╚██████╔╝    ██║     ██║███████╗███████╗    ███████║╚██████╗██║  ██║██║ ╚████║██║ ╚████║███████╗██║  ██║"
echo "╚══════╝ ╚═════╝  ╚═════╝     ╚═╝     ╚═╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝"
echo -e "\n\n"
sleep 1s
echo -e "------------------------------------------\nPlease provide required IP or Search Term:\n------------------------------------------\n"
read input
echo -e "\n--------------------------------------\nData Received: $input - Searching...\n--------------------------------------\n"
sleep 1s


#journalctl can be used to query the contents of the systemd(1)
#journal as written by systemd-journald.service(8).
#This also shows the dmesg messages [kernel messages].

echo -e "-------------------\nJournalctl Log Results:\n-------------------\n"
grep_journalctl=$( journalctl | grep $input | tail -10 )
if [ -z "$grep_journalctl" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_journalctl
	echo ""
fi
sleep 1s

#Displays kernel messages from the kernel buffer during system boot.
#The one above using journalctl covers this but this is here just in case.

echo -e "-------------------\nDMESG\Kernel Buffer Log Results:\n-------------------\n"
grep_dmesg=$( grep --color='always' -a $input /var/log/dmesg | tail -10 )
if [ -z "$grep_dmesg" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_dmesg
	echo ""
fi
sleep 1s

echo -e "-------------------\nUbuntu Servers syslog Results:\n-------------------\n"
grep_syslog=$( grep --color='always' -a $input /var/log/syslog | tail -10 )
if [ -z "$grep_syslog" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_syslog
	echo ""
fi
sleep 1s

echo -e "-------------------\nRed Hat Based Servers System Messages Log Results:\n-------------------\n"
grep_messages=$( grep --color='always' -a $input /var/log/messages | tail -10 )
if [ -z "$grep_messages" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_messages
	echo ""
fi
sleep 1s

echo -e "-------------------\nApache Error Log Results:\n-------------------\n"
grep_apache=$( grep --color='always' -a $input /usr/local/apache/logs/error_log | tail -10 )
if [ -z "$grep_apache" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_apache
	echo ""
fi
sleep 1s


echo -e "--------------------\nModSec Log Results:\n--------------------\n"
grep_modsec=$( grep -a --color='always' $input /usr/local/apache/logs/modsec_audit.log | tail -10 )
if [ -z "$grep_modsec" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_modsec
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Access Log Results:\n--------------------\n"
grep_cPanelAccess=$( grep -a --color='always' $input /usr/local/cpanel/logs/access_log | tail -10 )
if [ -z "$grep_cPanelAccess" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_cPanelAccess
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Error Log Results:\n--------------------\n"
grep_cPanelError=$( grep -a --color='always' $input /usr/local/cpanel/logs/error_log | tail -10 )
if [ -z "$grep_cPanelError" ];
then 
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_cPanelError
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Stats Log Results:\n--------------------\n"
grep_cPanelStats=$( grep -a --color='always' $input /usr/local/cpanel/logs/stats_log | tail -10 )
if [ -z "$grep_cPanelStats" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_cPanelStats
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Check Service Log Results:\n--------------------\n"
grep_cPanelCheckService=$( grep -a --color='always' $input /var/log/chkservd.log | tail -10 )
if [ -z "$grep_cPanelCheckService" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_cPanelCheckService
	echo ""
fi
sleep 1s

echo -e "--------------------\nExim Main Log Results:\n--------------------\n"
grep_EximMainLog=$( grep -a --color='always' $input /var/log/exim_mainlog | tail -10 )
if [ -z "$grep_EximMainLog" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_EximMainLog
	echo ""
fi
sleep 1s

echo -e "--------------------\nExim Panic Log Results:\n--------------------\n"
grep_EximPanicLog=$( grep -a --color='always' $input /var/log/exim_paniclog | tail -10 )
if [ -z "$grep_EximPanicLog" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_EximPanicLog
	echo ""
fi
sleep 1s

echo -e "--------------------\nExim Reject Log Results:\n--------------------\n"
grep_EximReject=$( grep -a --color='always' $input /var/log/exim_rejectlog | tail -10 )
if [ -z "$grep_EximReject" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_EximReject
	echo ""
fi
sleep 1s

echo -e "-----------------\nCSF/LFD Log Results:\n-----------------\n"
grep_lfd=$( grep -a --color='always' $input /var/log/lfd.log | tail -10 )
if [ -z "$grep_lfd" ]
then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n***Results Found***\n"
	sleep 1s
	echo $grep_lfd
	echo ""
fi
sleep 1s


echo -e "-----------------\ncPHulk Brute Force Protection Log Results:\n-----------------\n"
grep_cphulk=$( grep -a --color='always' $input /usr/local/cpanel/logs/cphulkd.log | tail -10 )
if [ -z "$grep_cphulk" ]
then
	echo -e "\n***No Results Found Within cPHulk Log***\n"
else
	echo -e "\n***Results Found Within cPHulk Log***\n"
	sleep 1s
	echo $grep_cphulk
	echo ""
fi

grep_cphulkerr=$( grep -a --color='always' $input /usr/local/cpanel/logs/cphulkd_errors.log | tail -10 )
if [ -z "$grep_cphulkerr" ]
then
	echo -e "\n***No Results Found Within cPHulk Error Log***\n"
else
	echo -e "\n***Results Found Within cPHulk Error Log***\n"
	sleep 1s
	echo $grep_cphulkerr
	echo ""
fi
sleep 1s

echo -e "-----------------\nCSF Deny Log Results:\n-----------------\n"
grep_csfdeny=$( grep -a --color='always' $input /etc/csf/csf.deny | tail -10 )
if [ -z "$grep_csfdeny" ]
then
	echo -e "\n***No Results Found Within CSF Deny Log***\n"
else
	echo -e "\n***Results Found Within CSF Deny Log***\n"
	sleep 1s
	echo $grep_csfdeny
	echo ""
fi

grep_csfallow=$( grep -a --color='always' $input /etc/csf/csf.allow | tail -10 )
if [ -z "$grep_csfallow" ]
then
	echo -e "\n***No Results Found Within CSF Allow Log***\n"
else
	echo -e "\n***Results Found Within CSF Allow Log***\n"
	sleep 1s
	echo $grep_csfallow
	echo ""
fi
sleep 1s

echo -e "-------------------------------------------\nI Hope you found what you were looking for!\n-------------------------------------------"
sleep 3s

if [[ -f $0 ]]
then
	rm -- $0
fi

exit
