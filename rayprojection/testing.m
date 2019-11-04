E = [-10 5 -10];
T = [10 -5 10];
d = 8;
FoV = 1/2*pi;

cam = JCamera(FoV,d,E,T);
%cam.E = E .* [sin(1.2*pi) 1 cos(1.2*pi)];

ss = cam.get_screensize();
load('wireframe.mat');
q = cube;
hc = threedtohom(cube');
hc = translatem(5, 0, 5) * hc; 
hc = homto3d(hc)';

pp = project_points_screen(cam,q');
qq = project_points_screen(cam,hc');
testpoint = [0 0 0];
tp = project_points_screen(cam,testpoint');
[tpx, tpy] = plot_screen(cam,tp);
hold on;
[x,y] = plot_screen(cam, pp);
plot(x,y);
[x,y] = plot_screen(cam,qq);
plot(x,y);
axis([-ss ss -ss ss]);
hold off;