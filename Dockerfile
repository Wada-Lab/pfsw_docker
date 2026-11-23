FROM ubuntu:24.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        unminimize && \
    yes | unminimize

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        openssh-server \
        procps \
        sudo \
        man-db \
        manpages \
        manpages-dev \
        build-essential && \
    rm -rf /var/lib/apt/lists/*

# SSHログイン用の一般ユーザ
RUN useradd -m -s /bin/bash student && \
    echo 'student:student' | chpasswd && \
    usermod -aG sudo student

# sshdが必要とするディレクトリとホスト鍵
RUN mkdir -p /run/sshd && \
    ssh-keygen -A

# 演習用設定
RUN printf '%s\n' \
    'PasswordAuthentication yes' \
    'PermitRootLogin no' \
    'AllowUsers student' \
    > /etc/ssh/sshd_config.d/lab.conf

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]
