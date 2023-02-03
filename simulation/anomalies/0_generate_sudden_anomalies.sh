#!/bin/bash
for (( i=0; i<=30; i++ ))
do  
    python3 anomaly_generator.py sudden 100 130 2 -i "$i"
done