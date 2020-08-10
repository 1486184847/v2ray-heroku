#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8
cd /home
Install_Deb_Pack(){
	ln -sf bash /bin/sh
	apt-get purge apache2* bind9* samba* -y
	apt-get update -y
	apt-get upgrade -y
	apt-get install iputils-ping -y
	apt-get install nano -y
	apt-get install xorg   -y
	apt-get install lxde-core   -y
	apt-get install lxterminal -y
	apt-get install tightvncserver   -y
	echo "### Update user: $USER password ###"
	echo -e "ceshi123\nceshi123" |  passwd "root"
	echo "### Start ngrok proxy for 22 port ###"
	#nano ~/.vnc/xstartup
	#lxterminal &
	#/usr/bin/lxsession -s LXDE &
	#vncserver :1 -geometry 1024x768 -depth 16 -pixelformat rgb565
	#apt-get install ntp ntpdate -y
	#/etc/init.d/ntp stop
	#update-rc.d ntp remove
	#cat >>~/.profile<<EOF
	#TZ='Asia/Shanghai'; export TZ
	#EOF
	#rm -rf /etc/localtime
	#cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	#echo 'Synchronizing system time...'
	#ntpdate 0.asia.pool.ntp.org
	#apt-get upgrade -y
}

Install_ngrok_Pack(){
	echo "### Install ngrok ###"
	wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
	unzip ngrok-stable-linux-amd64.zip
	chmod +x ./ngrok
	rm -f .ngrok.log
	./ngrok authtoken "1fftsZVphhCuMwhe7uVWkxW8zHx_2XwBkSWQ5M5yxEFfYPitV"
	./ngrok tcp 22 --log ".ngrok.log" &

}

Install_firefox_Pack(){
	apt-get install iceweasel -y

}

Install_chrome_Pack(){
	apt-get install chromium-browser  -y

}


Install_Main(){
	startTime=`date +%s`
	
	if [ "${PM}" = "yum" ]; then
		Install_RPM_Pack
	elif [ "${PM}" = "apt-get" ]; then
		Install_Deb_Pack
	fi
	Install_firefox_Pack

}

Install_Main



