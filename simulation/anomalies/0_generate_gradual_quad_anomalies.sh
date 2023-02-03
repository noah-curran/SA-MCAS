#!/bin/bash
for (( i=0; i<=10; i++ ))
do
    for (( j=0; j <=30; j++ ))
    do
        id=`bc <<< "scale=1; $i/10"`
        jd=`bc <<< "scale=1; $j/10"`
        python3 anomaly_generator.py gradual 100 130 2 -t quad -a "$id" -b "$jd" -f 120
    done
done