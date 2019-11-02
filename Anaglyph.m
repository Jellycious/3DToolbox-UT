% Teapot model van https://people.sc.fsu.edu/~jburkardt/data/obj/obj.html
s = 10;
d = 8;

E = [0, 0, s+d];
T = [0, 0, 0];
Cam = Camera(E, T, d, 90);

% load('wireframe.mat');
% p = cube;

p = objload('models/teapot.obj', 0.1);

%% Generate plane
% Moet in eigen functie eigenlijk
px = 10;
py = min(p(:,2));
pp = [-10 py 10; 10 py 10; 10 py -10; -10 py -10];
q = Cam.project(pp);
% TODO: Dit kan beter in draw functie
x = reshape(q(:,1), 4, []);
y = reshape(q(:,2), 4, []);
fill(x, y, [0.9 0.9 0.9]);

%% Draw Anaglyph

Cam.projectAndDrawAnaglyph(p);