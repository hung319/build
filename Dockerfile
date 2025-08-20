FROM debian:11

RUN apt-get update && apt-get install -y \
    wget unzip curl gnupg nodejs npm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Tải và giải nén
RUN wget https://github.com/hung319/build/releases/download/stremio-service/sv.zip \
    && unzip sv.zip \
    && rm sv.zip

# Chuyển ffmpeg + ffprobe vào /usr/bin và set quyền
RUN mv /app/ffmpeg /usr/bin/ffmpeg \
    && mv /app/ffprobe /usr/bin/ffprobe \
    && chmod +x /usr/bin/ffmpeg /usr/bin/ffprobe

# Set ENV để chắc chắn app nào cần vẫn có
ENV FFMPEG_BIN=/usr/bin/ffmpeg
ENV FFPROBE_BIN=/usr/bin/ffprobe

EXPOSE 8080

CMD ["node", "server.js"]
