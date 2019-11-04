E = [-4 0 0];
T = [10 0 0];
d = 4;
FoV = 1/2*pi;

cam = JCamera(FoV,d,E,T);
load('wireframe.mat');
q = cube;
pp = project_points_screen(cam,q);

[x,y] = plot_screen(cam,pp);
plot(x,y);