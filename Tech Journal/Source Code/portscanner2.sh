#!/bin/bash

ports=$2
echo "host,port"
for i in $(seq 0 255); do
        hosts=$1.$i
        for host in $hosts; do
                for port in $ports; do
                        timeout .1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null &&
                                echo "$host,$port"
                done
        done
done
