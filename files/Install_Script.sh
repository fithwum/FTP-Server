#!/bin/bash
# Copyright (c) 2020 fithwum
# All rights reserved

# Variables.
echo " "
echo "INFO ! Checking for latest FTP server version."
FTP_VERSION=1.16.1
CHANGELOG=/ftp-server/run_${FTP_VERSION}.sh

# Main install (debian).

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
exec /ftp-server/run_${FTP_VERSION}.sh --dataPath=/ftp-server

exit
