function m = zrotationm(angle) %anti-clockwise rotation of homogeneous coordinate along z axis
m = [cos(angle) -sin(angle) 0 0; sin(angle) cos(angle) 0 0; 0 0 1 0; 0 0 0 1];
end