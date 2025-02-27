function [P, O] = DirectKinematics(q0, q1, q2)
%{
ova funkcija računa poziciju i orijentaciju alata na temelju kutova q0, q1, q2
q0 - kut motora baze
q1 - kut motora između baze i ruke
q2 - kut motora koji rotira olovku
kutovi se unose u STUPNJEVIMA odsad 
q1 = [-180, 180]
q2 = [-180, 180]
%}

%q0 = 0
%q1 = 0
%q2 = 0

%pretvorba stunjeva u radijane
q0 = q0/180*pi;
q1 = q1/180*pi;
q2 = q2/180*pi;

%provjera unesenih vrijednosti

%namjestiti duljine dijelova robota
d0 = 88;
d1 = 160;
d2 = 197;

C0 = cos(q0);
S0 = sin(q0);
C1 = cos(q1);
S1 = sin(q1);
C2 = cos(q2);
S2 = sin(q2);

%racunanje vektora pozicije i orijentacije alata
%P = [C1*S0*d1 - C1*C2*S0*d2 - S0*S1*S2*d2, C0*C1*d1 + C0*C1*C2*d2 + C0*S1*S2*d2, d0 - S1*d1 - C1*S2*d2 + C2*S1*d2]
P = [S0*S1*S2*d2 - C1*C2*S0*d2 - C1*S0*d1, C0*C1*d1 + C0*C1*C2*d2 - C0*S1*S2*d2, d0 - S1*d1 - C1*S2*d2 - C2*S1*d2];
O = [S0*S1*S2 - C1*C2*S0, -(C0*C1*C2 - C0*S1*S2), - C1*S2 - C2*S1];
 
 
 

