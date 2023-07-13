FROM ubuntu:20.04

# Set this before `apt-get` so that it can be done non-interactively
ENV DEBIAN_FRONTEND noninteractive
ENV TZ America/New_York
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Golang env
ENV GO_PARENT_DIR /opt
ENV GOROOT $GO_PARENT_DIR/go
ENV GOPATH $HOME/work/

# Set PATH to include custom bin directories
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

# Do everything in one RUN command
RUN /bin/bash <<EOF
set -euxo pipefail
apt-get update

apt-get install -y --no-install-recommends \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  gnupg \
  python3 \
  python3-pip \
  software-properties-common \
  wget

# Use kitware's CMake repository for up-to-date version
curl -sSf https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add -
apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main'
# Use NodeSource's NodeJS 16.x repository
curl -sSf https://deb.nodesource.com/setup_16.x | bash -

# Install nodejs/npm
apt-get update
apt-get install -y --no-install-recommends \
  nodejs
# Install other javascript package managers
npm install -g yarn pnpm

# Install newer version of Go than is included with Ubuntu 20.04
wget https://go.dev/dl/go1.19.11.linux-amd64.tar.gz -O "$GO_PARENT_DIR/go1.19.11.linux-amd64.tar.gz"
tar -xf "$GO_PARENT_DIR/go1.19.11.linux-amd64.tar.gz" -C "$GO_PARENT_DIR"
rm -rf "$GO_PARENT_DIR/go1.19.11.linux-amd64.tar.gz"

# Install neovim
wget https://github.com/neovim/neovim/releases/download/v0.9.1/nvim.appimage -O /usr/local/bin/nvim
chmod +x /usr/local/bin/nvim
python3 -m pip install --user --upgrade pynvim
# Install vim plugin
curl -fLo /root/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install everything else
apt-get update
apt-get install -y --no-install-recommends \
  autoconf \
  automake \
  bc \
  cmake \
  git \
  file \
  jq \
  ncurses-dev \
  openssh-client \
  libncurses5-dev \
  libssl-dev \
  time \
  unzip \
  zip \
  zlib1g-dev \
  gcc-10 \
  g++-10 \
  gdb \
  clang \
  clang-format \
  libclang-dev \
  ccls \
  vim \
  libfuse2 \
  ripgrep

apt-get clean
rm -rf /var/lib/apt/lists/*
EOF

# copy dependencies
COPY coc-settings.json init.vim /root/.config/nvim/

CMD ["/bin/bash"]
