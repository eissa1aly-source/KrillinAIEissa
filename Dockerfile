FROM alpine:latest

RUN apk add --no-cache ca-certificates ffmpeg wget curl python3 py3-pip
RUN pip3 install yt-dlp

WORKDIR /app

# إنشاء صورة وهمية
RUN mkdir -p static && \
    printf '\xFF\xD8\xFF\xE0\x00\x10JFIF\x00\x01\x01\x00\x00\x01\x00\x01\x00\x00' > static/background.jpg

COPY . .

RUN go mod download && go build -o KrillinAI ./cmd/server
RUN chmod +x ./KrillinAI

EXPOSE 7860

CMD ["./KrillinAI"]
