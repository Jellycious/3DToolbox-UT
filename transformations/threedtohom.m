%adds a w=1 to a vector

function hv = threedtohom(v)
    s = size(v);
    c = s(2);
    w = ones([c,1]);
    hv = [v;w'];
end

