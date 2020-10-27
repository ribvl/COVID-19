// SIRD model applied to Covid-19
// Reference: Fanelli and Piazza 2020
// https://www.researchgate.net/publication/339887331

clear; clc;

//// Rates (parameters fitted for Italy)
//r = 1.46e-5; // infection rate (day^-1)
//a = 2.13e-2; // recovery rate
//d = 1.45e-2; // death rate
//S0 = 2.303e4;  // number of initially susceptible individuals
//I0 = 3; // // number of initially infected individuals
//t0 = 20; // initial time (days)
//tf = 200; // final time (days)

// Rates (parameters fitted for China)
r = 3.95e-6; // infection rate (day^-1)
a = 3.53e-2; // recovery rate
d = 3.1e-3; // death rate
S0 = 8.33e4;  // number of initially susceptible individuals
I0 = 3; // // number of initially infected individuals
t0 = 1; // initial time (days)
tf = 200; // final time (days)


// ODE system:

function dydt = f(t,y)
    S = y(1); I=y(2); R=y(3); D=y(4);
    dydt = [-r*S*I;
         r*S*I-(a+d)*I;
         a*I;
         d*I]
endfunction

// Solving the ODE system:

t = [t0:tf]

y0=[S0;I0;0;0];
    
y = ode(y0,t0,t,f)
    
S = y(1,:)'; I=y(2,:)'; R=y(3,:)'; D=y(4,:)';
    
plot2d(t,[S,I,R,D],style=[6;5;2;1]);
legend("S","I","R","D")



 

