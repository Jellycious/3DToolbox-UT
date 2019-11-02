classdef Camera
    properties
        E
        T
        d
        alpha
        screensize
        
        w_n = [ 0 1 0 ]
    end
    
    methods
        % Constructor:
        function self = Camera(E0, T0, d, alpha)
            if nargin < 3
                % Default d of 8
                % Default alpha of 90
                
                self.d = 8;
                self.alpha = 90;
            else
                self.d = d;
                
                if nargin < 4
                    self.alpha = 90;
                else
                    self.alpha = alpha;
                end
            end
            
            self.E = E0;
            self.T = T0;
            
            self.screensize = self.d * tan(self.alpha/2);
        end
        
        function q = project(self, p)
            %% Prepare (find normal vectors etc.)
            t_n = (self.T-self.E)/norm(self.T-self.E);

            b = cross(t_n, self.w_n);
            s_x = b/norm(b);            % Normal x vector of screen (plane)
            s_y = cross(s_x, t_n);      % Normal y vector of screen

            % Find vector from camera to point
            r = p - self.E;

            %% Project
            a = self.d./(r*t_n');         % Find intersection with plane
            
            % Remove all points behind camera
            % TODO: Do some better checks, and move points to screen edge
            % if required.
            a(a < 0) = 0;

            % Calculate projected points
            pj = a .* r + self.E;
            
            q = [pj*s_x' pj*s_y'];
        end
        
        function drawToScreen(self, q, color)
           if nargin < 2
                color = 'b-';
           end

            % Reshape to 
            % x:                y:
            % | x0  x2 |         | y0  y2 |
            % | x1  x3 |         | y1  y3 |
            % [x0, y0] -> [x1, y1] enz.
            x = reshape(q(:, 1), 2, []);
            y = reshape(q(:, 2), 2, []);

            plot(x, y, color);
            axis([-self.screensize self.screensize, ...
                  -self.screensize self.screensize]);
            hold on;
        end
        
        function drawAxis(self)
            I_x = [1 0];
            I_y = [0 1];

            % The x,y,z normal vectors
            p = [1 0 0; 0 1 0; 0 0 1];
            % Distance from origin to screen side
            self.screensize = self.d * tan(self.alpha/2);

            % Project normal vectors
            q = self.project(p);
            
            % TODO: Ths part can probably be done more cleanly
            a_x = self.screensize ./ (q*I_x');
            a_y = self.screensize ./ (q*I_y');
            a = min(abs(a_x), abs(a_y));        % Find min scalar needed for 
                                                % intersection with screen side

            % Convert resulting scalar into two points and format them like:
            % | x00 y00 |
            % | x01 y01 |
            % | x10 y10 |
            % | x11 y11 |
            rows = size(p, 1)*2;
            pt = zeros(rows, 2);

            pt(1:2:rows, :) = -a.*q;
            pt(2:2:rows, :) = a.*q;
            
            self.drawToScreen(pt, 'black');
        end
        
        function projectAndDraw(self, p, color)
            q = self.project(p);
            self.drawToScreen(q, color);
        end
    
        function projectAndDrawAnaglyph(self, p)
            E0 = self.E;
            
            %% Draw left eye
            self.E = E0-[1.2,0,0];
            q = self.project(p);
            self.drawToScreen(q, 'red');

            %% Draw right eye
            self.E = E0+[1.2,0,0];
            q = self.project(p);
            self.drawToScreen(q, 'cyan');
            
            %% Reset
            self.E = E0;
        end
    end
end