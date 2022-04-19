FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
	tmux \
	wget \
	zsh \
	neovim \
	sxiv \
	mediainfo \ 
	bat \
	curl \
	rsync \
	git \
	zathura \
	mpv \
	python3-pip \
	x11-apps \
	trash-cli \
	neofetch \
	graphicsmagick \
	ffmpegthumbnailer \
	&& rm -rf /var/lib/apt/lists/*

COPY .Xauthority /root/.Xauthority
COPY .config/python/requirements.txt /scripts/requirements.txt
RUN pip install -r /scripts/requirements.txt

WORKDIR /root/	
ENTRYPOINT ["/bin/bash"]
	
