#!/bin/bash
round() {
    # $1 = Your number
    # $2 = Amount of decimal places
    FLOAT=$1
    DECIMAL_POINT=$2
    printf "%.${2:-$DECIMAL_POINT}f" "$FLOAT"
}
