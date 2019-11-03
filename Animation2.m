%%This file is an animation also utilizing transformation matrices.
s = 4;
d = 8;  % Distance from screen to camera

E = [d+s, 5, d+s];
T = [0, 0, 0];

Cam = Camera(E, T, d, 90);

load('wireframe.mat');
p = cube;

q = Cam.project(p);
Cam.drawToScreen(q, 'b');

%%
frames = 200;
M = moviein(frames);

for i = 1:frames
    clf;
    Cam.drawAxis();
    Cam.E = E .* [sin(i*2*pi/frames) 1 cos(i*2*pi/frames)];
    q = Cam.project(p);
    %rotate cube
    homq = threedtohom(p');
    rotm = xrotationm(0.005*pi);
    homq = rotm * homq;
    p = homto3d(homq)';
    
    Cam.drawToScreen(q, 'b');
    text(-4, 4, sprintf("i: %f", i));
    
    M(:, i) = getframe;
end

movie(M, 5)