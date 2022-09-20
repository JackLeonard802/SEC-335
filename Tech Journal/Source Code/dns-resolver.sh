#!/bin/bash

server=$2
echo "dns reslolution for 10.0.5"
for i in $(seq 0 255); do
        hosts=$1.$i
        for host in $hosts; do
                nslookup $hosts $server | grep "="
        done
done
