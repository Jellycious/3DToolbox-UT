classdef JCamera
    %CAMERA Defines a pinhole camera
    %   Detailed explanation goes here
    
    properties
        FoV % Field of View in radians (0,pi)
        d % distance to the screen 
        E % camera location
        T % camera target location
    end
    
    methods
        function obj = JCamera(FoV,d,E,T) % constructor
            
            if (FoV<=0 || FoV >= pi)
                error('FoV is out of bounds');
            end
            
            obj.FoV = FoV;
            obj.d = d;
            obj.E = E;
            obj.T = T;
        end
        
        function s = get_screensize(obj)
           s = 2*tan(0.5*obj.FoV)*obj.d;
        end
        
        function n = get_camnormal(obj)
            t = obj.T - obj.E;
            n = t/norm(t);
        end
    end
end

