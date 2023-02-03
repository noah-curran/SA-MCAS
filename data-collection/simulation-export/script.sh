#!/bin/bash
for (( i=10; i<=80; i++ ))
do  
	mv delta_injection_duration_"$i"_recovery_enabled_grad.csv delta_injection_duration_"$i"_recovery_enabled_grad_0.csv
done

for (( i=0; i<=30; i++ ))
do  
	mv delta_injection_val_"$i"_recovery_enabled_grad.csv delta_injection_val_"$i"_recovery_enabled_grad_0.csv
done

for (( i=3; i<=30; i++ ))
do  
	mv delta_injection_delayed_recovery_"$i"_recovery_enabled_grad.csv delta_injection_delayed_recovery_"$i"_recovery_enabled_grad_0.csv
done

for (( i=10; i<=80; i++ ))
do  
        mv sudden_injection_duration_"$i"_recovery_enabled_grad.csv sudden_injection_duration_"$i"_recovery_enabled_grad_0.csv
done

for (( i=0; i<=30; i++ ))
do  
	mv sudden_injection_val_"$i"_recovery_enabled_grad.csv sudden_injection_val_"$i"_recovery_enabled_grad_0.csv
done

for (( i=3; i<=30; i++ ))
do  
	mv sudden_injection_delayed_recovery_"$i"_recovery_enabled_grad.csv sudden_injection_delayed_recovery_"$i"_recovery_enabled_grad_0.csv
done
