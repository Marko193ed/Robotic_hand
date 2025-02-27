%učitajmo cameraParams i T_world_camera
load("matrix.mat");
load("cameraParams.mat");

niz_zaobidi=["traffic light"];
niz_spoji=["car","stop sign","clock"];
%kalkuliraj centroide točaka koje spajamo
dots_to_connect=racunanje_centroida_zadanih_objekata(niz_spoji,masks);
start_location=[dots_to_connect(1,:),0];

%napravi masku po kojoj radimo putanju
img=img_objects_to_avoid(niz_zaobidi,masks);
se=strel("square",40);
img=imdilate(img,se);
bwImg=imbinarize(img);
map=binaryOccupancyMap(bwImg);
figure;show(map);

% Definirajte state space za 2D planiranje
bounds = [map.XWorldLimits; map.YWorldLimits; [-pi pi]];
stateSpace = stateSpaceSE2(bounds);

% Kreirajte validator stanja koristeći mapu zauzetosti
stateValidator = validatorOccupancyMap(stateSpace, 'Map', map);

%inicijalizacija polja sa kompletnim putem
complete_path=[];
% Kreirajte RRT* planer
planner = plannerRRTStar(stateSpace, stateValidator);
planner.MaxIterations = 4000;
planner.MaxConnectionDistance = 30;
planner.GoalReachedFcn = @exampleHelperIsGoalReached;

% Početna točka za planiranje
current_location = start_location;

% Prikazivanje mape i inicijalizacija grafike
figure;
show(map);
hold on;

% Iterativno planiranje puta između svake dvije uzastopne točke
for i = 2:size(dots_to_connect, 1)
    next_location = [dots_to_connect(i, :), 0]; % Dodajte theta
    [pthObj, solnInfo] = plan(planner, current_location, next_location);
    % Prikažite RRT* stablo
    plot(solnInfo.TreeData(:,1), solnInfo.TreeData(:,2), '.-'); % RRT stablo

    % Provjerite je li putanja validna i prikažite je
    if ~isempty(pthObj.States)
        plot(pthObj.States(:,1), pthObj.States(:,2), 'r-', 'LineWidth', 2); % Planirana putanja
        %dodaj ove putanje u kompletnu putanju
        complete_path=[complete_path;pthObj.States];
    else
        disp('Putanja nije pronađena između točaka.');
    end

    % Ažuriraj trenutnu lokaciju
    current_location = next_location;
end
height=size(img,1);
world_complete_path=world_path_calculator(complete_path,cameraParams,T_world_camera,height);%nedostaje T_world_camera
world_complete_path2=points_to_world_path_calculator(complete_path,cameraParams,height,R,t);
title('RRT* Path Connecting Multiple Points');
hold off;

% Pomoćna funkcija za provjeru postizanja cilja
function isReached = exampleHelperIsGoalReached(planner, goalState, newState)
    threshold = 1; % Možete prilagoditi prag
    isReached = norm(newState(1:2) - goalState(1:2)) < threshold;
end
