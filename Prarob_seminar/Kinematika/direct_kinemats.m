%{
ova skripta računa poziciju i orijentaciju alata na temelju kutova q0, q1, q2
q1 - kut motora baze
q2 - kut motora između baze i ruke
q3 - kut motora koji rotira olovku
%}

q0 = 0
q1 = pi/4
q2 = pi/4
d0 = 10
d1 = 10
d2 = 10


C0 = cos(q0);
S0 = sin(q0);
C1 = cos(q1);
S1 = sin(q1);
C2 = cos(q2);
S2 = sin(q2);

%racunanje vektora pozicije i orijentacije alata

P = [S0*S1*S2*d2 - C1*C2*S0*d2 - C1*S0*d1, C0*C1*d1 + C0*C1*C2*d2 - C0*S1*S2*d2, d0 - S1*d1 - C1*S2*d2 - C2*S1*d2]
O = [S0*S1*S2 - C1*C2*S0, C0*C1*C2 - C0*S1*S2, - C1*S2 - C2*S1]
 
 
 


