# Linux Note

## Using ffmpeg and mediantx to stream video from camera
### Install lib
```
    sudo apt install ffmpeg

    wget https://github.com/bluenviron/mediamtx/releases/download/v1.7.0/mediamtx_v1.7.0_linux_arm64v8.tar.gz
    tar -xzf mediamtx_v1.7.0_linux_arm64v8.tar.gz
    sudo mv mediamtx /usr/local/bin/
```

### Create custom mediantx file

Create mediamtx_custom.yml file:
```
paths:
  stream:
    runOnInit: ffmpeg -f v4l2 -input_format nv12 -video_size 640x512 -framerate 30 -i /dev/video0 -c:v libx264 -preset ultrafast -tune zerolatency -b:v 5M -f rtsp rtsp://localhost:8554/stream
    runOnInitRestart: yes
```

### Run program

```
  mediantx mediamtx_custom.yml
```
