%takes 3D points of plane and converts them to 2D points for x,y plot.

function [x,y] = plot_screen(cam, points)

wn = [0 1 0];
tn = (cam.T-cam.E)/norm(cam.T-cam.E);
sx = cross(tn,wn)/norm(cross(tn,wn)); % x component of screen
sy = cross(sx,tn);  % y component of the screen

x = points*sx;
y = points*sy;

end

