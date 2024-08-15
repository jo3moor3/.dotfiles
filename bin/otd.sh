#!/usr/bin/env sh

cd ~/.config/OpenTabletDriver/Presets

chosen=$(printf "%s\n" * | rofi -dmenu -i "otdpreset" )

otd applypreset "${chosen::-5}"
