FROM node:20-alpine

WORKDIR /stremio

# Cài công cụ cần thiết
RUN apk add --no-cache wget unzip

# Tải và giải nén sv.zip (ffmpeg/ffprobe + server.js)
RUN wget https://github.com/hung319/build/releases/download/stremio-service/sv.zip \
    && unzip sv.zip \
    && rm sv.zip

VOLUME ["/root/.stremio-server"]

# Tạo file .env
RUN echo "export FFMPEG_BIN=/stremio/ffmpeg" > .env \
    && echo "export FFPROBE_BIN=/stremio/ffprobe" >> .env

# Tạo start.sh
RUN echo "set -a; . .env; set +a; node server.js" > start.sh \
    && chmod +x start.sh

CMD ["sh", "start.sh"]
