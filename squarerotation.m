%Proof of concept of rotating an object around its axis

angle = 0.05*pi; 
x = 2; %location of cube
y = 2;

rotmatrix = [cos(angle) -sin(angle) 0; sin(angle) cos(angle) 0; 0 0 1]; %rotation
transmatrix = [1 0 -x;0 1 -y;0 0 1]; % translate
itransmatrix = inv(transmatrix);

rotation = itransmatrix * rotmatrix * transmatrix; %transformation applied right to left

rtc = [x+1;y+1;1]; %right top cube corner
rbc = [x+1;y-1;1]; %right bottom cube corner
ltc = [x-1;y+1;1]; %left top cube corner
lbc = [x-1;y-1;1]; %left bottom cube corner
cube = [rtc rbc lbc ltc rtc];

hrotatedcube = rotation * cube;
rotatedcube = homconvert(hrotatedcube);

X=rotatedcube(1,:);
Y=rotatedcube(2,:);
line(X,Y);