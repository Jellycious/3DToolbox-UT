s = 4;  % Distance from origin to screen
d = 8;  % Distance from screen to camera

E = [0, 0, s+d];
T = [0, 0, 0];

load('wireframe.mat');
p = cube;

% Temp animation, wil een cirkel rond het object maken (sin cos function)

frames = 255;
M = moviein(frames);
for i = 1:frames
    [x, y] = project_and_plot(p, d, E+[-i/30 i/50 0 ]);
    draw_screen(x, y);
    
    M(:, i) = getframe;
%     pause(0.1);
end

movie(M, 20)