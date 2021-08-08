#!/bin/bash

set -x

gcc -o hotdog-printALSAStatus hotdog-printALSAStatus.c -lasound
gcc -o hotdog-setALSAMute: hotdog-setALSAMute:.c -lasound
gcc -o hotdog-setALSAVolume hotdog-setALSAVolume.c -lasound
gcc -o hotdog-monitorBlockDevices hotdog-monitorBlockDevices.c
gcc -o hotdog-monitorNetworkInterfaces hotdog-monitorNetworkInterfaces.c
gcc -o hotdog-monitorMonitors hotdog-monitorMonitors.c

