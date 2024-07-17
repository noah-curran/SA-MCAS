This is the repository for the code and experiments for SA-MCAS, which appears in
the ACM SIGBED International Conference on Embedded Software 2024.

We analyze the safety of the new and old MCAS systems of the Boeing 737-MAX in
simulation (using JSBSim), and propose a new system that combines the strengths
of both of the prior systems.

The experiments can be found in the `simulation` directory. We use MATLAB Simulink
r2022b, and have run the code on MacOS X, Windows 10, and Ubuntu 22.04. You may need
to [build the JSBSim Simulink S-Function](https://github.com/JSBSim-Team/jsbsim/blob/master/matlab/README.md)
for your specific machine if you run into issues. The different S-Functions we used
for our machines are found in the `simulation` directory. The framework for
testing the different MCAS controllers are found in the Simulink model.

If you use this work, please cite it:
```text
@inproceedings{curran24emsoft,
  author       = {Noah T. Curran and Thomas Kennings and Kang G. Shin},
  title        = {{Analysis and Prevention of MCAS-Induced Crashes}},
  booktitle    = {Proceedings of the ACM SIGBED International Conference on Embedded Software 2024 (EMSOFT '24)},
  year         = {2024},
  month        = {October},
  pages        = {??? -- ???},
  publisher    = {IEEE},
}
```f