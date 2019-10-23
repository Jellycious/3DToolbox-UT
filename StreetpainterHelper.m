s = 4;  % Distance from origin to screen
d = 8;  % Distance from screen to camera

E = [0, 8, s+d];
T = [0, 0, -16];
t_n = (T-E)/norm(T-E);
b_n = [1 0 0];              %  Assumption
w_n = cross(b_n, t_n);

vertices = [
    0, 0;
    2, 0;
    2, 2;
    0, 2;
    
    .5, .5;
    2.5, .5;
    2.5, 2.5;
    .5, 2.5;
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
];

p = vertices(edges', :);
p = p * [1 0 0; 0 1 0] + [0 0 s];
plot(p(:, 1), p(:, 2));

r = p - E;
p = (dot(-E, w_n)./(r*w_n')) .* r + E;

figure;
plot(p(:, 1), p(:, 2));

%%
r = p - E;
r_n = r/norm(r);

p = (d./(r_n*t_n')) .* r_n + E;

fig = figure('Name', 'Object');
plot(p(:,1), p(:,2), '-o');

axis square;