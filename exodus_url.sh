#!/bin/bash

tail -n 100 ~/Library/Logs/kodi.log | grep "NOTICE: DVDPlayer: Opening:" | awk '{print $6}' | pbcopy
