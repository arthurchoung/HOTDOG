#!/bin/bash

if [ "x$1" = "x" ]; then
    echo "specify alsa device, example 'hw:0'"
    exit 1
fi

hotdog-generateALSAPanel "$@" | hotdog show ALSAPanel | hotdog-setALSAValues "$1"

