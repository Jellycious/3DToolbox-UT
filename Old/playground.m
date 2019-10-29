%testing playground
xrot = xrotationm(1/4*pi);
yrot = yrotationm(1/4*pi);
zrot = zrotationm(1/4*pi);


tx = [1 0 0 1]';
ty = [0 1 0 1]';
tz = [0 0 1 1]';

%rotational order matters
composite1 = zrot * yrot * xrot;
composite2 = xrot * yrot * zrot;

%rotational matrices are orthogonal
I = xrot * xrot';