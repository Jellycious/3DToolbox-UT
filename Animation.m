s = 4;  % Distance from origin to screen
d = 8;  % Distance from screen to camera

E = [s+d, 0, 0];
% E = [ 0, 0, 0 ];
T = [0, 0, 0];

load('wireframe.mat');
p = cube;

% Temp animation, wil een cirkel rond het object maken (sin cos function)

frames = 100;
M = moviein(frames);
for i = 1:frames
    clf;
    
    [x, y] = project_to_plane(p, d, E.*[sin(i*2*pi/frames) 1 cos(i*2*pi/frames)]);
%     [x, y] = project_to_plane(p, d, E+[(s+d)*sin(i*2*pi/frames) 0 (s+d)*cos(i*2*pi/frames)]);
%     [x, y] = project_to_plane(p, d, E+[i 0 0]);
    draw_screen(x, y);
    hold on;
    text(-4, 4, sprintf("i: %f", i));
    
    M(:, i) = getframe;
%     pause(0.2);
end

movie(M, 5)