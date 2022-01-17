#!/bin/bash
/usr/sbin/cron &
/etc/init.d/ssh start &
/etc/init.d/apache2 start &
/usr/bin/tail -f /var/log/*
