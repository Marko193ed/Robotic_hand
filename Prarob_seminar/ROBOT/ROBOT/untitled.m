%{
% Ekstrakcija x i y koordinata (prva dva stupca)
coordinates=world_complete_path;
x = coordinates(:, 1);
y = coordinates(:, 2);

% Plotanje x i y koordinata
plot(x, y, 'o-'); % 'o-' će koristiti krugove za točke i crtu za povezivanje
xlabel('X koordinata');
ylabel('Y koordinata');
title('Grafikon X i Y koordinata');
grid on; % Opcionalno, dodaje mrežu na grafikon
%}
%q0=-34.193108 q1=-40.199177 q2=116.348085
P = [95.183501, 140.094517,0.000000]
InverseKinematics(P)
DirectKinematics(-34.193108, 40.199177, 116.348085)