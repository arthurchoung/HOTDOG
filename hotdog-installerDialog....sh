#!/bin/bash

TEXT=$( "$@" )
PATH="/root:$PATH" dialog --msgbox "$TEXT" 16 68

