FROM alpine:latest

# install dependencies
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    chmod 755 /etc && \
 apk update && apk add --no-cache \
    gcc make bash ncurses curl wget git sudo shellinabox   autoconf docker docker-compose automake libtool curl tar git openssh bash openssh-client
# install mcbash from local directorydocker docker-compose
RUN  echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
RUN echo -e "shellinabox\nshellinabox" | adduser -s /bin/sh shellinabox
RUN echo -e "root:shellinabox" | chpasswd
WORKDIR /mcbash
COPY . .
RUN make && make install
EXPOSE 4200
CMD ["shellinaboxd", "-s", "/:LOGIN", "--disable-ssl"]
