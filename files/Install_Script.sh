#!/bin/bash
# Copyright (c) 2020 fithwum
# All rights reserved

# Variables.
echo " "
echo "INFO ! Checking for latest FTP server version."
FTP_VERSION=0.0.1
CHANGELOG=/ftp-server/run_${FTP_VERSION}.sh

# Main install (debian).
mkdir -p /ftp-server/data

# Check for files in /ftp-server and download/create if needed.
if [ -e "${CHANGELOG}" ]
	then
		echo " "
		echo "INFO ! FTP server found starting server."
	else
		echo " "
		echo "WARNING ! FTP server not found or is outdated downloading now."
			echo " "
			echo "INFO ! Cleaning old files."
			rm -fr /ftp-server /ftp-server/run_${FTP_VERSION}.sh
			apt-get update
			apt-get install vsftpd
			systemctl enable vsftpd
			ufw allow 20:21/tcp
			ufw allow 30000:31000/tcp
			ufw disable
			sleep 1
			ufw enable
			cp /etc/vsftpd.conf /etc/vsftpd.conf.orig
			systemctl restart vsftpd
fi

sleep 1

# Set permissions.
chown 99:100 -R /ftp-server
chmod 777 -R /ftp-server
chmod +x /ftp-server/run_${FTP_VERSION}.sh

sleep 1

# Run FTP server.
echo " "
echo "INFO ! Starting FTP server ${FTP_VERSION}"
exec /ftp-server/run_${FTP_VERSION}.sh

exit
