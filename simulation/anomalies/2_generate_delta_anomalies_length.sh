#!/bin/bash
for (( i=10; i<=80; i++ ))
do  
    python3 anomaly_generator.py delta 100 1"$i" 2 -i 18
done