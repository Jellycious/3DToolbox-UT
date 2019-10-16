angle = 1/2*pi; %viewing angle
n = 0.1; %near 
f = 100; %far

%camera transform matrix. Transforms points in trapezoid to cube.
camtransform = [cot(angle/2) 0 0 0;0 cot(angle/2) 0 0; 0 0 (f+n)/(f-n) (2*f*n)/(f-n);0 0 -1 0]; 



%sanity check
testpoint1 = [0,0 (-n) 1];
testpoint2 = [0 0 (-f) 1]; 
testpoint3 = [0 -n*tan(angle/2) (-n),1];
testpoint4 = [0 f*tan(angle/2) (-f),1];
    
v1 = homconvert(camtransform*testpoint1');
v2 = homconvert(camtransform*testpoint2');
v3 = homconvert(camtransform*testpoint3');
v4 = homconvert(camtransform*testpoint4');
