FROM archlinux:base

LABEL maintainer="fmacrae.dev@gmail.com"

# WORKAROUND for glibc 2.33 and old Docker
# See https://github.com/actions/virtual-environments/issues/2658
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
bsdtar -C / -xvf "$patched_glibc"
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm \
    i3status \
    i3-wm \
    git \
    net-tools \
    python3 \
    rxvt-unicode \
    supervisor \
    ttf-dejavu \
    x11vnc \
    xorg-server \
    xorg-apps \
    xorg-server-xvfb \
    xorg-xinit

# noVNC setup
WORKDIR /usr/share/
RUN git clone https://github.com/kanaka/noVNC.git
WORKDIR /usr/share/noVNC/utils/
RUN git clone https://github.com/kanaka/websockify

RUN export DISPLAY=:0.0

COPY supervisord.conf /etc/

EXPOSE 8083

RUN useradd -m user
WORKDIR /home/user

CMD ["/usr/bin/supervisord"]
