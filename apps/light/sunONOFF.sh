#!/usr/bin/env bash
STATUS=$(hyprshade current)

ENABLED=󰌵
DISABLED=󰌶

if [[ "$STATUS" == "vibrance" ]] || [[ "$STATUS" == "blue-light-filter" ]]
then echo $ENABLED
else echo $DISABLED; fi
