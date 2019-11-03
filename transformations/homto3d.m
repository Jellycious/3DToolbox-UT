function v = homto3d(homv)

%converts homogeneous coordinate to 3d coordinate
%every column is a coordinate
v=homv(1:end-1,:)./homv(end,:);
end