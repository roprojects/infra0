FROM alpine:3.12.0

ARG user=user
ARG password=secretpassword

RUN apk add --no-cache --update \
    samba-common-tools \
    samba-client \
    samba-server

RUN adduser -D $user && \
    echo $user':'$password | chpasswd && \
    (echo $password; echo $password) | smbpasswd -s -a $user

COPY smb.conf /etc/samba/smb.conf

EXPOSE 139/tcp 445/tcp

CMD ["smbd", "--foreground", "--log-stdout", "--no-process-group"]
