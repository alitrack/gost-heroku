FROM alpine:3.6

ENV VER=2.10.1 METHOD=chacha20 PASSWORD=ss123456
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache curl \
  && curl -sL https://github.com/ginuerzh/gost/releases/download/v${VER}/gost-linux-amd64-${VER}.gz | gzip -d \
  && mv gost_linux_amd64_${VER} gost && chmod a+x gost

WORKDIR /gost
EXPOSE ${TLS_PORT} $PORT

CMD exec /gost/gost -L=tls://:${TLS_PORT}/:$PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT

