#!/bin/bash
var1=$1
var2=$2

validate() {
    echo "$1 is $2"
}

validate "var1" $var1
validate  "all vars" "$@"
validate  "no.of vars" $#


