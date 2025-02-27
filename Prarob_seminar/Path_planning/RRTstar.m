%se = strel('square', 20);
%mwImg = imdilate(masks(6).Mask, se);
%bwImg = imbinarize(mwImg, 0.5);
%map = binaryOccupancyMap(bwImg);
%figure; show(map);
centroid_calculator_fcn(img_red_object);
map=binaryOccupancyMap(img_red_object);
figure;show(map);
startLocation = [100,100 , 0]; % Dodajte theta
endLocation = [x_c+200, y_c, 0]; % Dodajte theta

% Definirajte state space za 2D planiranje
bounds=[map.XWorldLimits; map.YWorldLimits; [-pi pi]];
stateSpace = stateSpaceSE2(bounds);

% Kreirajte validator stanja koristeći mapu zauzetosti
stateValidator = validatorOccupancyMap(stateSpace, 'Map', map);

% Kreirajte RRT* planer
planner = plannerRRTStar(stateSpace, stateValidator);

planner.MaxIterations = 2000;
planner.MaxConnectionDistance = 100;
planner.GoalReachedFcn = @exampleHelperIsGoalReached;

% Planirajte putanju
[pthObj, solnInfo] = plan(planner, startLocation, endLocation);

% Prikažite rezultirajuću putanju
figure;
show(map);
hold on;
plot(solnInfo.TreeData(:,1), solnInfo.TreeData(:,2), '.-'); % RRT stablo

% Provjerite je li putanja validna i prikažite je
if ~isempty(pthObj.States)
    plot(pthObj.States(:,1), pthObj.States(:,2), 'r-', 'LineWidth', 2); % Planirana putanja
else
    disp('Putanja nije pronađena.');
end

title('RRT* Path');
hold off;

% Pomoćna funkcija za provjeru postizanja cilja
function isReached = exampleHelperIsGoalReached(planner, goalState, newState)
    threshold = 1; % Možete prilagoditi prag
    isReached = norm(newState(1:2) - goalState(1:2)) < threshold;
end
