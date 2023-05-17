FROM afreisinger/ubuntu-sshd:9.3
ADD https://gitlab.com/afreisinger.keys /afreisinger/.ssh/authorized_keys
RUN \
  passwd -d root && \
  adduser -D -s /bin/bash afreisinger && \
  passwd -u afreisinger && \
  chown -R afreisinger:afreisinger /home/afreisinger && \
  ssh-keygen -A
