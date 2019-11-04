s = 4;  % Distance from origin to screen
d = 8;  % Distance from screen to camera

E = [s+d, 5, s+d];
T = [0, 0, 0];

Cam = Camera(E, T, 8, 90);

load('wireframe.mat');
p = cube;
p = p + [0 2 0];

% p = objload('models/teapot.obj', 0.05);
q = Cam.project(p);
Cam.drawAxis();
Cam.drawToScreen(q, 'b');

%%
frames = 100;
M = moviein(frames);
for i = 1:frames
    clf;
    Cam.drawCheckerboard(2, 8);
    Cam.drawAxis();
    
    Cam.E = E .* [sin(i*2*pi/frames) 1 cos(i*2*pi/frames)];
    q = Cam.project(p);
    Cam.drawToScreen(q, 'b');
%     Cam.projectAndDrawAnaglyph(p);
    text(-4, 4, sprintf("i: %f", i));
    
    M(:, i) = getframe;
%     pause(1);
end

movie(M, 5)
