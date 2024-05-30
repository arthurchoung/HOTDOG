#!/bin/sh

set -x

gcc -o hotdog-generateALSAPanel hotdog-generateALSAPanel.c -lasound
gcc -o hotdog-printALSAUpdates hotdog-printALSAUpdates.c -lasound
gcc -o hotdog-printALSAStatus hotdog-printALSAStatus.c -lasound
gcc -o hotdog-setALSAMute: hotdog-setALSAMute:.c -lasound
gcc -o hotdog-setALSAVolume hotdog-setALSAVolume.c -lasound
gcc -o hotdog-setALSAValues hotdog-setALSAValues.c -lasound
gcc -o hotdog-monitorBlockDevices hotdog-monitorBlockDevices.c
gcc -o hotdog-monitorNetworkInterfaces hotdog-monitorNetworkInterfaces.c
gcc -o hotdog-monitorMonitors hotdog-monitorMonitors.c
gcc -o hotdog-monitorMountChanges hotdog-monitorMountChanges.c
g++ -o hotdog-solveFifteenPuzzle hotdog-solveFifteenPuzzle.cpp
gcc -o hotdog-packRectanglesIntoWidth:height:... hotdog-packRectanglesIntoWidth:height:....c

#freebsd
#clang -o hotdog-printMixerVolume hotdog-printMixerVolume.c
#clang -o hotdog-setMixerVolume hotdog-setMixerVolume.c
