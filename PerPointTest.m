s = 4;  % Distance from origin to screen
d = 8;  % Distance from screen to camera

E = [0, 0, s+d];
T = [0, 0, 0];

load('wireframe.mat');
p = cube;

[x, y] = project_and_plot(p, d, E);
draw_screen(x, y);