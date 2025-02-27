function [world_complete_path] = points_to_world_path_calculator(complete_path,cameraParams,height,R,t)
    %Ova funkcija preko koordinata u pikselima vraća koordinate putanja u
    %world frame-u
    %ovdje mi je potrebno navesti visinu slike u pixelima jer dok se u
    %slici, broj pixela povećava kako ideš dolje(jer je zapisano u
    %matrici), meni se na mapi broj pixela(tj visina od ishodišta) povećava
    %kako idem prema gore stoga sam morao raditi konverziju u
    %centroid_calculator_fcn te sad samo moram vratit natrag.
    %pixel_height=map_y_coordinate+pixel_y_coordinate
    
    world_complete_path=[];
    
    intrinsics=cameraParams.Intrinsics;

    %fx,fy,cx,cy izvlači iz matrice 
    %{
    z_pattern=560.1;
    fx=intrinsics.FocalLength(1);
    fy=intrinsics.FocalLength(2);
   cx = intrinsics.PrincipalPoint(1); 
   cy = intrinsics.PrincipalPoint(2);
    %}
    
    for i=1:length(complete_path)
        u=complete_path(i,1);
        v=height-complete_path(i,2);%sad smo vratili iz map_y_coordinate u pixel_y_coordinate
        %{
        x_camera=(z_pattern/fx)*(u-cx);
        y_camera=(z_pattern/fy)*(v-cy);
        z_camera=z_pattern;

        %pretvori u homogene koordinate
        centroid_camera_h=[x_camera;y_camera;z_camera;1];

        %izračunaj centroid u world koordinatama
        centroid_world_h=T_world_camera*centroid_camera_h;
        
        centroid_world = centroid_world_h(1:3,1);
        a=centroid_world';
        %}
        a=pointsToWorld(cameraParams.Intrinsics,R,t,[u v]);
        world_complete_path=[world_complete_path;a];
    end
    %save("world_path_complete.mat","world_complete_path");
    %load("world_path_complete.mat","world_complete_path");
end