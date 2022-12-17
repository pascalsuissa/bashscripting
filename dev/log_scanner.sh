#!/bin/bash

#------------Start Comments------------
#The script will scan system logs and various service logs.

#echo -e is intended to allow \n and to provide the function to drop lines, add text, all in one echo.

#If you are interested to evaluate whether a command resulted in no output, use [ -z "$variable" ], it is the same as 
#using [ "$variable" -eq "" ].

#grep -a is intended to retrieve actual results and not "binary found" which ocaccionaly will come up.

#tail -10 piped to the grep command is used to retrieve the last 10 hits of that file from our results.

#Make sure to use spaces around your tests and within your variables, don't hug them too tight.

#if [[ -f $0 ]] means if the script file exists and tests for it.
#rm -- $0 will remove it.
#------------End Comments------------

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
sleep 2s
echo -e "------------------------------------------\nPlease provide required IP or Search Term:\n------------------------------------------\n"
read input
echo -e "\n--------------------------------------\nData Received: ${input} - Searching...\n--------------------------------------\n"

#Color Variables
NC="\033[0m"
G="\033[0;32m"
R="\033[1;31m"

#Variables
GREP=( grep --color -a )
JOURNALCTL=$( journalctl | "${GREP[@]}" "$input" | tail -10 )
DMESG=$( "${GREP[@]}" "$input" /var/log/dmesg 2> /dev/null | tail -10 )
UBUSYSLOG=$( "$GREP" "$input" /var/log/syslog 2> /dev/null | tail -10 )
REDHATMESSAGES=$( "$GREP" "$input" /var/log/messages 2> /dev/null | tail -10 )
APACHE=$( "$GREP" "$input" /usr/local/apache/logs/error_log 2> /dev/null | tail -10 )
MODSEC=$( "$GREP" "$input" /usr/local/apache/logs/modsec_audit.log 2> /dev/null | tail -10 )
CPANELACCESS=$( "$GREP" "$input" /usr/local/cpanel/logs/access_log 2> /dev/null | tail -10 )
CPANELSTATS=$( "$GREP" "$input" /usr/local/cpanel/logs/stats_log 2> /dev/null | tail -10 )
CPANELERROR=$( "$GREP" "$input" /usr/local/cpanel/logs/error_log 2> /dev/null | tail -10 )
CPANELCHECKSERVICE=$( "$GREP" "$input" /var/log/chkservd.log 2> /dev/null| tail -10 )
EXIMMAINLOG=$( "$GREP" "$input" /var/log/exim_mainlog 2> /dev/null | tail -10 )
EXIMPANICLOG=$( "$GREP" "$input" /var/log/exim_paniclog 2> /dev/null | tail -10 )
EXIMREJECT=$( "$GREP" "$input" /var/log/exim_rejectlog 2> /dev/null | tail -10 )
LFD=$( "$GREP" "$input" /var/log/lfd.log 2> /dev/null | tail -10 )
CSFALLOW=$( "$GREP" "$input" /etc/csf/csf.allow 2> /dev/null | tail -10 )
CSFDENY=$( "$GREP" "$input" /etc/csf/csf.deny 2> /dev/null | tail -10 )
CPHULK=$( "$GREP" "$input" /usr/local/cpanel/logs/cphulkd.log 2> /dev/null | tail -10 )
CPHULKERR=$( "$GREP" "$input" /usr/local/cpanel/logs/cphulkd_errors.log 2> /dev/null | tail -10 )

#Journalctl
if [[ -n "$JOURNALCTL" ]]; then
	echo -e "-------------------\n${R}Journalctl Log Results:${NC}\n-------------------"
	echo -e "${JOURNALCTL}\n"
fi

#DMESG
if [[ -n "$DMESG" ]]; then
	echo -e "-------------------\n${R}DMESG\Kernel Buffer Log Results:${NC}\n-------------------"
	echo -e "${DMESG}\n"
fi

#Ubuntu System Log Messages
if [[ -n "$UBUSYSLOG" ]]; then
	echo -e "-------------------\n${R}Ubuntu Servers syslog Results:${NC}\n-------------------"
	echo -e "${SYSLOG}\n"
fi

#Red Hat Based System Messages
if [[ -n "$REDHATMESSAGES" ]]; then
        echo -e "-------------------\n${R}Red Hat Based Servers System Messages Log Results:${NC}\n-------------------"
	echo -e "${MESSAGES}\n"
fi

#Apache Logs
if [[ -n "$APACHE" ]]; then
        echo -e "-------------------\n${R}Apache Error Log Results:${NC}\n-------------------"
	echo -e "${APACHE}\n"
fi

#ModSec Log
if [[ -n "$MODSEC" ]]; then
        echo -e "--------------------\n${R}ModSec Log Results:${NC}\n--------------------"
	echo -e "${MODSEC}\n"
fi

#cPanel Access Log
if [[ -n "$CPANELACCESSLOG" ]]; then
        echo -e "--------------------\n${R}cPanel Access Log Results:${NC}\n--------------------"
	echo -e "${CPANELACCESS}\n"
fi

#cPanel Error Log
if [[ -n "$CPANELERROR" ]]; then
	echo -e "--------------------\n${R}cPanel Error Log Results:${NC}\n--------------------"
	echo -e "${CPANELERROR}\n"
fi

#cPanel Stats Log
if [[ -n "$CPANELSTATS" ]]; then
        echo -e "--------------------\n${R}cPanel Stats Log Results:${NC}\n--------------------"
	echo -e "${CPANELSTATS}\n"
fi

#cPanel Check Service Log
if [[ -n "$CPANELCHECKSERVICE" ]]; then
	echo -e "--------------------\n${R}cPanel Check Service Log Results:${NC}\n--------------------"
	echo -e "${CPANELCHECKSERVICE}\n"
fi

#Exim Main Log
if [[ -n "$EXIMMAINLOG" ]]; then
        echo -e "--------------------\n${R}Exim Main Log Results:${NC}\n--------------------"
	echo -e "${EXIMMAINLOG}\n"
fi

#Exim Panic Log
if [[ -n "$EXIMPANICLOG" ]]; then
        echo -e "--------------------\n${R}Exim Panic Log Results:${NC}\n--------------------"
	echo -e "${EXIMPANICLOG}\n"
fi

#Exim Reject Log
if [[ -n "$EXIMPANICLOG" ]]; then
        echo -e "--------------------\n${R}Exim Reject Log Results:${NC}\n--------------------"
	echo -e "${EXIMREJECT}\n"
fi

#LFD Log
if [[ -n "$LFD" ]]; then
	echo -e "-----------------\n${R}CSF/LFD Log Results:${NC}\n-----------------"
	echo -e "${LFD}\n"
fi


#CSF Allow Log
if [[ -n "$CSFALLOW" ]]; then
	echo -e "-----------------\n${R}CSF Allow Log Results:${NC}\n-----------------"
	echo -e "${CSFALLOW}\n"
fi

#CSF Deny log
if [[ -n "$CSFDENY" ]]; then
	echo -e "-----------------\n${R}CSF Deny Log Results:${NC}\n-----------------"
	echo -e "${CSFDENY}\n"
fi

#cPHulk Log
if [[ -n "$CPHULK" ]]; then
	echo -e "-----------------\n${R}cPHulk Brute Force Protection Log Results:${NC}\n-----------------"
	echo -e "${CPHULK}\n"
fi

#cPHulk Error Log
if [[ -n "$CPHULKERR" ]]; then
	echo -e "-----------------\n${R}cPHulk Brute Force Protection Error Log Results:${NC}\n-----------------"
	echo -e "${CPHULKERR}\n"
fi

echo -e "-------------------------------------------\nI Hope you found what you were looking for!\n-------------------------------------------"
sleep 3s

#if [[ -f "$0" ]]; then
#	rm -- "$0"
#fi

exit
