# Create Virtual Device

## Install lib

```
sudo apt install v4l2loopback-dkms
pip install pyvirtualcam
```

## Creata virtual Device

Create `/dev/video2, video3, video4`:
```
sudo modprobe v4l2loopback video_nr=2,3,4
```

Delete virtual Device:
```
sudo rmmod v4l2loopback
```

## Put image into virtual Device

Read image from `/dev/video0` and put into `/dev/video2 and /dev/video3`
```
import argparse
import cv2
import pyvirtualcam
from pyvirtualcam import PixelFormat

parser = argparse.ArgumentParser()
parser.add_argument("--camera", type=int, default=0, help="ID of webcam device (default: 0)")
parser.add_argument("--fps", action="store_true", help="output fps every second")
parser.add_argument("--filter", choices=["shake", "none"], default="shake")
args = parser.parse_args()

# Set up webcam capture.
vc = cv2.VideoCapture(0)

if not vc.isOpened():
    raise RuntimeError('Could not open video source')

pref_width = 1280
pref_height = 720
pref_fps_in = 30
vc.set(cv2.CAP_PROP_FRAME_WIDTH, pref_width)
vc.set(cv2.CAP_PROP_FRAME_HEIGHT, pref_height)
vc.set(cv2.CAP_PROP_FPS, pref_fps_in)

# Query final capture device values (may be different from preferred settings).
width = int(vc.get(cv2.CAP_PROP_FRAME_WIDTH))
height = int(vc.get(cv2.CAP_PROP_FRAME_HEIGHT))
fps_in = vc.get(cv2.CAP_PROP_FPS)
print(f'Webcam capture started ({width}x{height} @ {fps_in}fps)')

fps_out = 20

camera1 = pyvirtualcam.Camera(width, height, fps_out, fmt=PixelFormat.BGR, print_fps=args.fps)
print(f'Virtual cam1 started: {camera1.device} ({camera1.width}x{camera1.height} @ {camera1.fps}fps)')

camera2 = pyvirtualcam.Camera(width, height, fps_out, fmt=PixelFormat.BGR, print_fps=args.fps)
print(f'Virtual cam2 started: {camera2.device} ({camera2.width}x{camera2.height} @ {camera2.fps}fps)')

while True:
    ret, frame = vc.read()
    if not ret:
        raise RuntimeError('Error fetching frame')
    camera1.send(frame)
    camera2.send(frame)

    # Wait until it's time for the next frame.
    camera1.sleep_until_next_frame()
    # camera2.sleep_until_next_frame()
        
      

with pyvirtualcam.Camera(width, height, fps_out, fmt=PixelFormat.BGR, print_fps=args.fps) as cam:
    print(f'Virtual cam started: {cam.device} ({cam.width}x{cam.height} @ {cam.fps}fps)')

    # Shake two channels horizontally each frame.
    channels = [[0, 1], [0, 2], [1, 2]]

    while True:
        # Read frame from webcam.
        ret, frame = vc.read()
        if not ret:
            raise RuntimeError('Error fetching frame')

        if args.filter == "shake":
            dx = 15 - cam.frames_sent % 5
            c1, c2 = channels[cam.frames_sent % 3]
            frame[:,:-dx,c1] = frame[:,dx:,c1]
            frame[:,dx:,c2] = frame[:,:-dx,c2]

        # Send to virtual cam.
        cam.send(frame)

        # Wait until it's time for the next frame.
        cam.sleep_until_next_frame()

```
