%%This file is an animation also utilizing transformation matrices.

d = 8;  % Distance from screen to camera

E = [-8, 5, 5];
T = [0, 0, 0];

Cam = Camera(E, T, d, 90);

load('wireframe.mat');
p = cube;


Cam.drawAxis();

%rotate cube
homq = threedtohom(p');
transm = yrotationm(0*pi); %rotation along x axis. we could also do translation of something else.
homq = transm * homq;
p = homto3d(homq)';
q = Cam.project(p);
Cam.drawToScreen(q, 'b');
