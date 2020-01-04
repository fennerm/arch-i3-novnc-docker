arch-i3-novnc-docker
====================

Docker container with a minimal arch linux + i3 window manager install. The docker X server can be accessed in the browser with novnc.

Usage
-----

``` {.shell}
docker pull fennerm/arch-i3-novnc
docker run --rm -p 8083:8083 -ti --name arch-i3-novnc -e DISPLAY=:0.0 fennerm/arch-i3-novnc supervisord
```

Then navigate to `localhost:8083/vnc.html` in your browser.
