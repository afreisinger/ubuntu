---
---
### Ubuntu Linux SSHD

A lightweight [OpenSSH][openssh] [Docker image][dockerhub_project] built atop [Ubuntu Linux][ubuntu_linux]. Available on [GitHub][github_project].

The root password is "password". SSH host keys (RSA, DSA, ECDSA, and ED25519) are auto-generated when the container is started, unless already present.

#### OpenSSL Version Tags

- `1.0` (OpenSSH_9.3p1, OpenSSL 3.1.0 14 Mar 2023, Ubuntu 18.04 , Personal host key, [Dockerfile](https://github.com/afreisinger/ubuntu/tree/master/versions/1.0/Dockerfile))
- `18.04`, `bionic` (OpenSSH_9.3p1, OpenSSL 3.1.0 14 Mar 2023, [Dockerfile](https://github.com/afreisinger/ubuntu/tree/master/versions/18.04/Dockerfile))
- `20.04`, `focal` (OpenSSH_9.3p1, OpenSSL 3.1.0 14 Mar 2023, [Dockerfile](https://github.com/afreisinger/ubuntu/tree/master/versions/20.04/Dockerfile))
- `23.10`, `mantic`, `latest` (OpenSSH_9.3p1, OpenSSL 3.1.0 14 Mar 2023, [Dockerfile](https://github.com/afreisinger/ubuntu/tree/master/versions/23.10/Dockerfile))

### Basic Usage

```bash
$ docker run --rm --publish=2222:22 afreisinger/ubuntu:18.04 # /entrypoint.sh
ssh-keygen: generating new host keys: RSA DSA ECDSA ED25519
Server listening on 0.0.0.0 port 22.
Server listening on :: port 22.

$ ssh root@localhost -p 2222  # or $(docker-machine ip default)
# The root password is "password".

$ docker ps | grep 2222
cf8097ea881d        afreisinger/ubuntu:18.04   "/entrypoint.sh"    8 seconds ago       Up 4 seconds        0.0.0.0:2222->22/tcp   stoic_ptolemy
$ docker stop cf80
```

Any arguments are passed to `sshd`. For example, to enable debug output:

```bash
$ docker run --rm --publish=2222:22 afreisinger/ubuntu:18.04 -o LogLevel=DEBUG
...
```

#### Version Info

```bash
$ docker run --rm afreisinger/ubuntu:18.04 -v
...
OpenSSH_9.3p1, OpenSSL 3.1.0 14 Mar 2023
...

$ docker run --rm --entrypoint=cat afreisinger/ubuntu:18.04 /etc/os-release

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
FROM afreisinger/ubuntu:18.04
RUN echo "root:sunshine" | chpasswd
```

#### Use authorized keys

Disable the root password completely, and use your SSH key instead:

```dockerfile
FROM afreisinger/ubuntu:18.04
RUN passwd -d root
COPY id_rsa.pub /root/.ssh/authorized_keys
```

#### Create multiple users

Disable root and create individual user accounts:

```dockerfile
FROM afreisinger/ubuntu:18.04
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
FROM afreisinger/ubuntu:18.04
ADD https://gitlab.com/afreisinger.keys /home/afreisinger/.ssh/authorized_keys

RUN \ 
    passwd -d root && \
    adduser --home /home/afreisinger --shell /bin/bash afreisinger && \
    usermod -p '*' afreisinger && \ 
    passwd -u afreisinger && \
    mkdir -p /home/afreisinger/.ssh && \
    chmod 700 /home/afreisinger/.ssh && \
    touch /home/afreisinger/.ssh/config && \
    chmod 600 /home/afreisinger/.ssh/config && \
    mv /tmp/authorized_keys /home/afreisinger/.ssh/authorized_keys && \
    chmod 600 /home/afreisinger/.ssh/authorized_keys && \
    chown -R afreisinger:afreisinger /home/afreisinger && \
    ssh-keygen -A
```

### History

    2023-05-09 Updated to OpenSSH_9.3p1, OpenSSL 3.1.0 14 Mar 2023 (Ubuntu Linux 18.04).
  

[alpine_kubernetes]:  https://hub.docker.com/r/janeczku/alpine-kubernetes/
[ubuntu_linux]:       https://hub.docker.com/_/ubuntu/
[dockerhub_project]:  https://hub.docker.com/r/afreisinger/ubuntu/
[examples]:           https://github.com/afreisinger/ubuntu/tree/master/examples/
[github_project]:     https://github.com/afreisinger/ubuntu/
[openssh]:            http://www.openssh.com