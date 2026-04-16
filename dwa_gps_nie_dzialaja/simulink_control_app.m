% MATLAB controller for Webots
% File:          simulink_control.m
% Date: 
% Description:
% Author:
% Modifications:

% uncomment the next two lines if you want to use
% MATLAB's desktop to interact with the controller:
%desktop;
%keyboard;

waypoints;

TIME_STEP = 16;
alpha_pitch=0.85;
alpha_roll=0.85;
alpha_yaw=0.85;

accelerometer_sensor=wb_robot_get_device('accelerometer');
wb_accelerometer_enable(accelerometer_sensor,TIME_STEP);

gyro_sensor=wb_robot_get_device('gyro');
wb_gyro_enable(gyro_sensor,TIME_STEP);

% Uruchomienie kompasu GPS
gps_front = wb_robot_get_device('gps_front');
wb_gps_enable(gps_front, TIME_STEP);

gps_rear = wb_robot_get_device('gps_rear');
wb_gps_enable(gps_rear, TIME_STEP);


left_IR = wb_robot_get_device('left_ir');
right_IR = wb_robot_get_device('right_ir');

% wb_distance_sensor_enable("left_ir", sampling_period)

wb_distance_sensor_enable(left_IR,TIME_STEP);
wb_distance_sensor_enable(right_IR,TIME_STEP);
 
camera=wb_robot_get_device('camera');
wb_camera_enable(camera, TIME_STEP);

radar = wb_robot_get_device('radar');
wb_radar_enable(radar, TIME_STEP);

inertial_unit=wb_robot_get_device('inertial_unit');
wb_inertial_unit_enable(inertial_unit,TIME_STEP)

left_trushter_motor = wb_robot_get_device('left_motor');

right_trushter_motor = wb_robot_get_device('right_motor');


assignin('base', 'left_motor', left_trushter_motor);
assignin('base', 'right_motor', right_trushter_motor);
assignin('base', 'accel_sensor', accelerometer_sensor);

open_system('simulink_control');
load_system('simulink_control');

parameters;
wb_robot_step(TIME_STEP);
set_param('simulink_control', 'SimulationCommand', 'start');