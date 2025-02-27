function isReached = isReached(currentState, newState)
    threshold = 15; % Možete prilagoditi prag
    isReached = norm(newState(1:2) - currentState(1:2)) < threshold;
end