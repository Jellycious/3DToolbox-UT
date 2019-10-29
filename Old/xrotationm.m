function m = xrotationm(angle)  %anti-clockwise rotation of homogeneous coordinate along x axis
    m = [1 0 0 0; 0 cos(angle) -sin(angle) 0; 0 sin(angle) cos(angle) 0; 0 0 0 1];
end