#!/bin/sh
# automatically run tests after saving
# apt-get install inotify-tools
MONITORDIR="src"
while inotifywait -e close_write $MONITORDIR; do make test; done
