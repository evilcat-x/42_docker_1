FROM ruby

ENV PATH="${PATH}:/root/.gem/ruby/2.6.0/bin"
RUN gem install --user-install --pre norminette
RUN mkdir -p /root/c

VOLUME [ "/root/c" ]

# cuz yarn comes preinstalled now ....
WORKDIR /root/c
ENTRYPOINT [ "bash" ]
