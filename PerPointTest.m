% s = 4;  % Distance from origin to screen
% d = 8;  % Distance from screen to camera
s = 2;
d = 5;

E = [s+d, 0, 0];
T = [0, 0, 0];

load('wireframe.mat');
p = cube;
p = [p; -2 -2 -2; 2 2 2];

[x, y] = project_to_plane(p, d, E, T);
draw_screen(x, y);