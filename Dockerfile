# Instead of hardcoding a Debian version, we reserve the possibility to provide a version at build time
# using --build-arg debian_version=x.y.z
#FROM debian:stretch
#FROM debian:latest

# Unless specified explicitely, use latest stable minor update (slim variant)
ARG debian_version=stable-slim

FROM debian:$debian_version

#COPY gjs /gjs

EXPOSE 8085

# RUN pacman --noconfirm -S gtk3 xfce4 midori mypaint gedit nautilus gnome-mines htop gcc pkg-config gjs vim
# #toilix
# RUN pacman --noconfirm -S arc-gtk-theme git wget yajl dub dmd terminator

# RUN pacman -S --noconfirm --needed base-devel 

# RUN pacman -S --noconfirm gnome gnome-extra mate mate-extra

# RUN git clone https://github.com/gnunn1/tilix.git; cd tilix; dub build --build=release; ./install.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgtk-3-bin \
    wireshark-gtk

#useradd -m -g user bash user

ENV GDK_BACKEND broadway
ENV BROADWAY_DISPLAY :5

COPY traces-exemple-1.pcapng /traces-exemple-1.pcapng

COPY init.sh /init.sh
CMD ["/init.sh"]

RUN cat /etc/debian_version