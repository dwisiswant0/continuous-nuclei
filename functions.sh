#!/bin/bash

function parseArgs() {
	USAGE="\n\nUsage:\n  run [-target/-l] [domain.tld/urls.txt]"
	[[ -z "${1}" ]] && { echo -e "Please define -target/-l flag! ${USAGE}"; exit; }
	[[ -z "${2}" ]] && { echo -e "No target! ${USAGE}"; exit; }
}

function getHead() {
	local CURRENT=$(git log --oneline | head -1 | awk '{print $1}')
	echo "${CURRENT}"
}

function isUpdated() {
	local CHECK=$(git status -uno 2>/dev/null)

	if [[ "${CHECK}" =~ "up-to-date" ]]; then
		echo "Nothing to run!"
		exit
	fi
}

function getChanges() {
	local CHANGES=$(git diff ${1} --name-only | grep -v ".(git|md|pre-commit-config|nuclei-ignore)")
	echo "${CHANGES}"
}