%calculates the intersection point of a line with a plane.
%line is defined by a vector and a point.
%plane is defined by a normal vector and a point.
function [v, a] = planelineintersection(r, r_0, n, p_0)

    if dot(r,n)==0
        error('lines are parallel');
    end
    
    pv = p_0 - r_0;
    u = dot(pv,n);
    l = dot(r,n);
    a = u/l;
    v = a*r+r_0;
    return;
    
end
