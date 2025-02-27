%{
ova skripta računa q1, q2, q3 na temelju pozicije vrha alata i njegove
orijentacije
q1 - kut motora baze
q2 - kut motora između baze i ruke
q3 - kut motora koji rotira olovku
svi kutovi se vrte oko Z-ite osi
sve je nacrtano na slici
%}

%dužina članova
%upisati stvarne vrijednosti
d0 = 10 
d1 = 10
d2 = 10

%direct kinematics

%pozicija vrha olovke
w1 = ...
w2 = ...
w3 = ...

%alternativno vektor pozicije se prethodno može izračunati iz direktne
%kinematike
%w1 = P(1)
%w2 = P(2)
%w3 = P(3)


%orijentacija vrha olovke
w4 = ...
w5 = ...
w6 = ...
%alternativno vektor pozicije se prethodno može izračunati iz direktne
%kinematike
%w4 = O(1)
%w5 = O(2)
%w6 = O(3)

%rješenje inverzne kinematike
q0 = atan2(w4, -w5)
q1 = asin(1/d1 * (d0 - w3 + d2*w6))
q2 = -asin(w6) - q1