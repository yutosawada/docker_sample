# ============================================================
# Stage 1: Build Stage
# ============================================================
# FROM ubuntu:24.04 AS builder
FROM ros:humble-ros-base AS builder
ENV DEBIAN_FRONTEND=noninteractive

# 1. ROS humble のパッケージリポジトリ設定と必要パッケージのインストール
# 必要なツールと依存関係をインストール
RUN apt update && apt install -y \
    locales \
    curl \
    gnupg \
    lsb-release \
    build-essential \
    cmake \
    git \
    bash-completion \
    python3-pip && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

# rosdep の初期化（初回のみ有効。CI環境等ではエラーを無視）
# Initialize rosdep (only needed once; ignore errors in CI)
RUN rosdep init && rosdep update || true

RUN mkdir -p ros2_ws/src
WORKDIR /ros2_ws
# 外部からリポジトリURLを指定できるようにする（デフォルト値も設定可能）
ARG REPO_URL_LIFTUP=https://github.com/yutosawada/liftup.git

# ROS2ソフトウェアをクローン（パッケージ単位で管理されている前提）
RUN cd  src && \
    git clone ${REPO_URL_LIFTUP} src

# ROS2 の環境をセットアップして colcon build を実行
# Setup ROS2 environment and build the workspace using colcon
RUN . /opt/ros/humble/setup.sh && \
    colcon build --merge-install

# ============================================================
# Stage 2: Runtime Stage
# ============================================================
# FROM ubuntu:24.04 AS runtime
FROM ros:humble-ros-base AS runtime

ENV DEBIAN_FRONTEND=noninteractive


# 1. ランタイムで必要な ROS ランタイムと joy パッケージのインストール
RUN apt update && apt install -y \
    vim \
    can-utils \
    ros-humble-joy \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# ビルドステージで作成したインストール成果物をコピー
# Copy the built install artifacts from the builder stage
COPY --from=builder /ros2_ws/install ros2_ws/install

# Docker用エントリーポイントスクリプトをコピー
# Copy the Docker entrypoint script from the docker/scripts directory
COPY ./docker/scripts/entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

WORKDIR /root


ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["bash"]