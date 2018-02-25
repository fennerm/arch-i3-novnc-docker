FROM pritunl/archlinux:latest

MAINTAINER Fenner Macrae <fmacrae.dev@gmail.com>

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

# i3 setup
RUN useradd -m user
RUN echo "user ALL=(ALL) ALL" > /etc/sudoers
WORKDIR /home/user
RUN mkdir -p /home/user/.config/i3
RUN chown -R user: /home/user/
RUN chown user /usr/sbin/i3status
RUN cp /etc/i3/config /home/user/.config/i3
USER user

CMD ["/usr/bin/supervisord"]
