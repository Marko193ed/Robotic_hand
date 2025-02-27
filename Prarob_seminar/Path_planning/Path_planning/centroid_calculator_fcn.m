function [output]= centroid_calculator_fcn(image)
%calculate the centroid of object
m_00 = calculate_moment(image, [0 0]);
m_10 = calculate_moment(image, [1 0]);
m_01 = calculate_moment(image, [0 1]);
polje=[];
bin_image=imbinarize(image);
height=size(image,1);
% calculate area and centroid
 A = m_00;
 x_c = m_10/A;
 y_c =height-m_01/A;%pripazi, zbog ovog ćeš u world_coordinate_kalkulatoru morat prilagodit y piksele
polje=[x_c,y_c];
output=polje;
end