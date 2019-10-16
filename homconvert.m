function v = homconvert(homv)

%converts homogeneous coordinate to 3d coordinate

v=homv(1:end-1,:)./homv(end,:);
end