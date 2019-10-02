s = 4;  % Distance from origin to screen
d = 8;  % Distance from screen to camera

E = [0, 0, s+d];
T = [0, 0, 0];
t_n = (E-T)/norm(E-T);

alpha = (d * sqrt(1 + (s+d)^2))/(s+d);  % Scalar for perspective
T = [alpha 0 0; 0 alpha 0];  % Transformation matrix

vertices = [
    2, 2, 0;
    2, -2, 0;
    -2, -2, 0;
    -2, 2, 0;
    
    2, 2, 4;
    2, -2, 4;
    -2, -2, 4;
    -2, 2, 4;
];

edges = [
    1 2;
    2 3;
    3 4;
    4 1;
    
    5 6;
    6 7;
    7 8;
    8 5;
    
    5 1;
    6 2;
    7 3;
    8 4;
    5 1;  % Temp...
];

p = vertices(edges', :);

r = E - p;
r_n = r/norm(r);

p = (d./(r_n*t_n')) .* r_n + E;

fig = figure('Name', 'Object');
plot(p(:,1), p(:,2), '-o');

axis square;