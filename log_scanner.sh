#!/bin/bash

#The script will scan system logs and various service logs.

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
echo -e "\nThe script will scan the logs below and report of any results within available logs.\n[If no results are found then either the log file is missing or no results were found]"
echo -e "\n* journalctl | dmesg | Ubuntu Based System Syslog | Red Hat Based System Messages"
echo -e "* Apache | ModSec | cPanel Access / Stats / Errors / Check Service | cPHulk Main / Error"
echo -e "* Exim Main Log / Panic Log / Exim Reject Log | LFD | CSF Allow / Deny"
echo -e "\n-----------------------------------------\n\nPlease provide required IP or Search Term:\n"
read input
echo -e "\nData Received: ${input} - Searching...\n"

#Color Variables
NC="\033[0m"
R="\033[1;31m"

#Variables
GREP=( grep --color=always -a )
JOURNALCTL=$( journalctl | "${GREP[@]}" "$input" | tail -10 )
DMESG=$( "${GREP[@]}" "$input" /var/log/dmesg 2> /dev/null | tail -10 )
UBUSYSLOG=$( "${GREP[@]}" "$input" /var/log/syslog 2> /dev/null | tail -10 )
REDHATMESSAGES=$( "${GREP[@]}" "$input" /var/log/messages 2> /dev/null | tail -10 )
APACHE=$( "${GREP[@]}" "$input" /usr/local/apache/logs/error_log 2> /dev/null | tail -10 )
MODSEC=$( "${GREP[@]}" "$input" /usr/local/apache/logs/modsec_audit.log 2> /dev/null | tail -10 )
CPANELACCESS=$( "${GREP[@]}" "$input" /usr/local/cpanel/logs/access_log 2> /dev/null | tail -10 )
CPANELSTATS=$( "${GREP[@]}" "$input" /usr/local/cpanel/logs/stats_log 2> /dev/null | tail -10 )
CPANELERROR=$( "${GREP[@]}" "$input" /usr/local/cpanel/logs/error_log 2> /dev/null | tail -10 )
CPANELCHECKSERVICE=$( "${GREP[@]}" "$input" /var/log/chkservd.log 2> /dev/null| tail -10 )
EXIMMAINLOG=$( "${GREP[@]}" "$input" /var/log/exim_mainlog 2> /dev/null | tail -10 )
EXIMPANICLOG=$( "${GREP[@]}" "$input" /var/log/exim_paniclog 2> /dev/null | tail -10 )
EXIMREJECT=$( "${GREP[@]}" "$input" /var/log/exim_rejectlog 2> /dev/null | tail -10 )
LFD=$( "${GREP[@]}" "$input" /var/log/lfd.log 2> /dev/null | tail -10 )
CSFALLOW=$( "${GREP[@]}" "$input" /etc/csf/csf.allow 2> /dev/null | tail -10 )
CSFDENY=$( "${GREP[@]}" "$input" /etc/csf/csf.deny 2> /dev/null | tail -10 )
CPHULK=$( "${GREP[@]}" "$input" /usr/local/cpanel/logs/cphulkd.log 2> /dev/null | tail -10 )
CPHULKERR=$( "${GREP[@]}" "$input" /usr/local/cpanel/logs/cphulkd_errors.log 2> /dev/null | tail -10 )

#Journalctl
if [[ -n "$JOURNALCTL" ]]; then
	echo -e "${R}-----Journalctl Log Results-----${NC}"
	echo -e "\n${JOURNALCTL}\n"
fi

#DMESG
if [[ -n "$DMESG" ]]; then
	echo -e "${R}-----DMESG\Kernel Buffer Log Results-----${NC}"
	echo -e "\n${DMESG}\n"
fi

#Ubuntu System Log Messages
if [[ -n "$UBUSYSLOG" ]]; then
	echo -e "${R}-----Ubuntu Servers syslog Results-----${NC}"
	echo -e "\n${SYSLOG}\n"
fi

#Red Hat Based System Messages
if [[ -n "$REDHATMESSAGES" ]]; then
        echo -e "${R}-----Red Hat Based Servers System Messages Log Results-----${NC}"
	echo -e "\n${MESSAGES}\n"
fi

#Apache Logs
if [[ -n "$APACHE" ]]; then
        echo -e "${R}-----Apache Error Log Results-----${NC}"
	echo -e "\n${APACHE}\n"
fi

#ModSec Log
if [[ -n "$MODSEC" ]]; then
        echo -e "${R}-----ModSec Log Results-----${NC}"
	echo -e "\n${MODSEC}\n"
fi

#cPanel Access Log
if [[ -n "$CPANELACCESSLOG" ]]; then
        echo -e "${R}-----cPanel Access Log Results-----${NC}"
	echo -e "\n${CPANELACCESS}\n"
fi

#cPanel Error Log
if [[ -n "$CPANELERROR" ]]; then
	echo -e "${R}-----cPanel Error Log Results-----${NC}"
	echo -e "\n${CPANELERROR}\n"
fi

#cPanel Stats Log
if [[ -n "$CPANELSTATS" ]]; then
        echo -e "${R}-----cPanel Stats Log Results-----${NC}"
	echo -e "\n${CPANELSTATS}\n"
fi

#cPanel Check Service Log
if [[ -n "$CPANELCHECKSERVICE" ]]; then
	echo -e "${R}-----cPanel Check Service Log Results-----${NC}"
	echo -e "\n${CPANELCHECKSERVICE}\n"
fi

#Exim Main Log
if [[ -n "$EXIMMAINLOG" ]]; then
        echo -e "${R}-----Exim Main Log Results-----${NC}"
	echo -e "\n${EXIMMAINLOG}\n"
fi

#Exim Panic Log
if [[ -n "$EXIMPANICLOG" ]]; then
        echo -e "${R}-----Exim Panic Log Results-----${NC}"
	echo -e "\n${EXIMPANICLOG}\n"
fi

#Exim Reject Log
if [[ -n "$EXIMPANICLOG" ]]; then
        echo -e "${R}-----Exim Reject Log Results-----${NC}"
	echo -e "\n${EXIMREJECT}\n"
fi

#LFD Log
if [[ -n "$LFD" ]]; then
	echo -e "${R}-----CSF/LFD Log Results-----${NC}"
	echo -e "\n${LFD}\n"
fi


#CSF Allow Log
if [[ -n "$CSFALLOW" ]]; then
	echo -e "${R}-----CSF Allow Log Results-----${NC}"
	echo -e "\n${CSFALLOW}\n"
fi

#CSF Deny log
if [[ -n "$CSFDENY" ]]; then
	echo -e "${R}-----CSF Deny Log Results-----${NC}"
	echo -e "\n${CSFDENY}\n"
fi

#cPHulk Log
if [[ -n "$CPHULK" ]]; then
	echo -e "${R}-----cPHulk Brute Force Protection Log Results-----${NC}"
	echo -e "\n${CPHULK}\n"
fi

#cPHulk Error Log
if [[ -n "$CPHULKERR" ]]; then
	echo -e "${R}-----cPHulk Brute Force Protection Error Log Results-----${NC}"
	echo -e "\n${CPHULKERR}\n"
fi

echo -e "-------------------------------------------\nI Hope you found what you were looking for!\n-------------------------------------------"
sleep 3s

if [[ -f "$0" ]]; then
	rm -- "$0"
fi

exit
