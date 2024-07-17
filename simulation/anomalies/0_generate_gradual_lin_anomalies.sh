#!/bin/bash
for x in {0..30};
do
    y=`bc <<< "scale=1; $x/10"`
    python3 anomaly_generator.py gradual 100 150 2 -t lin -a "$y" -b 0 -f 120
done
