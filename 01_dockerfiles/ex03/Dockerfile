FROM ubuntu:14.04

# Install required packages
RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y \
	ca-certificates \
	openssh-server \
	wget \
	apt-transport-https


# using the default deb
# using curl and install via sh usually stuck into a ruby lock and it might cuz by ubuntu version tag diff
RUN echo "deb https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/gitlab_gitlab-ce.list

# using a gpg to version later package
RUN wget -q -O - https://packages.gitlab.com/gpg.key | apt-key add -
RUN apt-get update && apt-get install -y gitlab-ce

# Manage SSHD through runit
RUN mkdir -p /opt/gitlab/sv/sshd/supervise \
	&& mkfifo /opt/gitlab/sv/sshd/supervise/ok \
	&& printf "#!/bin/sh\nexec 2>&1\numask 077\nexec /usr/sbin/sshd -D" > /opt/gitlab/sv/sshd/run \
	&& chmod a+x /opt/gitlab/sv/sshd/run \
	&& ln -s /opt/gitlab/sv/sshd /opt/gitlab/service \
	&& mkdir -p /var/run/sshd

# Disabling use DNS in ssh since it tends to slow connecting
RUN echo "UseDNS no" >> /etc/ssh/sshd_config

# Prepare default configuration
RUN ( \
	echo "" && \
	echo "# Docker options" && \
	echo "# Prevent Postgres from trying to allocate 25% of total memory" && \
	echo "postgresql['shared_buffers'] = '1MB'" ) >> /etc/gitlab/gitlab.rb && \
	mkdir -p /assets/ && \
	cp /etc/gitlab/gitlab.rb /assets/gitlab.rb

# Expose web & ssh
EXPOSE 443 80 22

# Define data volumes
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]

ENV PATH="${PATH}:/usr/local/bin"

COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
