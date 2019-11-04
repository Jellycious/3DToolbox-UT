% s = 4;  % Distance from origin to screen
% d = 8;  % Distance from screen to camera
s = 10;
d = 8;

E = [0, 0, s+d];
T = [0, 0, 0];


load('wireframe.mat');
p = cube;

p = objload('models/teapot.obj', 0.1);

Cam = Camera(E, T, 8, 90);



%% Generate plane
% Moet in eigen functie eigenlijk
px = 10;
py = min(p(:,2));
pp = [-10 py 10; 10 py 10; 10 py -10; -10 py -10];
q = Cam.project(pp);
% TODO: Dit kan beter in draw functie
x = reshape(q(:, 1), 4, []);
y = reshape(q(:, 2), 4, []);
fill(x, y, [0.9 0.9 0.9]);
hold on;

%% Generate obj
q = Cam.project(p);
Cam.drawToScreen(q, 'b');


Cam.drawAxis();