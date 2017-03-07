FROM debian

RUN apt-get update && apt-get install -y \
  curl \
  gcc \
  libpcre3-dev \
  libssl-dev \
  make

RUN curl http://tengine.taobao.org/download/tengine-2.2.0.tar.gz > /opt/tengine-2.2.0.tar.gz

WORKDIR /opt

RUN tar xzf tengine-2.2.0.tar.gz

WORKDIR /opt/tengine-2.2.0

RUN ./configure

RUN make

RUN make install

RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
  && ln -sf /dev/stderr /usr/local/nginx/logs/error.log

EXPOSE 80 443

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
