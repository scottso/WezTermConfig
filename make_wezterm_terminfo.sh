#!/usr/bin/env bash
set -e

# This script checks if the required apps are installed, creates a .terminfo directory,
# and downloads and compiles the wezterm.terminfo file using tic

# Checking for apps needed by this script
for APP in curl mktemp tic; do
	if ! command -v "$APP" >/dev/null 2>&1; then
		echo "command $APP not found"
		exit 1
	fi
done

# Create terminfo dir in home directory if it doesn't exist
mkdir -p "$HOME"/.terminfo

# Downloading terminfo file for wezterm and compiling it
tempfile=$(mktemp) &&
	curl -o "$tempfile" https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo &&
	tic -x -o ~/.terminfo "$tempfile" &&
	rm "$tempfile"

echo "#####################################################"
echo "Done installing wezterm terminfo file to /.terminfo"
echo "You can now use the wezterm terminfo. Examples below"
echo
echo "export TERM='wezterm'"
echo "alias nv='env TERM=wezterm nvim'"
echo "#####################################################"
