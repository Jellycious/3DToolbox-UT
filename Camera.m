classdef Camera
    properties
        E
        T
        C
        d
        salpha
        screensize
        
        w_n = [ 0 1 0 ]
    end
    
    methods
        % Constructor:
        function self = Camera(E0, T0, d, salpha)
            if nargin < 3
                % Default d of 8
                % Default alpha of 90
                
                self.d = 8;
                self.salpha = 90;
            else
                self.d = d;
                
                if nargin < 4
                    self.salpha = 90;
                else
                    self.salpha = salpha;
                end
            end
            
            self.E = E0;
            self.T = T0;
            
            t_n = (self.T-self.E)/norm(self.T-self.E);
            self.C = self.d * t_n + self.E;
            
            self.screensize = self.d * tan(self.salpha/2);
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
            % if required.
            a(a < 0) = Inf;

            % Calculate projected points
            pj = a .* r + self.E;
            
            q = [pj*s_x' pj*s_y'];
        end
        
        function plt = drawToScreen(self, q, color)
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

            plt = plot(x, y, color);
            axis([-self.screensize self.screensize, ...
                  -self.screensize self.screensize]);
            hold on;
        end
        
        function drawSquares(self, p, color)
            q = self.project(p);
            x = reshape(q(:,1), 4, []);
            y = reshape(q(:,2), 4, []);
            fill(x, y, color);
            hold on;
        end
        
        function drawAxis(self)
            % The x,y,z normal vectors
            p = [
                1 0 0; 0 0 0;
                 0 1 0; 0 0 0;
                 0 0 1; 0 0 0
                 ];
             
            pt = self.projectLine(p);
            
            self.drawToScreen(pt([1 2],:), 'red');
            self.drawToScreen(pt([3 4],:), 'green');
            self.drawToScreen(pt([5 6],:), 'blue');
        end
        
        function drawCheckerboard(self, ss, sc)
%             ss = 2;  % Squaresize
%             sc = 6;  % Squarecount in all directions
            square = [0 0 0; ss 0 0; ss 0 ss; 0 0 ss];

            b = zeros(((sc+1)^2 + sc^2) * size(square,1), 3);
            w = zeros(((sc-1)^2 + sc^2) * size(square,1), 3);
            for i = -sc:sc-1
                for j = -sc:sc-1
                    if mod(i+j,2) == 0
                        b = [b; square+ss*[i 0 j]];
                    else
                        w = [w; square+ss*[i 0 j]];
                    end
                end
            end
            
            self.drawSquares(b, 'black');
            self.drawSquares(w, [.95 .95 .95]);
        end
        
        function projectAndDraw(self, p, color)
            q = self.project(p);
            self.drawToScreen(q, color);
        end
    
        function self = projectAndDrawAnaglyph(self, p)
            E0 = self.E;
            
            %% Draw left eye
            self.E = E0-[1.2,0,0];
            q = self.project(p);
%             self.drawToScreen(q, [1 0 0]);
            plt = self.drawToScreen(q, 'red');
            set(plt, 'Color', [1 0 0 0.5]);

            %% Draw right eye
            self.E = E0+[1.2,0,0];
            q = self.project(p);
            plt = self.drawToScreen(q, 'cyan');
            set(plt, 'Color', [0 1 1 0.5]);
            
            %% Reset
            self.E = E0;
        end
        
        % @param p: matrix with [p; p0; q; q0;] etc.
        function pt = projectLine(self, p)
            if mod(p,2) ~= 0
                error('Dimensions of dir and offset need to be equal');
            end
            
            % Just some tools. Normal vectors of xy plane
            I_x = [1 0];
            I_y = [0 1];

            % Project normal vectors
            q = self.project(p);
            q0 = q(2:2:end, :);     % Offset
            q = q(1:2:end, :);      % Direction vector
            
            % TODO: Ths part can probably be done more cleanly
            v = q - q0;
            a_x = (self.screensize*[1, -1] - q0*I_x') ./ (v*I_x');
            a_y = (self.screensize*[1, -1] - q0*I_y') ./ (v*I_y');
            
            % Okay, this is a mess... But it works quite well
            % Group the positive negative scalars of each line, and take
            % the max of the negative and the min of the positive scalars.
            aa = zeros(size(a_x,1)*2, 2);
            aa(1:2:end, :) = a_x;
            aa(2:2:end, :) = a_y;
            aa = reshape(aa', 4, []);
            aa = sort(aa);
            aa = reshape(aa, 2, []);
            aM = max(aa(:,1:2:end));
            am = min(aa(:,2:2:end));
            a = [aM' am'];                      % Find min scalar needed for
                                                % intersection with screen edge

            % Convert resulting scalar into two points and format them like:
            % | x00 y00 |
            % | x01 y01 |
            % | x10 y10 |
            % | x11 y11 |
            rows = size(v, 1)*2;
            pt = zeros(rows, 2);

            pt(1:2:rows, :) = a(:,1).*v + q0;
            pt(2:2:rows, :) = a(:,2).*v + q0;
        end
    end
end