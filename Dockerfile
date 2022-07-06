FROM alpine:latest

ARG TARGETPLATFORM
ENV TZ="Asia/Shanghai"

COPY ./script/entrypoint.sh /entrypoint.sh

RUN apk --no-cache --no-progress add \
    ca-certificates \
    tzdata && \
    cp "/usr/share/zoneinfo/$TZ" /etc/localtime && \
    echo "$TZ" >  /etc/timezone && \
    chmod +x /entrypoint.sh

WORKDIR /dashboard
COPY ./resource ./resource
COPY target/$TARGETPLATFORM/dashboard ./app

VOLUME ["/dashboard/data"]
EXPOSE 80 5555
ENTRYPOINT ["/entrypoint.sh"]