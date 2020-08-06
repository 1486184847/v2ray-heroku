FROM alpine:3.5

RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip openssh wget \
/etc/init.d/sshd start \


ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
CMD /configure.sh
