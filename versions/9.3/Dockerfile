FROM ubuntu:18.04
LABEL maintainer "Adrian Freisinger - https://github.com/afreisinger"

ARG TZ=America/Argentina/Buenos_Aires
ENV TZ=${TZ}

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY rootfs /

RUN apt-get update && apt-get install -y openssh-server tzdata && \
mkdir -p /var/run/sshd && \
mkdir -p ~/.ssh && chmod 700 ~/.ssh && \
touch ~/.ssh/config && \
chmod 600 ~/.ssh/config && \
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
echo 'root:password' | chpasswd && \
apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#CMD service ssh start && nginx -g 'daemon off;'
