#!/bin/bash

tail -n 100 ~/Library/Logs/kodi.log | grep "NOTICE: DVDPlayer: Opening:" | awk '{print $6}' | xargs curl -C - -L > never_gonna_give_you_up.mp4
