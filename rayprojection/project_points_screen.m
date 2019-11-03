%takes an camera object. A set of points and calculates the projection on
%the screen of the camera.

%camera: camera object.
%points: matrix where every column is a point in 3D space.

function [p, a] = project_points_screen(camera, points)
%PROJECT_POINTS Summary of this function goes here
%   Detailed explanation goes here

E = camera.E;
T = camera.T;
d = camera.d;

te = T-E;
tn = te/norm(te);

r = points-E';
lq = tn * r; %repeated dot product as matrix multiplication
a = d./lq; 
ra = a.*r; % intersection points with camera screen.
p = ra + camera.E';
end

