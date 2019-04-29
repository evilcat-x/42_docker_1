FROM debian
# update and install
RUN apt-get update && apt-get -y upgrade
# wget for downloading tar file, using dockerfile ADD to remove the need to download in container
# bzip2 for extracting
# ca-certificates otherwise start up would crash
# libstdc++ as the offical script showing it might need the dependency when doing ldconfig
RUN apt-get install -y bzip2 ca-certificates locales locales-all ibstdc++


# systme locale setting default to "C" might cause unexpected behavior
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

#setup a volume
VOLUME /var/ts3server/
WORKDIR /var/ts3server/

# set -e exit when SIG is none 0
# set -x will print out the command, pretty good for debug what step went wrong
# set -u will treat unset variable (non defined) as error
# kinda like a linter for shell script
# adding group and user gecos provided so no interaction needed
RUN set -eux; \
	addgroup --gid 9987 ts3server; \
	adduser --home /var/ts3server \
	--gid 9987 \
	--shell /bin/bash \
	--disabled-password \
	--gecos "Team Speak Server" \
	--uid 9987 ts3server; \
	mkdir -p /var/ts3server /var/run/ts3server; \
	chown ts3server:ts3server /var/ts3server /var/run/ts3server; \
	chmod 777 /var/ts3server /var/run/ts3server

# adding the downloaded bin to PATH
ENV PATH "${PATH}:/opt/ts3server"
# accept lincense
ENV TS3SERVER_LICENSE "accept"

# server 64-bit 3.7.1 LINUX from https://teamspeak.com/en/downloads/#server
ARG TEAMSPEAK_SHA256_CHECKSUM=6787d4c9fd6f72d1386872a61f38f932a8ee745046b1497168286ffd0311c0f0

ADD https://files.teamspeak-services.com/releases/server/3.7.1/teamspeak3-server_linux_amd64-3.7.1.tar.bz2 /root/server.tar.bz2

# echo | sha256sum is checking the file hash
# protect against unitentional corruption / DNS poisoning / MITM
# tar is included in debian so no need to manage the install and delete of it
# ldconfig is Configure Dynamic Linker Run Time Bindings.
RUN set -eux; \
	cd ~; \
	echo "${TEAMSPEAK_SHA256_CHECKSUM} *server.tar.bz2" | sha256sum -c -; \
	mkdir -p /opt/ts3server; \
	tar -xf server.tar.bz2 --strip-components=1 -C /opt/ts3server; \
	mv /opt/ts3server/*.so /opt/ts3server/redist/* /usr/local/lib; \
	chown -R ts3server:ts3server /opt/ts3server; \
	chmod 777 /opt/ts3server ; \
	ldconfig /usr/local/lib; \
	chown -R ts3server:ts3server /var/ts3server


#  9987 default voice
# 10011 server query
# 30033 file transport
EXPOSE 9987/udp 10011 30033


# using ts3server_minial_runscript
# the minial launch and connect to tty rather than a service
# but we could easily detach it
# the start script expect a ts3server.pid to saved somewhere
# it seems the docker environment does not installed enough tool for the script to works
ENTRYPOINT [ "ts3server_minimal_runscript.sh", "start" ]
