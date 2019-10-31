% s = 4;  % Distance from origin to screen
% d = 8;  % Distance from screen to camera
s = 4;
d = 8;

E = [0, 10, s+d];
T = [0, 0, 0];


load('wireframe.mat');
p = cube;
p = [p; -2 -2 -2; 2 2 2];

[x, y] = project_to_plane(p, d, E, T);
draw_screen(x, y);