FROM afreisinger/ubuntu-sshd:latest
RUN passwd -d root
COPY id_rsa.pub /root/.ssh/authorized_keys
