% --- CZYSTY LAUNCHER ---
% 1. Ustaw ścieżki (tylko to jest potrzebne)
WEBOTS_HOME = 'C:\Program Files\Webots';
lib_dir = fullfile(WEBOTS_HOME, 'lib', 'controller');
bin_dir = fullfile(WEBOTS_HOME, 'msys64', 'mingw64', 'bin');
setenv('PATH', [lib_dir ';' bin_dir ';' getenv('PATH')]);
addpath(fullfile(WEBOTS_HOME, 'lib', 'controller', 'matlab'));

% 2. Otwórz model (bez inicjalizacji robota tutaj!)
model_name = 'simulink_control'; 
load_system(model_name);
open_system(model_name);

% 3. Uruchom - teraz to BLOK w Simulinku połączy się z Webotsem
set_param(model_name, 'SimulationCommand', 'start');