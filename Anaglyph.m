% Teapot model van https://people.sc.fsu.edu/~jburkardt/data/obj/obj.html
s = 10;
d = 8;

E = [0, 0, s+d];
T = [0, 0, 0];
Cam = Camera(E, T, d, 90);

% load('wireframe.mat');
% p = cube;

p = objload('models/teapot.obj', 0.2);


%% Draw Anaglyph
clf;
Cam.projectAndDrawAnaglyph(p);