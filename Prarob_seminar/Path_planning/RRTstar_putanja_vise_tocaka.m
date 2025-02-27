
se = strel('square', 26);
%tu trebam dvije matrice tj dva niza, jedna sadrži objekte koje spajam, a
%druga objekte koje izbjegavam
img=img_objects_to_avoid(niz_zaobidi,masks);
bwImg = imbinarize(mwImg, 0.5);
map = binaryOccupancyMap(bwImg);
figure; show(map);

dots_to_connect=racunanje_centroida_zadanih_objekata(niz_spoji,masks);
%start_location = [200, 200, 0]; % Dodajte theta
dots_to_connect = [300, 400; 500, 600; 800, 900; 974,541; 1377, 552]; % Primjer točaka

% Definirajte state space za 2D planiranje
bounds = [map.XWorldLimits; map.YWorldLimits; [-pi pi]];
stateSpace = stateSpaceSE2(bounds);

% Kreirajte validator stanja koristeći mapu zauzetosti
stateValidator = validatorOccupancyMap(stateSpace, 'Map', map);

%inicijalizacija polja sa kompletnim putem
complete_path=[];
% Kreirajte RRT* planer
planner = plannerRRTStar(stateSpace, stateValidator);
planner.MaxIterations = 1000;
planner.MaxConnectionDistance = 200;
planner.GoalReachedFcn = @exampleHelperIsGoalReached;

% Početna točka za planiranje
current_location = start_location;

% Prikazivanje mape i inicijalizacija grafike
figure;
show(map);
hold on;

% Iterativno planiranje puta između svake dvije uzastopne točke
for i = 1:size(dots_to_connect, 1)
    next_location = [dots_to_connect(i, :), 0]; % Dodajte theta
    [pthObj, solnInfo] = plan(planner, current_location, next_location);
    ukupan_broj_nodeova=ukupan_broj_nodeova+size(pthObj.States,1);
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

title('RRT* Path Connecting Multiple Points');
hold off;

% Pomoćna funkcija za provjeru postizanja cilja
function isReached = exampleHelperIsGoalReached(planner, goalState, newState)
    threshold = 1; % Možete prilagoditi prag
    isReached = norm(newState(1:2) - goalState(1:2)) < threshold;
end
