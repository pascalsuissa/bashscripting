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
echo -e "\nThe script will scan the logs below and report of any last 15 results within available logs.\n[If no results are found then either the log file is missing or no results were found]"
echo -e "\n* journalctl | dmesg | Ubuntu Based System Syslog | Red Hat Based System Messages"
echo -e "* Apache | ModSec | cPanel Access / Stats / Errors / Check Service | cPHulk Main / Error"
echo -e "* Exim Main Log / Panic Log / Exim Reject Log | LFD | CSF Allow / Deny"
echo -e "\nBonus! Now with MaxRequestWorkers check and Dynamic Apache Log Results!"
echo -e "\n-----------------------------------------\n\nPlease provide required IP or Search Term:\n"
read INPUT
echo -e "\nWould you like to scan the domain PHP logs for errors? [yes/y/no/n]\n"
read DOMAININPUT
if [[ "$DOMAININPUT" == "yes" || "$DOMAININPUT" == "y" ]]; then
    echo -e "\nPlease enter the account name\n"
    read ACCOUNTNAME
else
    echo -e "\nNo Worries - Skipping"
fi
echo -e "\nData Received\nRequested IP/String: ${INPUT}\nDomain Account: $ACCOUNTNAME\nSearching...\n"
sleep 2s

#Color Variables
R="\033[1;31m"
NC="\033[0m"

#Variables
GREP="grep --color=always -a"
JOURNALCTL=$( journalctl | $GREP $INPUT | tail -15 )
DMESG=$( $GREP $INPUT /var/log/dmesg 2> /dev/null | tail -15 )
UBUSYSLOG=$( $GREP $INPUT /var/log/syslog 2> /dev/null | tail -15 )
REDHATMESSAGES=$( $GREP $INPUT /var/log/messages 2> /dev/null | tail -15 )
DOMAINPHPLOG=$( $GREP error /home/${ACCOUNTNAME}/logs/*.php.error.log 2> /dev/null | tail -15 )
APACHE=$( $GREP $INPUT /usr/local/apache/logs/error_log 2> /dev/null | tail -15 )
CPANELACCESS=$( $GREP $INPUT /usr/local/cpanel/logs/access_log 2> /dev/null | tail -15 )
CPANELSTATS=$( $GREP $INPUT /usr/local/cpanel/logs/stats_log 2> /dev/null | tail -15 )
CPANELERROR=$( $GREP $INPUT /usr/local/cpanel/logs/error_log 2> /dev/null | tail -15 )
CPANELCHECKSERVICE=$( $GREP $INPUT /var/log/chkservd.log 2> /dev/null| tail -15 )
EXIMMAINLOG=$( $GREP $INPUT /var/log/exim_mainlog 2> /dev/null | tail -15 )
EXIMPANICLOG=$( $GREP $INPUT /var/log/exim_paniclog 2> /dev/null | tail -15 )
EXIMREJECT=$( $GREP $INPUT /var/log/exim_rejectlog 2> /dev/null | tail -15 )
LFD=$( $GREP $INPUT /var/log/lfd.log 2> /dev/null | tail -15 )
CSFALLOW=$( $GREP $INPUT /etc/csf/csf.allow 2> /dev/null | tail -15 )
CSFDENY=$( $GREP $INPUT /etc/csf/csf.deny 2> /dev/null | tail -15 )
CPHULK=$( $GREP $INPUT /usr/local/cpanel/logs/cphulkd.log 2> /dev/null | tail -15 )
CPHULKERR=$( $GREP $INPUT /usr/local/cpanel/logs/cphulkd_errors.log 2> /dev/null | tail -15 )
MODSEC=$( $GREP $INPUT /usr/local/apache/logs/modsec_audit.log 2> /dev/null | tail -15 )
WORKER=$( $GREP MaxRequestWorkers /var/log/apache2/error_log 2> /dev/null | tail -15 )

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

#Domain PHP Logs
if [[ -n "$DOMAINPHPLOG" ]]; then
    echo -e "${R}-----Domain PHP Log Results-----${NC}"
    echo -e "\n${DOMAINPHPLOG}\n"
fi

#Apache Logs
if [[ -n "$APACHE" ]]; then
        echo -e "${R}-----Apache Error Log Results-----${NC}"
    echo -e "\n${APACHE}\n"
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

#ModSec Log
if [[ -n "$MODSEC" ]]; then
        echo -e "${R}-----ModSec Log Results-----${NC}"
    echo -e "\n${MODSEC}\n"
fi

#Apache Worker Check
if [[ -n "$WORKER" ]]; then
	echo -e "\n${R}-----Apache MaxRequestWorkers Results-----${NC}"
	echo -e "\n${WORKER}\n"
fi

#Live Apache Domain Scan
echo -e "-------------------------------------------\n\nTip: View the Apache log dynamically for new errors with the command below\n\n${R}tail -f /var/log/apache2/error_log | grep Insert-URL-without-https://${NC}\n"

echo -e "-------------------------------------------\nI Hope you found what you were looking for!\n-------------------------------------------"

if [[ -f "$0" ]]; then
    rm -- $0
fi

exit 0
