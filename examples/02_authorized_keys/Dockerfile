FROM afreisinger/ubuntu-sshd:latest
RUN passwd -d root
COPY identity.pub /root/.ssh/authorized_keys
