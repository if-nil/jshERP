# 第一阶段：构建前端
FROM node:20.17.0 AS frontend-build
WORKDIR /app/web
COPY jshERP-web/ ./
RUN yarn install --frozen-lockfile && yarn build

# 第二阶段：构建后端
FROM maven:3.8.6-openjdk-8 AS backend-build
WORKDIR /app/boot
COPY jshERP-boot/ ./
RUN mvn clean package -DskipTests

# 第三阶段：生产镜像
FROM openjdk:8-jre-slim
WORKDIR /app

# RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
#     sed -i 's|security.debian.org/debian-security|mirrors.aliyun.com/debian-security|g' /etc/apt/sources.list
    
# RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

# # 复制后端jar
# COPY released ./
COPY --from=backend-build /app/boot/target/*.jar /build/jshERP.jar

# 复制前端dist
COPY --from=frontend-build /app/web/dist /build/dist

# WORKDIR /app/backend

# # 暴露端口（根据实际后端端口修改）
# EXPOSE 9999

# 启动命令
CMD ["sh", "copy.sh"]