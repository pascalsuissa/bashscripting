#! /bin/bash

echo "Scan for an IP within system logs!"
sleep 5s
read ip

sleep 2s
echo "Apache Error Log Results:"
grep $ip /usr/local/apache/logs/error_log
sleep 2s

echo ""
echo ""
echo ""

sleep 2s
echo "ModSec Log Results:"
grep $ip /usr/local/apache/logs/modsec_audit.log
sleep 2s

echo ""
echo ""
echo ""

sleep 2s
echo "cPanel Access Log Results:"
grep $ip /usr/local/cpanel/logs/access_log
sleep 2s

echo ""
echo ""
echo ""

sleep 2s
echo "cPanel Error Log Results:"
grep $ip /usr/local/cpanel/logs/error_log
sleept 2s

echo ""
echo ""
echo ""

sleep 2s
echo "cPanel Stats Log Results:"
grep $ip /usr/local/cpanel/logs/stats_log
sleep 2s

echo ""
echo ""
echo ""

sleep 2s
echo "cPanel Check Service Log Results:"
grep $ip /var/log/chkservd.log
sleep 2s

echo ""
echo ""
echo ""

sleep 2s
echo "Exim Main Log Results:"
grep $ip /var/log/exim_mainlog
sleep 2s

echo ""
echo ""
echo ""

sleep 5s
echo "Exim Panic Log Results:"
grep $ip /var/log/exim_paniclog
sleep 5s

echo ""
echo ""
echo ""

sleep 5s
echo "Exim Reject Log Results:"
grep $ip /var/log/exim_rejectlog
sleep 5s

echo ""
echo ""
echo ""

sleep 5s
echo "lfd Log Results:"
grep $ip /var/log/lfd.log
sleep 5s

echo ""
echo ""
echo ""

sleep 5s
echo "Thank you for using the IP search script!"
sleep 5s

exit
