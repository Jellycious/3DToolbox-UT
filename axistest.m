s = 4;
d = 8;
alpha = 90;

E = [5, 3, s+d];
T = [0, 0, 0];

Cam = Camera(E, T, d, 90);

load('wireframe.mat');
p = cube;
p = [p; -2 -2 -2; 2 2 2];
p = p + [0 2 0];
q = Cam.project(p);

Cam.drawAxis();
Cam.drawToScreen(q, 'b');