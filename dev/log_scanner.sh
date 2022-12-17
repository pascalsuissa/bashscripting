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
GREP=(grep --color='always' -a)
JOURNALCTL=$( journalctl | grep "$input" | tail -10 )
DMESG=$( "$GREP" "$input" /var/log/dmesg 2> /dev/null | tail -10 )
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
        echo -e "-------------------\nRed Hat Based Servers System Messages Log Results:\n-------------------"
	echo -e "${MESSAGES}\n"
fi

#Apache Logs
if [[ -n "$APACHE" ]]; then
        echo -e "-------------------\nApache Error Log Results:\n-------------------"
	echo -e "${APACHE}\n"
fi

#ModSec Log
if [[ -n "$MODSEC" ]]; then
        echo -e "--------------------\nModSec Log Results:\n--------------------"
	echo -e "${MODSEC}\n"
fi

#cPanel Access Log
if [[ -n "$CPANELACCESSLOG" ]]; then
        echo -e "--------------------\ncPanel Access Log Results:\n--------------------"
	echo -e "${CPANELACCESS}\n"
fi

#cPanel Error Log
if [[ -n "$CPANELERROR" ]]; then
	echo -e "--------------------\ncPanel Error Log Results:\n--------------------"
	echo -e "${CPANELERROR}\n"
fi

#cPanel Stats Log
if [[ -n "$CPANELSTATS" ]]; then
        echo -e "--------------------\ncPanel Stats Log Results:\n--------------------"
echo -e "\nLog Available - Scanning"
else
    	echo -e "\nLog Not Available"
fi

if [[ -z "$CPANELSTATS" ]]; then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	echo "$CPANELSTATS"
	echo ""
fi

echo -e "--------------------\ncPanel Check Service Log Results:\n--------------------"
if [[ -f /var/log/chkservd.log ]]; then
        echo -e "\nLog Available - Scanning"
else
    	echo -e "\nLog Not Available"
fi

if [[ -z "$CPANELCHECKSERVICE" ]]; then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	echo "$CPANELCHECKSERVICE"
	echo ""
fi

echo -e "--------------------\nExim Main Log Results:\n--------------------"
if [[ -f /var/log/exim_mainlog ]]; then
        echo -e "\nLog Available - Scanning"
else
    	echo -e "\nLog Not Available"
fi

if [[ -z "$EXIMMAINLOG" ]]; then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	echo "$EXIMMAINLOG"
	echo ""
fi

echo -e "--------------------\nExim Panic Log Results:\n--------------------"

if [[ -f /var/log/exim_paniclog ]]; then
        echo -e "\nLog Available - Scanning"
else
    	echo -e "\nLog Not Available"
fi

if [[ -z "$EXIMPANICLOG" ]]; then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	echo "$EXIMPANICLOG"
	echo ""
fi

echo -e "--------------------\nExim Reject Log Results:\n--------------------"
if [[ -f /var/log/exim_rejectlog ]]; then
        echo -e "\nLog Available - Scanning"
else
    	echo -e "\nLog Not Available"
fi

if [[ -z "$EXIMREJECT" ]]; then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	echo "$EXIMREJECT"
	echo ""
fi

echo -e "-----------------\nCSF/LFD Log Results:\n-----------------"
if [[ -f /var/log/lfd.log ]]; then
        echo -e "\nLog Available - Scanning"
else
    	echo -e "\nLog Not Available"
fi

if [[ -z "$LFD" ]]; then
	echo -e "\n***No Results Found***\n"
else
	echo -e "\n${R}***Results Found***${NC}\n"
	echo "$LFD"
	echo ""
fi

echo -e "-----------------\nCSF Allow/Deny Log Results:\n-----------------"
if [[ -f /etc/csf/csf.deny ]]; then
        echo -e "\nCSF Deny Log Available - Scanning"
else
    	echo -e "\nCSF Deny Log Not Available"
fi

if [[ -z "$CSFDENY" ]]; then
	echo -e "\n***No Results Found Within CSF Deny Log***\n"
else
	echo -e "\n${R}***Results Found Within CSF Deny Log***${NC}\n"
	echo "$CSFDENY"
	echo ""
fi

if [[ -f /etc/csf/csf.allow ]]; then
        echo -e "\nCSF Allow Log Available - Scanning"
else
    	echo -e "\nCSF Allow  Log Not Available"
fi

if [[ -z "$CSFALLOW" ]]; then
	echo -e "\n***No Results Found Within CSF Allow Log***\n"
else
	echo -e "\n${R}***Results Found Within CSF Allow Log***${NC}\n"	
	echo "$CSFALLOW"
	echo ""
fi

echo -e "-----------------\ncPHulk Brute Force Protection Log Results:\n-----------------"
if [[ -f /usr/local/cpanel/logs/cphulkd.log ]]; then
        echo -e "\nLog Available - Scanning"
else
    	echo -e "\nLog Not Available"
fi

if [[ -z "$CPHULK" ]]; then
	echo -e "\n***No Results Found Within cPHulk Log***\n"
else
	echo -e "\n${R}***Results Found Within cPHulk Log***${NC}\n"
	echo "$CPHULK"
	echo ""
fi

if [[ -f /usr/local/cpanel/logs/cphulkd_errors.log ]]; then
        echo -e "\nLog Available - Scanning"
else
    	echo -e "\nLog Not Available"
fi

if [ -z "$CPHULKERR" ]
then
	echo -e "\n***No Results Found Within cPHulk Error Log***\n"
else
	echo -e "\n${R}***Results Found Within cPHulk Error Log***${NC}\n"	
	echo "$CPHULKERR"
	echo ""
fi

echo -e "-------------------------------------------\nI Hope you found what you were looking for!\n-------------------------------------------"
sleep 3s

#if [[ -f "$0" ]]
#then
#	rm -- "$0"
#fi

exit
