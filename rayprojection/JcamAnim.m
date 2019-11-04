E = [-10 5 -10];
T = [10 -5 10];
d = 8;
FoV = 1/2*pi;

cam = JCamera(FoV,d,E,T);
ss = cam.get_screensize();
load('wireframe.mat');
q = cube;
hc = threedtohom(cube');
hc = translatem(5, 0, 5) * hc; 
hc = homto3d(hc)';

pp = project_points_screen(cam,q');
[x,y] = plot_screen(cam, pp);
plot(x,y);

%%Unfortunately weird tilting occurs...
frames = 100;
M = moviein(frames);
for i = 1:frames
    clf;
    cam.E = E .* [sin(i*2*pi/frames) 1 cos(i*2*pi/frames)];
    hold on;
    pp = project_points_screen(cam,q');
    [x,y] = plot_screen(cam,pp);
    pp2 = project_points_screen(cam,hc');
    [x2,y2] = plot_screen(cam,pp2);
    
    plot(x,y);
    plot(x2,y2);
    axis([-ss ss -ss ss]);
    hold off;
    
    M(:, i) = getframe;
end

movie(M, 5)