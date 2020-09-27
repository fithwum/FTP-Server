FROM fithwum/debian-base:stretch
MAINTAINER fithwum

# URL's for files
ARG INSTALL_SCRIPT=https://raw.githubusercontent.com/fithwum/ftp-server/master/files/Install_Script.sh

# 
RUN apt-get -y update \
	&& apt-get install -y  \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# folder creation.
RUN mkdir -p /ftp-server /ftp-server-temp \
	&& chmod 777 -R /ftp-server /ftp-server-temp \
	&& chown 99:100 -R /ftp-server /ftp-server-temp
ADD "${INSTALL_SCRIPT}" /ftp-server-temp
RUN chmod +x /ftp-server-temp/Install_Script.sh

# directory where data is stored
VOLUME /ftp-server

# 25565 default.
EXPOSE /udp /tcp

# Run command
CMD [ "/bin/bash", "./ftp-server-temp/Install_Script.sh" ]
