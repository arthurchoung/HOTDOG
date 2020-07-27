#!/bin/bash

set -x

cd Utils
clang -o printALSAStatus printALSAStatus.c -lasound
clang -o setALSAMute: setALSAMute:.c -lasound
clang -o setALSAVolume setALSAVolume.c -lasound
clang -o monitorBlockDevices monitorBlockDevices.c
clang -o monitorNetworkInterfaces monitorNetworkInterfaces.c
clang -o monitorMonitors monitorMonitors.c

