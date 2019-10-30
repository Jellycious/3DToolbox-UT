s = 4;  % Distance from origin to screen
d = 8;  % Distance from screen to camera

% E = [0, 0, s+d];
E = [ 0, 0, 0 ];
T = [0, 0, 0];

load('wireframe.mat');
p = cube;

% Temp animation, wil een cirkel rond het object maken (sin cos function)

frames = 100;
M = moviein(frames);
for i = 1:frames
    clf;
    
    [x, y] = project_to_plane(p, d, E+[ (s+d)*sin(i*2*pi/frames) 0 (s+d)*cos(i*2*pi/frames)]);
    draw_screen(x, y);
    hold on;
    text(-4, 4, sprintf("i: %f", i));
    
    M(:, i) = getframe;
    pause(0.1);
end

movie(M, 20)