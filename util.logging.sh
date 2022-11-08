#!/bin/bash

readonly LOG_FNAME=bot.log
readonly LOG_DATEFMT="+%d-%m-%y %H:%M:%S.%N"

log::getLogType() {
    case $1 in
        -v|--verbose|verbose) echo V ;;
        -d|--debug|debug) echo D ;;
        -i|--info|info) echo I ;;
        -w|--warn|warn) echo W ;;
        -e|--error|error) echo E ;;
        -f|--fatal|fatal) echo F ;;
        *) return 1 ;;
    esac
}

log() {
    # Argument to pass:
    # $1 - log type, ex. -d / --debug
    # $2 - tag name (script/function name recommended)
    # $3 - Texts

    # Warn if called with incorrect amount of argument passed
    if [ "$#" -ne 3 ]; then
        log -w log "Logger was called with incorrect amount of args:"
        log -w log "arg1: $1"
        log -w log "arg2: $2"
        log -w log "arg3: $3"
        #return 1
    fi

    local arg=$1
    local logtag=$2
    local logtype
    shift 2

    echo "$(log::getLogType $arg): [$(date "$LOG_DATEFMT" | sed 's/......$//')] ($logtag) $*" | tee -a "$LOG_FNAME"
}
