s = 4;  % Distance from origin to screen
d = 8;  % Distance from screen to camera

E = [0, 5, s+d];
T = [0, 0, 0];
t_n = (T-E)/norm(T-E);

A = [d/(s+d) 0       s                      (-d/(s+d))+2;
     0       d/(s+d) s                      (-d/(s+d))+2;
     0       0       (d*(1-(s+d))/(-1+s+d)) (-d/(-1+s+d))+2;
     0       0       s                      (-d/(s+d))+2]'
 
A = [
    d/(s+d) 0 s (-2*d)/(s+d)+2;
    0 d/(s+d), s, (-2*d)/(s+d)+2;
    0 0 (d*(1-s+d))/(-1+s+d)+s+d (-2*d)/(-1+s+d)+2;
    0 0 s (-d)/(s+d)+2
]'


test = [2; 0; 0; 1];

disp(A*test)

vertices = [
    2, 2, 0, 1;
    2, -2, 0, 1;
    -2, -2, 0, 1;
    -2, 2, 0, 1;
    
    2, 2, 4, 1;
    2, -2, 4, 1;
    -2, -2, 4, 1;
    -2, 2, 4, 1;
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

p = vertices(edges', :)';

p = A*p;

fig = figure('Name', 'Object');
plot(p(1,:)./p(3,:), p(1,:)./p(3,:), '-o');

axis square;