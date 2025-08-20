# Copyright (C) 2025 Yuu Oniichan
# Custom Stremio Server build with prepackaged ffmpeg/ffprobe

# node version để chạy server
ARG NODE_VERSION=14
FROM node:${NODE_VERSION}

ARG VERSION=custom
ARG BUILD=desktop

LABEL com.stremio.vendor="Yuu Oniichan ❤️"
LABEL version=${VERSION}
LABEL description="Custom Stremio streaming server with bundled ffmpeg/ffprobe"

SHELL ["/bin/sh", "-c"]

WORKDIR /stremio

# Cài tool cần thiết
RUN sed -ie 's/deb\.debian/archive.debian/g' /etc/apt/sources.list \
    && apt -y update && apt -y install wget unzip \
    && rm -rf /var/lib/apt/lists/*

# Tải và giải nén sv.zip (chứa ffmpeg/ffprobe + server.js)
RUN wget https://github.com/hung319/build/releases/download/stremio-service/sv.zip \
    && unzip sv.zip \
    && rm sv.zip

# Đưa ffmpeg và ffprobe vào /usr/bin để toàn hệ thống dùng được
RUN mv /stremio/ffmpeg /usr/bin/ffmpeg \
    && mv /stremio/ffprobe /usr/bin/ffprobe \
    && chmod +x /usr/bin/ffmpeg /usr/bin/ffprobe

# Cấu hình ENV cho app
ENV FFMPEG_BIN=/usr/bin/ffmpeg
ENV FFPROBE_BIN=/usr/bin/ffprobe
ENV APP_PATH=/root/.stremio-server
ENV NO_CORS=
ENV CASTING_DISABLED=1

VOLUME ["/root/.stremio-server"]

# HTTP
EXPOSE 11470
# HTTPS
EXPOSE 12470

ENTRYPOINT [ "node", "server.js" ]
