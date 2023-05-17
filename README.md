---
---
### Ubuntu Linux SSHD

A lightweight [OpenSSH][openssh] [Docker image][dockerhub_project] built atop [Ubuntu Linux][alpine_linux]. Available on [GitHub][github_project].

The root password is "password". SSH host keys (RSA, DSA, ECDSA, and ED25519) are auto-generated when the container is started, unless already present.

#### OpenSSL Version Tags

- `9.3`, `latest` (OpenSSH_9.3p1, OpenSSL 3.1.0 14 Mar 2023, [Dockerfile](https://github.com/afreisinger/ubuntu-opensshserver/tree/master/versions/9.3/Dockerfile))

### Basic Usage

```bash
$ docker run --rm --publish=2222:22 afreisinger/ubuntu-sshd:9.3 # /entrypoint.sh
ssh-keygen: generating new host keys: RSA DSA ECDSA ED25519
Server listening on 0.0.0.0 port 22.
Server listening on :: port 22.

$ ssh root@localhost -p 2222  # or $(docker-machine ip default)
# The root password is "password".

$ docker ps | grep 2222
cf8097ea881d        afreisinger/ubuntu-sshd:9.3   "/entrypoint.sh"    8 seconds ago       Up 4 seconds        0.0.0.0:2222->22/tcp   stoic_ptolemy
$ docker stop cf80
```

Any arguments are passed to `sshd`. For example, to enable debug output:

```bash
$ docker run --rm --publish=2222:22 afreisinger/ubuntu-sshd:9.3 -o LogLevel=DEBUG
...
```

#### Version Info

```bash
$ docker run --rm afreisinger/ubuntu-sshd:9.3 -v
...
OpenSSH_9.3p1, OpenSSL 3.1.0 14 Mar 2023
...

$ docker run --rm --entrypoint=cat afreisinger/ubuntu-sshd:9.3 /etc/os-release

NAME="Ubuntu"
VERSION="18.04.6 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.6 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```

### Customize

This image doesn't attempt to be "the one" solution that suits everyone's needs. It's actually pretty useless in the real world. But it is easy to extend via your own `Dockerfile`. See the [examples directory.][examples]

#### Change root password

Change the root password to something more fun, like "password" or "sunshine":

```dockerfile
FROM afreisinger/ubuntu-sshd:latest
RUN echo "root:sunshine" | chpasswd
```

#### Use authorized keys

Disable the root password completely, and use your SSH key instead:

```dockerfile
FROM afreisinger/ubuntu-sshd:latest
RUN passwd -d root
COPY id_rsa.pub /root/.ssh/authorized_keys
```

#### Create multiple users

Disable root and create individual user accounts:

```dockerfile
FROM afreisinger/ubuntu-sshd:latest
ADD https://gitlab.com/afreisinger.keys /home/afreisinger/.ssh/authorized_keys
ADD https://gitlab.com/afrojas.keys /home/afrojas/.ssh/authorized_keys
RUN \
  passwd -d root && \
  adduser -D -s /bin/ash afreisinger && \
  passwd -u afreisinger && \
  chown -R afreisinger:afreisinger /home/afreisinger && \
  adduser -D -s /bin/ash afrojas && \
  passwd -u afrojas && \
  chown -R afrojas:afrojas /home/afrojas
```

#### Embed SSH host keys

Embed SSH host keys directly in your private image (via `ssh-keygen -A`), so you can treat your containers like cattle.

```dockerfile
FROM afreisinger/ubuntu-sshd:latest
ADD https://gitlab.com/afreisinger.keys /home/afreisinger/.ssh/authorized_keys
RUN \
  passwd -d root && \
  adduser -D -s /bin/bash afreisinger && \
  passwd -u afreisinger && \
  chown -R afreisinger:afreisinger /home/afreisinger && \
  ssh-keygen -A
```

### History

    2023-05-09 Updated to OpenSSH_9.3p1, OpenSSL 3.1.0 14 Mar 2023 (Alpine Linux 3.18.0).
  

[alpine_kubernetes]:  https://hub.docker.com/r/janeczku/alpine-kubernetes/
[alpine_linux]:       https://hub.docker.com/_/alpine/
[dockerhub_project]:  https://hub.docker.com/r/afreisinger/ubuntu-sshd/
[examples]:           https://github.com/afreisinger/ubuntu-sshd/tree/master/examples/
[github_project]:     https://github.com/afreisinger/ubuntu-sshd/
[openssh]:            http://www.openssh.com