% Parasitic drag depends on the altitude of the airplane and the Mach.
% The chosen value is typical for a B737-800.
% Page 8 of https://ntrs.nasa.gov/api/citations/20110023431/downloads/20110023431.pdf
C_D0 = 0.024;

% The Oswald efficiency factor obtained from Table 4 of:
% https://www.sciencedirect.com/science/article/pii/S0968090X19307764
e = 0.775;

% The following values are from:
% http://www.b737.org.uk/techspecsdetailed.htm
AR = 9.45;
AR_t = 6.16;
S = 1340.968; %ft^2
S_t = 352.84; %ft^2
S_e = 70.5; %ft^2
c_bar = 12.99213; %ft

% Some state variables for the calculations.
W = 181197.9; %initialized (weight of aircraft), lbs
% ^ maybe also from the sensors?
rho = 0; %from sensor (air density), slug/ft^3
u_0 = 0; %from sensor (initial forward speed), ft/s
V = 0; %from sensor (true airspeed), ft/s
g = 32.2; %(gravity), ft/s^2
m = W/g;
Q = 0.5*rho*u_0^2;

% The tail efficiency factor is assumed to be 1.
% From Chapter 3 of Nelson, R. C. (1997). Flight stability & automatic
% control.
eta = 1;

% The general lift curve slope equation from Chapter 9 of General Aviation
% Aircraft Design: Applied Methods and Procedures.
C_Lalpha = (2*pi*AR) / (2 + sqrt(AR^2 + 4));
C_Lalpha_t = (2*pi*AR_t) / (2 + sqrt(AR_t^2 + 4));

% Because we are considering low-speed, i.e., Mach < 1:
C_Du = 0;

% For gliding flight, C_Tu = 0; for variable pitch propeller and piston
% engine, C_Tu = -C_D0 as an approximation.
C_Tu = -C_D0;

% See here: https://www.grc.nasa.gov/WWW/k-12/airplane/Images/vecthrst.gif
% See here: https://www.grc.nasa.gov/www/k-12/airplane/Images/climb.gif
% For lift, there are a few types. This depends on thrust and climb.
% (1) There is climb:
%    (i)  There is thrust.
%         T*sin(c) - D*sin(c) + L*cos(c) - W = m*a_v
%    (ii) There is T = D.
%         L*cos(c) - W = m*a_v
% (2) There is no climb:
%    (i)  There is thrust.
%         T - D + L - W = m*a_v
%    (ii) There is T = D.
%         L - W = m*a_v
%
% This can easily be generalized to (1.i) and then everything else will
% simplify if necessary.
%
% Here, let's first assume there is no climb and steady thrust.
a_v = 0; %assume for now... could get from sensors.
T = 0; %assume for now... could get from sensors.
D = 0; %assume for now... could get from sensors.
c = 0; %from sensor (climb angle)
F_v = m*a_v;
L = (F_v - T*sin(c) + D*sin(c) + W) / (cos(c));

% We can rearrage the simple lift equation that includes the lift
% coefficient to calculate the lift coefficient.
C_L = (2*L) / (rho*V^2*S);

% TODO: How to calculate this?
C_Malpha_fus = 0;

% TODO: How to calculate these?
% I think this can be obtained from sensors.
x_cg = 0; % distance from wing's leading edge to center of gravity
x_ac = 0; % distance from wing's leading edge to aerodynamic center

% TODO: Explain calculating l_t (relies on Center of gravity).
% Because we can get the center of gravity sensor reading, we can calculate
% this on the fly...
l_t = 70.685;

% Use S_e/S_t and Figure 2.21 from Chapter 2 of Nelson, R. C. (1997). Flight
% stability & automatic control.
% S_e/S_t = 0.1998 ==> tau is approximately 0.41
tau = 0.41;

% Below are formula from Chapter 3 of Nelson, R. C. (1997). Flight
% stability & automatic control.
V_H = (l_t * S_t) / (S * c_bar);
despilon_dalpha = (2 * C_Lalpha) / (pi * AR);

% Calculate the stability coefficients.
C_Xu = -(C_Du + 2*C_D0) + C_Tu;
C_Xalpha = C_L*(1 - (2*C_Lalpha) / (pi*e*AR));
C_Zu = -2*C_L; % Simplified because of Mach < 1. C_Zu = -(M2 / 1-M2)CL0 - 2CL0.
C_Zalpha = -(C_Lalpha + C_D0);
C_Mu = 0; % Mach < 1.
C_Malpha = C_Lalpha * (x_cg-x_ac) / c_bar + C_Malpha_fus - eta*V_H*C_Lalpha_t*(1 - despilon_dalpha);
C_Malpha_dot = -2*C_Lalpha_t*eta*V_H*despilon_dalpha*l_t/c_bar;
C_Mq = -2*C_Lalpha_t*eta*V_H*l_t/c_bar;

C_Xdelta_e = 0;
C_Zdelta_e = -C_Lalpha_t*tau*eta*(S_t/S);
C_Mdelta_e = C_Zdelta_e*(l_t / c_bar);

% A tip: https://www.eng-tips.com/viewthread.cfm?qid=88770
% https://shop.darcorp.com/index.php?route=product/product&path=85_60&product_id=55
% Page 17 explains how to do this. This can be done better, but for now
% let's trust this. We are basing this off of the Boeing 727-100 radii of
% gyration, which is found on page 201 of this same book. The rest of the
% values are from Boeing 737-800 specifications.
% Mass moment of inertia about the y axis.
R_bar_y_TO = 0.375;
R_bar_y_E = 0.4066;
l = 129.5932; %ft, length
W_TO_max = 174200;
W_E_max = 138300;

% This is around 3.2e6, and the estimate is 3.1e6, so it is pretty close.
I_y_TO = (R_bar_y_TO * l / 2)^2 * W_TO_max / g; %slug-ft^2
I_y_E = (R_bar_y_E * l / 2)^2 * W_E_max / g; %slug-ft^2

% Calculate the dimensional derivatives.
X_u = C_Xu * (Q*S)/(m*u_0);
X_a = C_Xalpha * (Q*S)/m;
Z_u = C_Zu * (Q*S)/(m*u_0);
Z_a = C_Zalpha * (Q*S)/m;
M_u = C_Mu * (Q*S*c_bar)/(I_y*u_0);
M_adot = C_Malpha_dot * (c_bar^2*Q*S)/(2*I_y*u_0);
M_a = C_Malpha * (Q*S*c_bar)/I_u;
M_q = C_Mq * (c_bar^2*Q*S)/(2*I_y*u_0);

X_delta_e = 0;
Z_delta_e = C_Zdelta_e * (Q*S)/m;
M_delta_e = C_Mdelta_e * (Q*S*c_bar)/I_y;

A = [
        X_u             X_a             0               -g*cos(Theta_0);
        Z_u             Z_a             u_0             -g*sin(Theta_0);
        M_u+M_adot*Z_u  M_a+M_adot*Z_a  M_q+u_0*M_adot  -M_adot*g*sin(Theta_0);
        0               0               1               0;
    ];


B = [
        X_delta_e;
        Z_delta_e;
        M_delta_e+M_adot*Z_delta_e;
        0;
    ];


%%%%%%%%
% Everything below here is simply some input we can use for now.
% The links where the code is obtained is provided below.
% This will not be included in the final version, but will
% be included until the above data is finalized.
%%%%%%%%

% https://ctms.engin.umich.edu/CTMS/index.php?example=AircraftPitch&section=SystemModeling

s = tf('s');
P_pitch = (1.151*s+0.1774)/(s^3+0.739*s^2+0.921*s);

A = [-0.313 56.7 0; -0.0139 -0.426 0; 0 56.7 0];
B = [0.232; 0.0203; 0];
C = [0 0 1];
D = [0];
pitch_ss = ss(A,B,C,D);

% https://ctms.engin.umich.edu/CTMS/index.php?example=AircraftPitch&section=ControlStateSpace
K = [-0.6435 169.6950 7.0711];

% https://ctms.engin.umich.edu/CTMS/index.php?example=AircraftPitch&section=ControlStateSpace
Nbar = 7.0711;