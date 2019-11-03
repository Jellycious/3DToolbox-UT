E = [-2 0 0];
T = [10 0 0];
d = 4;
FoV = 1/2*pi;

cam = Camera(FoV,d,E,T);
testpoints = [6 2 -2; 6 2 2; 6 -2 2;6 -2 -2;8 2 -2;8 2 2; 8 -2 2; 8 -2 -2]'; %collection of points

pp = project_points_screen(cam,testpoints);

wn = [0 1 0];
tn = (cam.T-cam.E)/norm(cam.T-cam.E);
sx = cross(tn,wn)/norm(cross(tn,wn)); % x component of screen
sy = cross(sx,tn);  % y component of the screen

x = sx*pp;
y = sy*pp;

plot(x,y);