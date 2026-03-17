%% BlueBoat USV State-Space Model
% State vector: x = [x, y, psi, u, v, r]'
% x, y: Position in NED frame [m]
% psi: Heading angle [rad]
% u: Surge velocity [m/s]
% v: Sway velocity [m/s]
% r: Yaw rate [rad/s]

% Physical Parameters
m = 25;           % Mass [kg]
Iz = 5;           % Yaw moment of inertia [kg*m^2]
L = 1.2;          % Length [m]
B = 0.6;          % Beam width [m]

% Hydrodynamic Coefficients (linearized)
Xu = -5;          % Surge damping [N*s/m]
Yv = -20;         % Sway damping [N*s/m]
Nr = -2;          % Yaw damping [N*m*s/rad]

% Added Mass
Xu_dot = -2;      % Surge added mass [kg]
Yv_dot = -10;     % Sway added mass [kg]
Nr_dot = -1;      % Yaw added mass [kg*m^2]

% Effective mass/inertia
m_u = m - Xu_dot;
m_v = m - Yv_dot;
Iz_r = Iz - Nr_dot;

% Linearized State-Space Matrices (at constant velocity U0)
U0 = 1.0;  % Nominal surge velocity [m/s]

% A matrix (6x6) - System dynamics
A = [0, 0, -U0, 1, 0, 0;
     0, 0,  U0, 0, 1, 0;
     0, 0,   0, 0, 0, 1;
     0, 0,   0, Xu/m_u, 0, 0;
     0, 0,   0, 0, Yv/m_v, 0;
     0, 0,   0, 0, 0, Nr/Iz_r];

% B matrix (6x2) - Input mapping
B = [0, 0;
     0, 0;
     0, 0;
     1/m_u, 0;
     0, 0;
     0, 1/Iz_r];

% C matrix (6x6) - Full state output
C = eye(6);

% D matrix (6x2) - No direct feedthrough
D = zeros(6, 2);

% Create state-space system
sys = ss(A, B, C, D);
sys.StateName = {'x', 'y', 'psi', 'u', 'v', 'r'};
sys.InputName = {'tau_u', 'tau_r'};
sys.OutputName = {'x', 'y', 'psi', 'u', 'v', 'r'};