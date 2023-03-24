FROM ubuntu:latest
COPY rc.local /etc/rc.local
RUN chmod +x /etc/rc.local\
    && buildDeps='openssh-server vim net-tools curl fish'\
    && sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list\
    && sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list\
    && apt-get clean\
    && apt-get update\
    && apt-get install -y $buildDeps
ENTRYPOINT [ "/etc/rc.local" ]
