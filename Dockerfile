FROM ubuntu:latest
COPY rc.local /etc/rc.local
RUN chmod +x /etc/rc.local\
    && buildDeps='openssh-server vim net-tools curl fish sudo'\
    && sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list\
    && sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list\
    && apt-get clean\
    && apt-get update\
    && apt-get install -y $buildDeps
RUN echo 'root:root' |chpasswd\
    && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config\
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config\
    && mkdir /var/run/sshd
    
EXPOSE 22
ENTRYPOINT [ "/etc/rc.local" ]
