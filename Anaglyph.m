% Teapot model van https://people.sc.fsu.edu/~jburkardt/data/obj/obj.html
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

%% Generate left eye
[x, y] = project_to_plane(p, d, E-[2,0,0], T);
draw_screen(x, y, 'red');
hold on;

%% Generate right eye
[x, y] = project_to_plane(p, d, E+[2,0,0], T);
draw_screen(x, y, 'cyan');

%%
hold off;