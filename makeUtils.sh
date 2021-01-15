#!/bin/bash

set -x

cd Utils
gcc -o printALSAStatus printALSAStatus.c -lasound
gcc -o setALSAMute: setALSAMute:.c -lasound
gcc -o setALSAVolume setALSAVolume.c -lasound
gcc -o monitorBlockDevices monitorBlockDevices.c
gcc -o monitorNetworkInterfaces monitorNetworkInterfaces.c
gcc -o monitorMonitors monitorMonitors.c

