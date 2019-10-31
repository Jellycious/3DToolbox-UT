s = 4;  % Distance from origin to screen
d = 8;  % Distance from screen to camera

E = [s+d, 0, s+d];
T = [0, 0, 0];

load('wireframe.mat');
p = cube;

% p = objload('teapot.obj', 0.05);


frames = 100;
M = moviein(frames);
for i = 1:frames
    clf;
    
    [x, y] = project_to_plane(p, d, E.*[sin(i*2*pi/frames) 1 cos(i*2*pi/frames)]);
    draw_screen(x, y);
    hold on;
    text(-4, 4, sprintf("i: %f", i));
    
    M(:, i) = getframe;
%     pause(1);
end

movie(M, 5)