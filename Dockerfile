FROM openjdk:8-jre-slim
WORKDIR /app

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|mirrors.aliyun.com/debian-security|g' /etc/apt/sources.list
    
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         libfreetype6 \
         fontconfig \
    && rm -rf /var/lib/apt/lists/*
# RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

# 启动命令
CMD ["echo", "ok"]