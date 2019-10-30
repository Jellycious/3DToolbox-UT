function [x, y] = project_to_plane(p, d, E, T)
if (nargin < 4)
    T = [0 0 0];
end
t_n = (T-E)/norm(T-E);

% Find vector from camera to point
r = p - E;

% Project
a = d./(r*t_n')
a(a<0) = 0;
pj = a .* r + E;

% Reshape to 
% x:                y:
% | x0  x2 |         | y0  y2 |
% | x1  x3 |         | y1  y3 |
x = reshape(pj(:,1), 2, []);
y = reshape(pj(:,2), 2, []);

axis square;