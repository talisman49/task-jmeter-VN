#!/bin/bash
set -e

while getopts ":f:t:h:r:l:" opt; do
  case $opt in
    f) file="$OPTARG"
    ;;
    t) threads="$OPTARG"
    ;;
    h) host="$OPTARG"
    ;;
    r) rampup="$OPTARG"
    ;;
    l) loopcount="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ -z "$file" ]
then
   echo "Es necesario poner la url del fichero jmx."
   exit
fi

args=""

if [ "$host" ]
then
   args+=" -Jtest.host=$host" 
fi


if [ "$threads" ]
then
   args+=" -Jtest.threads=$threads" 
fi

if [ "$rampup" ]
then
   args+=" -Jtest.rampup=$rampup"
fi

if [ "$loopcount" ]
then
   args+=" -Jtest.loopcount=$loopcount"
fi

wget -O jmeter.jmx $file

eval "jmeter -n -t jmeter.jmx $args"