FROM afreisinger/ubuntu-sshd:latest
ADD https://gitlab.com/afreisinger.keys /home/afreisinger/.ssh/authorized_keys
ADD https://gitlab.com/afrojas.keys /home/afrojas/.ssh/authorized_keys
RUN \
  passwd -d root && \
  adduser -D -s /bin/bash afreisinger && \
  passwd -u afreisinger && \
  chown -R afreisinger:afreisinger /home/afreisinger && \
  adduser -D -s /bin/bash afrojas && \
  passwd -u afrojas && \
  chown -R afrojas:afrojas /home/afrojas
