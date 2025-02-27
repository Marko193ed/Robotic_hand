function automatski_rad(world_complete_path)

for i=1:(size(world_complete_path,1))
    zadnji=size(world_complete_path,1);
    %previous_location=()
    P=[(world_complete_path(i,1)-10),world_complete_path(i,2),0];
    final_location=[world_complete_path(zadnji,1),world_complete_path(zadnji,2),0];
    [q0, q1, q2]=InverseKinematics(P);
   
    % value = app.MOTOR2Slider.Value;
    set_param('simulation_three_motors/Motor3','Value', mat2str(q0));
    set_param('simulation_three_motors/Motor2','Value', mat2str(q1));
    set_param('simulation_three_motors/Motor1','Value', mat2str(q2));
    pause(4);
    
 %{if (i>1 & ~isequal(P,last_location))
        %while ~isReached()

    
    %}
%{
  {while ~(cond)
    cond=isReached(p goalState, newState)
    threshold = 1; % Možete prilagoditi prag
    isReached = norm(newState(1:2) - goalState(1:2)) < threshold;
    end);
%}
end
end
