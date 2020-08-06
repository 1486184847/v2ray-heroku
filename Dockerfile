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
    echo "root:admin" | chpasswd

# 开放22端口
EXPOSE 22
 
# 执行ssh启动命令
CMD ["/usr/sbin/sshd", "-D"]

ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
CMD /configure.sh
