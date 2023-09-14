# 使用 Debian 11 作为基础镜像
FROM debian:11

# 设置工作目录
WORKDIR /backend-svr

# 更新包管理器并安装必要的工具
RUN apt update && \
    apt install -y apt-transport-https wget

# 安装 Microsoft 的包存储库
RUN wget -q https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb

# 安装 .NET Core SDK 3.1
RUN apt update && \
    apt install -y dotnet-sdk-3.1

# 将当前目录下的文件复制到容器中
COPY ./ ./

# 运行 dotnet restore 和 dotnet build
RUN dotnet restore && \
    dotnet build

# 暴露端口（请确保这与你的应用程序的端口配置一致）
EXPOSE 5000

# 启动应用程序
CMD [ "dotnet", "run" ]
