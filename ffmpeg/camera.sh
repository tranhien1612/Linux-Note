#!/bin/bash

# Configuration
INPUT_DEVICE="/dev/video0"     # Camera device
OUTPUT_DIR="./recordings"      # Output directory
RESOLUTION="640x512"           # Full sensor resolution
FRAMERATE=30                   # Framerate
BITRATE="5M"                   # Bitrate
PID_FILE="/tmp/ffmpeg_rec.pid" # PID file

# Create output directory
mkdir -p "$OUTPUT_DIR"

start_recording() {
    if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null; then
        echo "Recording is already running (PID $(cat $PID_FILE))"
        exit 1
    fi

    # Generate timestamped filename
    FILENAME="$OUTPUT_DIR/$(date +%Y%m%d_%H%M%S).mp4"

    # Start FFmpeg in the background
    ffmpeg -f v4l2 -input_format nv12 \
        -video_size "$RESOLUTION" \
        -framerate "$FRAMERATE" \
        -i "$INPUT_DEVICE" \
        -c:v libx264 \
        -preset ultrafast \
        -tune zerolatency \
        -b:v "$BITRATE" \
        -f mp4 "$FILENAME" \
        &

    # Save PID
    echo $! > "$PID_FILE"
    echo "Recording started (PID $!) -> $FILENAME"
}

stop_recording() {
    if [ ! -f "$PID_FILE" ] || ! kill -0 $(cat "$PID_FILE") 2>/dev/null; then
        echo "No recording is active"
        exit 1
    fi

    # Gracefully stop FFmpeg
    kill $(cat "$PID_FILE")
    rm -f "$PID_FILE"
    echo "Recording stopped"
}

take_photo() {
    if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null; then
        echo "Photo is already running (PID $(cat $PID_FILE))"
        exit 1
    fi

    FILENAME="$OUTPUT_DIR/$(date +%Y%m%d_%H%M%S).jpg"
    ffmpeg -f v4l2 -video_size 640x1024 \
        -i "$INPUT_DEVICE" \
        -frames:v 1 "$FILENAME" \
        &

    kill $(cat "$PID_FILE")
    rm -f "$PID_FILE"
    echo "Take photo"
}

start_stream(){
    echo "Streaming..."
    mediamtx mediamtx_custom.yml
}

case "$1" in
    photo)
        take_photo
        ;;
    stream)
        start_stream
        ;;
    start)
        start_recording
        ;;
    stop)
        stop_recording
        ;;
    status)
        if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null; then
            echo "Recording is active (PID $(cat $PID_FILE))"
        else
            echo "No recording is active"
        fi
        ;;
    *)
        echo "Usage: $0 {photo|start|stop|stream|status}"
        exit 1
        ;;
esac
