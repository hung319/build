FROM debian:11

# Cài mấy gói cần thiết
RUN apt-get update && apt-get install -y \
    wget unzip curl gnupg nodejs npm ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Tải và giải nén sv.zip
WORKDIR /app
RUN wget https://github.com/hung319/build/releases/download/stremio-service/sv.zip \
    && unzip sv.zip \
    && rm sv.zip

# Set ENV cho ffmpeg/ffprobe
ENV FFMPEG_BIN=ffmpeg
ENV FFPROBE_BIN=ffprobe

# Expose port (nếu server.js cần, ví dụ 8080)
EXPOSE 11470

# Chạy app
CMD ["node", "server.js"]
