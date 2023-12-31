#!/bin/tclsh
# maintainer: Pooja Jain

puts "SETTING CONFIGURATION"
dbset db pg
dbset bm TPC-C

diset connection pg_host postgres_container
diset connection pg_port 5432
diset connection pg_sslmode disable

diset tpcc pg_superuser postgres
diset tpcc pg_superuserpass postgres
diset tpcc pg_defaultdbase postgres
diset tpcc pg_user postgres
diset tpcc pg_pass postgres
diset tpcc pg_dbase postgres
diset tpcc pg_raiseerror true

diset tpcc pg_driver timed

diset tpcc pg_rampup 2
diset tpcc pg_duration 5

diset tpcc pg_vacuum true
diset tpcc pg_timeprofile true
diset tpcc pg_allwarehouse true

loadscript
puts "TEST STARTED"
vuset vu vcpu
vucreate
tcstart
tcstatus
set jobid [ vurun ]
vudestroy
tcstop
puts "TEST COMPLETE"
set of [ open /tmp/mysql_tprocc w ]
puts $of $jobid
close $of