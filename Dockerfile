FROM alpine:3.8

RUN apk add --update nginx bash && rm -rf /var/cache/apk/*

RUN mkdir -p /run/nginx
COPY /script/makeConf.sh /
COPY /script/template /

CMD ["/makeConf.sh"]
