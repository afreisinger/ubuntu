FROM afreisinger/alpine-sshd:latest
ADD https://github.com/afreisinger.keys /home/afreisinger/.ssh/authorized_keys
RUN \
  passwd -d root && \
  adduser -D -s /bin/bash sickp && \
  passwd -u afreisinger && \
  chown -R afreisinger:afreisinger /home/sickp && \
  ssh-keygen -A
