#!/bin/bash
for x in {100..200};
do
    # y=`bc <<< "scale=1; $x/10"`
    python3 anomaly_generator.py gradual 100 130 2 -t log -a "$x" -b 0 -f 120
done