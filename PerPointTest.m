% s = 4;  % Distance from origin to screen
% d = 8;  % Distance from screen to camera
s = 10;
d = 8;

E = [0, 0, s+d];
T = [0, 0, 0];


load('wireframe.mat');
p = cube;

p = objload('models/teapot.obj', 0.1);
hold on;

%% Generate plane
% Moet in eigen functie eigenlijk
px = 10;
py = min(p(:,2));
pp = [-10 py 10; 10 py 10; 10 py -10; -10 py -10];
[x, y] = project_to_plane(pp, d, E, T);
% TODO: Dit kan beter in draw functie
x = reshape(x, 4, []);
y = reshape(y, 4, []);
fill(x, y, [0.9 0.9 0.9]);

%% Generate obj
[x, y] = project_to_plane(p, d, E, T);
draw_screen(x, y);
hold on;