#!/bin/bash
#
# Checks that all base programs exist

./install-profile.sh clean
./install-profile.sh all

function check_dep() {
	command -v $1 >/dev/null 2>&1 || { echo >&2 "Test Failed! $1 not found. $2"; exit 1; }
}


check_dep zsh
check_dep abduco
check_dep nvim
check_dep nvr

echo "Tests passed! All programs found!"
