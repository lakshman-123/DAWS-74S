#!/bin/bash
var1=$1
var2=$2
validate() {
    echo "$1 is $2"
}



validate "var1" $var1
validate "no.of vars" $#
validate "script name" $0
validate "all vars" $@
#echo "all vars $@"


