#!/bin/bash
for (( i=1; i<=9; i++ ))
do  
    python3 anomaly_generator.py sudden 100 130 2 -i "15.$i"
done