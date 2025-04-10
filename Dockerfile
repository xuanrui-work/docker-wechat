FROM ubuntu:24.04

# Set environment
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# Define a build-time variable for the WeChat download URL
ARG WECHAT_URL=https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb

# Install dependencies for GUI + audio + wechat
RUN apt-get update && apt-get install -y \
  wget \
  libatomic1 \
  libxkbcommon-x11-0 \
  libglib2.0-0 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxrandr2 \
  # libasound2 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcups2 \
  libdbus-1-3 \
  libgdk-pixbuf2.0-0 \
  libgtk-3-0 \
  libxss1 \
  libxtst6 \
  libnotify4 \
  pulseaudio-utils \
  x11-xserver-utils \
  && apt clean && rm -rf /var/lib/apt/lists/*

# Additional dependencies given out in [here](https://github.com/RICwang/docker-wechat/blob/main/Dockerfile)
RUN apt update && apt install -y \
  language-pack-zh-hans fonts-noto-cjk-extra curl \
  shared-mime-info desktop-file-utils libxcb1 libxcb-icccm4 libxcb-image0 \
  libxcb-keysyms1 libxcb-randr0 libxcb-render0 libxcb-render-util0 libxcb-shape0 \
  libxcb-shm0 libxcb-sync1 libxcb-util1 libxcb-xfixes0 libxcb-xkb1 libxcb-xinerama0 \
  libxcb-xkb1 libxcb-glx0 libatk1.0-0 libatk-bridge2.0-0 libc6 libcairo2 libcups2 \
  libdbus-1-3 libfontconfig1 libgbm1 libgcc1 libgdk-pixbuf2.0-0 libglib2.0-0 \
  libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 \
  libxcomposite1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 \
  libxss1 libxtst6 libatomic1 libxcomposite1 libxrender1 libxrandr2 libxkbcommon-x11-0 \
  libfontconfig1 libdbus-1-3 libnss3 libx11-xcb1 libasound2t64 \
  && apt clean && rm -rf /var/lib/apt/lists/*

# Download and install WeChat
RUN wget $WECHAT_URL -O /tmp/wechat-install.deb && \
  apt-get install -y /tmp/wechat-install.deb && \
  rm /tmp/wechat-install.deb

# Create a non-root user for running WeChat
# RUN useradd -m wechatuser
# USER wechatuser
# WORKDIR /home/wechatuser

# Set display and pulse audio defaults
ENV DISPLAY=:0
ENV PULSE_SERVER=unix:/run/user/1000/pulse/native

# Entrypoint
ENTRYPOINT ["wechat"]
