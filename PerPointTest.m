s = 4;  % Distance from origin to screen
d = 8;  % Distance from screen to camera

E = [0, 0, s+d];
T = [0, 0, 0];

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
];
p = vertices(edges', :);

[x, y] = project_and_plot(p, d, E);
draw_screen(x, y);