function [q0, q1, q2] = InverseKinematics(P)
%{
ova skripta računa q1, q2, q3 na temelju pozicije vrha alata P(x, y, z)
q1 - kut motora baze
q2 - kut motora između baze i ruke
q3 - kut motora koji rotira olovku
svi kutovi se vrte oko Z-ite osi
sve je nacrtano na slici
%}

%dužina članova
%upisati stvarne vrijednosti
d0 = 88;
d1 = 160;
d2 = 197;

%direct kinematics

%pozicija vrha olovke
w1 = P(1);
w2 = P(2);
w3 = P(3);
 

%alternativno vektor pozicije se prethodno može izračunati iz direktne
%kinematike
%w1 = P(1)
%w2 = P(2)
%w3 = P(3)


%orijentacija vrha olovke
%w4 = O(1);
%w5 = O(2);
%w6 = O(3);
%alternativno vektor orijentacije se prethodno može izračunati iz direktne
%kinematike
%w4 = O(1)
%w5 = O(2)
%w6 = O(3)

%rješenje inverzne kinematike staro
%q0 = atan2(w4, -w5)
%q1 = asin(1/d1 * (d0 - w3 + d2*w6))
%q2 = -asin(w6) - q1

%rješenje inverzne kinematike 2
q0r = atan2(-w1, w2);
p = sqrt(w1^2+w2^2+(d0-w3)^2);
q2r = acos((p^2 - d1^2-d2^2)/(2*d1*d2));
ac = acos((p^2+d1^2 - d2^2)/(2*p*d1));
as = asin((d0-w3)/(sqrt((d0-w3)^2+w1^2+w2^2)));
q1r = as-ac;

%provjera ispravnosti
if imag(q0r) ~= 0 || imag(q1r) ~= 0 || imag(q2r) ~= 0
    msg = "Koordinate su izvan dosega ruke!!!";
    error(msg);
end

%pretvorva radijana u stupnjeve
q0 = q0r*180/pi;
q1 = q1r*180/pi;
q2 = q2r*180/pi;