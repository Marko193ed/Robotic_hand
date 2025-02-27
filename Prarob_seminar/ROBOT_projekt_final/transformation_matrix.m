syms C0 S0 C1 C2 S0 S1 S2 d0 d1 d2;

T23 = [[C2  0  S2  d2*S2],
      [ S2  0 -C2  -d2*C2],
       [0   1  0   0],
       [0   0  0   1]];
T12 =[[-C1  S1 0   -d1*S1],
      [-S1 -C1 0   d1*C1],
       [0   0  1   0],
       [0   0  0   1]];
T01 =[[ 0  -S0  C0 0],
       [0   C0  S0 0],
      [ 1   0   0  d0],
       [0   0  0   1]];
T = T01*T12*T23
save('data.mat', "T")

%q0 = atan2(w4, -w5)
%q1+q2 = 1/2 * arcsin(1-2w1^2-2w2^2)
%P = [C1*S0*d1 - C1*C2*S0*d2 - S0*S1*S2*d2, C0*C1*d1 + C0*C1*C2*d2 + C0*S1*S2*d2, d0 - S1*d1 - C1*S2*d2 + C2*S1*d2]

