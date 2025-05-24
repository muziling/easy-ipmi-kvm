![easy-ipmi-kvm logo](/images/logo.png)

Maintained version of [solarkennedy/ipmi-kvm-docker](https://github.com/solarkennedy/ipmi-kvm-docker) with x32 Java to work with supermicro's iKVM > v3.55

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/evevseev/easy-ipmi-kvm/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/evevseev/easy-ipmi-kvm)

## Chnages
- Current version of noVNC server
- x32 Java to fix problem with supermicro iKVM > v3.55
- Revert back to Firefox

## This container runs

- Xvfb - X11 in a virtual framebuffer
- x11vnc - A VNC server that scrapes the above X11 server
- [noNVC](https://kanaka.github.io/noVNC/) - A HTML5 canvas vnc viewer
- Fluxbox - a small window manager
- Firefox - For browsing IPMI consoles
- Icedtea - Java Web Start to access most IPMI KVM Consoles.

## Setting up

Read novnc/utils/README.md first, download websockify then run docker build to build docker image, otherwise docker run will start fail.
```
$ docker run -p 8080:8080 evevseev/easy-ipmi-kvm
open http://admin:8080/vnc.html # or just open in a browser
```


## Custom options
### Resolution

By default, the VNC session will run with a resolution of 1260x700x24 (with 24-bit color depth).
Custom resolutions can be specified with the docker environment variable RES.

```$ docker run -p 8080:8080 -e RES=1600x900x24 evevseev/easy-ipmi-kvm```

### Mount volumes

In case you need to mount floppy/iso images to the machine you can mount a volume to the container.

```$ docker run -p 8080:8080 -v /your/local/folder:/root/images evevseev/easy-ipmi-kvm```

## Tested on

- Supermicro (`3.55`, `3.62`)
