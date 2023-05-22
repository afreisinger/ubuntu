FROM afreisinger/ubuntu:18.04-amd64

ADD https://gitlab.com/afreisinger.keys /tmp/authorized_keys

RUN passwd -d root && \
    adduser --home /home/afreisinger --shell /bin/bash afreisinger && \
    usermod -p '*' afreisinger && \ 
    passwd -u afreisinger && \
    #echo "afreisinger:MyStrongPassword123" | chpasswd && \
    mkdir -p /home/afreisinger/.ssh && \
    chmod 700 /home/afreisinger/.ssh && \
    touch /home/afreisinger/.ssh/config && \
    chmod 600 /home/afreisinger/.ssh/config && \
    mv /tmp/authorized_keys /home/afreisinger/.ssh/authorized_keys && \
    chmod 600 /home/afreisinger/.ssh/authorized_keys && \
    chown -R afreisinger:afreisinger /home/afreisinger && \
    ssh-keygen -A