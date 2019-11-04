%takes 3D points of plane and converts them to 2D points for x,y plot.

function [x,y] = plot_screen(cam, points)

wn = [0 1 0];
tn = (cam.T-cam.E)/norm(cam.T-cam.E);
sx = cross(tn,wn)/norm(cross(tn,wn)); % x component of screen
sy = cross(sx,tn);  % y component of the screen
disp(sx);
x = sx*points;
y = sy*points;
ss = cam.get_screensize();
xc = x;
yc = y;

%improper clipping
xc(x < -ss)=-inf;
xc(x > ss)=-inf;
yc(x < -ss)=-inf;
yc(x > ss)=-inf;
xc(y < -ss)=-inf;
xc(y > ss)=-inf;
yc(y < -ss)=-inf;
yc(y > ss)=-inf;
xc(xc == -inf)=[];
yc(yc == -inf)=[];
x= xc;
y= yc;
end

