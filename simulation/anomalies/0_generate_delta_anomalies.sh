#!/bin/bash
for (( i=0; i<=30; i++ ))
do  
    python3 anomaly_generator.py delta 100 150 2 -i "$i"
done
