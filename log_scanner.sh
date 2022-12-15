#!/bin/bash

#------------Start Comments------------

#The script will scan system logs and various service logs.

#echo -e is intended to allow \n and to provide the function to drop lines, add text, all in one echo.

#If you are interested to evaluate whether a command resulted in no output, use [ -z "$variable" ], it is the same as 
#using [ "$variable" -eq "" ].

#grep -a is intended to retrieve actual results and not "binary found" which ocaccionaly will come up.

#tail -10 piped to the grep command is used to retrieve the last 10 hits of that file from our results.

#Make sure to use spaces around your tests and within your variables, don't hug them too tight.

# if [[ -f $0 ]] means if the script file exists and tests for it.
#rm -- $0 will remove it.

#------------End Comments------------

#Color Variables
NC="\033[0m"
G="\033[0;32m"
R="\033[1;31m"

echo -e "\n\n"
echo "████████╗██╗  ██╗███████╗    ██╗   ██╗██╗  ████████╗██╗███╗   ███╗ █████╗ ████████╗███████╗";
echo "╚══██╔══╝██║  ██║██╔════╝    ██║   ██║██║  ╚══██╔══╝██║████╗ ████║██╔══██╗╚══██╔══╝██╔════╝";
echo "   ██║   ███████║█████╗      ██║   ██║██║     ██║   ██║██╔████╔██║███████║   ██║   █████╗  ";
echo "   ██║   ██╔══██║██╔══╝      ██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██╔══╝  ";
echo "   ██║   ██║  ██║███████╗    ╚██████╔╝███████╗██║   ██║██║ ╚═╝ ██║██║  ██║   ██║   ███████╗";
echo "   ╚═╝   ╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚══════╝╚═╝   ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝";
echo "                                                                                           ";
echo "██╗      ██████╗  ██████╗     ███████╗ ██████╗ █████╗ ███╗   ██╗███╗   ██╗███████╗██████╗  ";
echo "██║     ██╔═══██╗██╔════╝     ██╔════╝██╔════╝██╔══██╗████╗  ██║████╗  ██║██╔════╝██╔══██╗ ";
echo "██║     ██║   ██║██║  ███╗    ███████╗██║     ███████║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝ ";
echo "██║     ██║   ██║██║   ██║    ╚════██║██║     ██╔══██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗ ";
echo "███████╗╚██████╔╝╚██████╔╝    ███████║╚██████╗██║  ██║██║ ╚████║██║ ╚████║███████╗██║  ██║ ";
echo "╚══════╝ ╚═════╝  ╚═════╝     ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ";
echo -e "\n\n"
sleep 1s
echo -e "------------------------------------------\nPlease provide required IP or Search Term:\n------------------------------------------\n"
read input
echo -e "\n--------------------------------------\nData Received: $input - Searching...\n--------------------------------------\n"
sleep 1s

#journalctl can be used to query the contents of the systemd(1)
#journal as written by systemd-journald.service(8).
#This also shows the dmesg messages [kernel messages].

echo -e "-------------------\nJournalctl Log Results:\n-------------------"
GREP_JOURNALCTL=$( journalctl | grep $input | tail -10 )
if [ -z "$GREP_JOURNALCTL" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_JOURNALCTL
	echo ""
fi
sleep 1s

#Displays kernel messages from the kernel buffer during system boot.
#The one above using journalctl covers this but this is here just in case.

echo -e "-------------------\nDMESG\Kernel Buffer Log Results:\n-------------------"
GREP_DMESG=$( grep --color='always' -a $input /var/log/dmesg | tail -10 )
if [ -z "$GREP_DMESG" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_DMESG
	echo ""
fi
sleep 1s

echo -e "-------------------\nUbuntu Servers syslog Results:\n-------------------"
GREP_SYSLOG=$( grep --color='always' -a $input /var/log/syslog | tail -10 )
if [ -z "$GREP_SYSLOG" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_SYSLOG
	echo ""
fi
sleep 1s

echo -e "-------------------\nRed Hat Based Servers System Messages Log Results:\n-------------------"
GREP_MESSAGES=$( grep --color='always' -a $input /var/log/messages | tail -10 )
if [ -z "$GREP_MESSAGES" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_MESSAGES
	echo ""
fi
sleep 1s

echo -e "-------------------\nApache Error Log Results:\n-------------------"
GREP_APACHE=$( grep --color='always' -a $input /usr/local/apache/logs/error_log | tail -10 )
if [ -z "$GREP_APACHE" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_APACHE
	echo ""
fi
sleep 1s

echo -e "--------------------\nModSec Log Results:\n--------------------"
GREP_MODSEC=$( grep -a --color='always' $input /usr/local/apache/logs/modsec_audit.log | tail -10 )
if [ -z "$GREP_MODSEC" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_MODSEC
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Access Log Results:\n--------------------"
GREP_CPANELACCESS=$( grep -a --color='always' $input /usr/local/cpanel/logs/access_log | tail -10 )
if [ -z "$GREP_CPANELACCESS" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_CPANELACCESS
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Error Log Results:\n--------------------"
GREP_CPANELERROR=$( grep -a --color='always' $input /usr/local/cpanel/logs/error_log | tail -10 )
if [ -z "$GREP_CPANELERROR" ];
then 
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_CPANELERROR
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Stats Log Results:\n--------------------"
GREP_CPANELSTATS=$( grep -a --color='always' $input /usr/local/cpanel/logs/stats_log | tail -10 )
if [ -z "$GREP_CPANELSTATS" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_CPANELSTATS
	echo ""
fi
sleep 1s

echo -e "--------------------\ncPanel Check Service Log Results:\n--------------------"
GREP_CPANELCHECKSERVICE=$( grep -a --color='always' $input /var/log/chkservd.log | tail -10 )
if [ -z "$GREP_CPANELCHECKSERVICE" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_CPANELCHECKSERVICE
	echo ""
fi
sleep 1s

echo -e "--------------------\nExim Main Log Results:\n--------------------"
GREP_EXIMMAINLOG=$( grep -a --color='always' $input /var/log/exim_mainlog | tail -10 )
if [ -z "$GREP_EXIMMAINLOG" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_EXIMMAINLOG
	echo ""
fi
sleep 1s

echo -e "--------------------\nExim Panic Log Results:\n--------------------"
GREP_EXIMPANICLOG=$( grep -a --color='always' $input /var/log/exim_paniclog | tail -10 )
if [ -z "$GREP_EXIMPANICLOG" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_EXIMPANICLOG
	echo ""
fi
sleep 1s

echo -e "--------------------\nExim Reject Log Results:\n--------------------\n"
GREP_EXIMREJECT=$( grep -a --color='always' $input /var/log/exim_rejectlog | tail -10 )
if [ -z "$GREP_EXIMREJECT" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_EXIMREJECT
	echo ""
fi
sleep 1s

echo -e "-----------------\nCSF/LFD Log Results:\n-----------------"
GREP_LFD=$( grep -a --color='always' $input /var/log/lfd.log | tail -10 )
if [ -z "$GREP_LFD" ]
then
	echo -e "\n${G}***No Results Found***${NC}\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	sleep 1s
	echo $GREP_LFD
	echo ""
fi
sleep 1s

echo -e "-----------------\ncPHulk Brute Force Protection Log Results:\n-----------------"
GREP_CPHULK=$( grep -a --color='always' $input /usr/local/cpanel/logs/cphulkd.log | tail -10 )
if [ -z "$GREP_CPHULK" ]
then
	echo -e "\n***No Results Found Within cPHulk Log***\n"
else
	echo -e "\n***Results Found Within cPHulk Log***\n"
	sleep 1s
	echo $GREP_CPHULK
	echo ""
fi

GREP_CPHULKERR=$( grep -a --color='always' $input /usr/local/cpanel/logs/cphulkd_errors.log | tail -10 )
if [ -z "$GREP_CPHULKERR" ]
then
	echo -e "\n***No Results Found Within cPHulk Error Log***\n"
else
	echo -e "\n***Results Found Within cPHulk Error Log***\n"
	sleep 1s
	echo $GREP_CPHULKERR
	echo ""
fi
sleep 1s

echo -e "-----------------\nCSF Allow/Deny Log Results:\n-----------------"
GREP_CSFDENY=$( grep -a --color='always' $input /etc/csf/csf.deny | tail -10 )
if [ -z "$GREP_CSFDENY" ]
then
	echo -e "\n***No Results Found Within CSF Deny Log***\n"
else
	echo -e "\n***Results Found Within CSF Deny Log***\n"
	sleep 1s
	echo $GREP_CSFDENY
	echo ""
fi

GREP_CSFALLOW=$( grep -a --color='always' $input /etc/csf/csf.allow | tail -10 )
if [ -z "$GREP_CSFALLOW" ]
then
	echo -e "\n***No Results Found Within CSF Allow Log***\n"
else
	echo -e "\n***Results Found Within CSF Allow Log***\n"
	sleep 1s
	echo $GREP_CSFALLOW
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
