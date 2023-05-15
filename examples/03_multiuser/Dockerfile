FROM afreisinger/alpine-sshd:latest
ADD https://github.com/afreisinger.keys /home/afreisinger/.ssh/authorized_keys
ADD https://github.com/afrojas.keys /home/afrojas/.ssh/authorized_keys
RUN \
  passwd -d root && \
  adduser -D -s /bin/ash afreisinger && \
  passwd -u afreisinger && \
  chown -R afreisinger:afreisinger /home/afreisinger && \
  adduser -D -s /bin/ash afrojas && \
  passwd -u afrojas && \
  chown -R afrojas:afrojas /home/afrojas
