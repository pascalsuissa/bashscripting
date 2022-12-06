#! /bin/bash

echo "Scan for an IP within system logs!"
sleep 5s
read ip


echo "Apache Error Log Results:"
grep $ip /usr/local/apache/logs/error_log

echo "ModSec Log Results:"
grep $ip /usr/local/apache/logs/modsec_audit.log

echo "cPanel Access Log Results:"
grep $ip /usr/local/cpanel/logs/access_log

echo "cPanel Error Log Results:"
grep $ip /usr/local/cpanel/logs/error_log

echo "cPanel Stats Log Results:"
grep $ip /usr/local/cpanel/logs/stats_log

echo "cPanel Check Service Log Results:"
grep $ip /var/log/chkservd.log

echo "Exim Main Log Results:"
grep $ip /var/log/exim_mainlog

echo "Exim Panic Log Results:"
grep $ip /var/log/exim_paniclog

echo "Exim Reject Log Results:"
grep $ip /var/log/exim_rejectlog

echo "lfd Log Results:"
grep $ip /var/log/lfd.log

echo "Thank you for using the IP search script!"
sleep 5s

exit
