#!/bin/bash

readonly LOG_FNAME=bot.log
readonly LOG_DATEFMT="+%d-%m-%y %H:%M:%S.%N"

log() {
    # Argument to pass:
    # $1 - log type, ex. -d / --debug
    # $2 - tag name (script/function name recommended)
    # $3 - Texts

    local arg=$1
    local logtag=$2
    local logtype
    shift

    case $arg in
        -v|--verbose) logtype=V ;;
        -d|--debug) logtype=D ;;
        -i|--info) logtype=I ;;
        -w|--warn) logtype=W ;;
        -e|--error) logtype=E ;;
        -f|--fatal) logtype=F ;;
    esac

    echo "$logtype: [$(date "$LOG_DATEFMT" | sed 's/......$//')] ($logtag) $*" | tee -a "$LOG_FNAME"
}
