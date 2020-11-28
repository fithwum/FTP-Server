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
			wget --no-cache https://raw.githubusercontent.com/fithwum/ftp-server/master/files/run.sh -O /usr/sbin/run_${FTP_VERSION}.sh
			wget --no-cache https://raw.githubusercontent.com/fithwum/ftp-server/master/files/vsftpd.conf -O /etc/vsftpd/vsftpd.conf
			wget --no-cache https://raw.githubusercontent.com/fithwum/ftp-server/master/files/vsftpd_virtual -O /etc/pam.d/vsftpd_virtual
fi

sleep 1

# Set permissions.
chmod +x /usr/sbin/run_${FTP_VERSION}.sh

sleep 1

# Run FTP server.
echo " "
echo "INFO ! Starting FTP server ${FTP_VERSION}"
exec /usr/sbin/run_${FTP_VERSION}.sh

exit
