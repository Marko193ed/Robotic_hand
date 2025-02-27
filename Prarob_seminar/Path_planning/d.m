for i=1:size(world_complete_path2,1)
    disp("točka : "+i);
    disp("razlika x koordinata: "+abs(world_complete_path2(i,1)-world_complete_path(i,1)));
    disp("razlika y koordinata: "+abs(world_complete_path2(i,2)-world_complete_path(i,1)));
end 