#!/bin/bash

ansi_red="\033[1;31m"
ansi_unred="\033[0;31m"
ansi_blue="\033[1;34m"
ansi_green="\033[1;32m"
bon="\033[1m"
boff="\033[0m"

os=$(cat /etc/issue | grep -c Fedora)
if [ $os = "0" ]; then
        echo -e "$ansi_red This scripts work only on Fedora. Exit."; tput sgr0
        exit
        else
        echo -e "$ansi_blue This OS is Fedora"; tput sgr0
fi

echo -e "$ansi_blue DO YOU WANT INSTALL HUDSON? $ansi_unred (y/n)"; tput sgr0
read flag
case "$flag" in
        y|Y) echo -e "$ansi_green BEGIN INSTALL...."; tput sgr0
                #wget http://hudson-ci.org/downloads/redhat/hudson-2.2.1-1.1.noarch.rpm
                #rpm -ivh hudson-2.2.1-1.1.noarch.rpm
                wget http://java.net/projects/hudson/downloads/download/Redhat/hudson-redhat-2.2.1.rpm
                rpm -ivh hudson-redhat-2.2.1.rpm

        SHUD=$(service hudson start)   #HUDSON SERSVICE START
        echo -e "$ansi_blue SERVICE HUDSON START:" ; tput sgr0
        echo $SHUD

        CHK_HUDS_ON=$(chkconfig hudson on)
        echo -e "$ansi_blue CHKCONFIG HUDSON ON:" ; tput sgr0
        echo $CHK_HUDS_ON
        chkconfig --list |grep hudson


        HUDSON_URL=`cat /var/lib/hudson/hudson.tasks.Mailer.xml |grep -c localhost`
        if [ $HUDSON_URL = "1" ]; then
            sed -i 's/localhost/192.168.0.94/gi' /var/lib/hudson/hudson.tasks.Mailer.xml
            #sed -i 's/permissive/disabled/gi' /etc/selinux/config
            MAILER=$(cat /var/lib/hudson/hudson.tasks.Mailer.xml)
            echo $MAILER
            echo "HUDSON URL MUST BE CHENGED"
        fi
        #/var/lib/hudson/hudson.tasks.Mailer.xml


        ;;
        n|N) echo -e "$ansi_red CANCEL..."; tput sgr0
        ;;
        *)
        ;;

esac
