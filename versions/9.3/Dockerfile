FROM ubuntu:18.04
ENV TZ=America/Argentina/Buenos_Aires
# Instalación de SSH
RUN apt-get update && apt-get install -y openssh-server nginx tzdata
RUN mkdir /var/run/sshd && \
mkdir -p ~/.ssh && \
touch ~/.ssh/known_hosts && \
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
rm -rf /etc/nginx/conf.d/*

#COPY rootfs /
COPY etc etc
# Configuración de SSH
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
#RUN sed -ri 's/^#?X11Forwarding\s+.*/X11Forwarding yes/' /etc/ssh/sshd_config
#SSH login fix
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN ssh-keyscan localhost >> ~/.ssh/known_hosts
# Creación del usuario
#RUN useradd -ms /bin/bash user
RUN echo 'root:password' | chpasswd && \
apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 22

CMD service ssh start && nginx -g 'daemon off;'
