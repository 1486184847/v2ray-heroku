FROM alpine:3.5

RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip  wget

RUN apk update && \
    apk add --no-cache openssh tzdata && \ 
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
       ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key && \
    echo "root:admin" | chpasswd && \
    cd /etc/ssh && \
    chmod 644 ./* && \
    chmod 600 ssh_host_rsa_key && \
    chmod 755 

# 开放22端口
EXPOSE 22

RUN apk add --no-cache --virtual .build-deps curl ca-certificates \
 && curl -L -o /frp.tar.gz --insecure https://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_linux_amd64.tar.gz \
 && tar -zxvf /frp.tar.gz frp_0.33.0_linux_amd64/frps \
 && mv frp_0.33.0_linux_amd64/frps /usr/bin/frps \
 && chmod +x /usr/bin/frps \
 && rm -rf /frp* frp*
EXPOSE  7000
 
# 执行ssh启动命令
CMD ["/usr/sbin/sshd", "-D"]

ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
CMD /configure.sh
