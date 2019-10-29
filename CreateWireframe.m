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
cube = vertices(edges', :);

save('wireframe.mat', 'cube');