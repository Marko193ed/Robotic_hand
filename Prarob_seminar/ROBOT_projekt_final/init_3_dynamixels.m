Ts = 0.1;
Port = 'COM3'
addpath('dynamixel')
run dynamixel/init_3_dynamixels_vel_control_script
assignin("base", "Ts", Ts)