function [x, y] = project_to_plane(p, d, E, T)
if (nargin < 4)
    T = [0 0 0];
end
t_n = (T-E)/norm(T-E);
w_n = [ 0 1 0 ];

b = cross(t_n, w_n);
s_x = b/norm(b);
s_y = cross(s_x, t_n);


% Werkt niet helemaal
% xaxis = [-1000 0 0; 1000 0 0]; p = [p; xaxis];
% yaxis = [0 -1000 0; 0 1000 0]; p = [p; yaxis];
% zaxis = [0 0 -1000; 0 0 1000]; p = [p; zaxis];
% p = [p; xaxis; yaxis; zaxis];

% Find vector from camera to point
r = p - E;

% Project
%a = d./(r*t_n')
a = abs(d)./(r*t_n')
% Remove alle punten achter de camera
% Zo kunnen we niet oneindig lange lijnen maken tho...
a(a < 0) = 0;

pj = a .* r + E;

x = pj*s_x';
y = pj*s_y';

% Reshape to 
% x:                y:
% | x0  x2 |         | y0  y2 |
% | x1  x3 |         | y1  y3 |
% [x0, y0] -> [x1, y1] enz.
% TODO: Kut dit is stuk... Screen is natuurlijk bijna nooit exact x en y
% Vind scherm assen en coords dmv t_n
x = reshape(x, 2, []);
y = reshape(y, 2, []);