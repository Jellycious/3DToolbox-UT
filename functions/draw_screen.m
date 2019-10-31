function out = draw_screen(x, y, color)
if nargin < 3
    color = 'b-';
end
% Hier kunnen we ook een FOV implementeren als we willen

plot(x, y, color);
axis([-5 5, -5 5]);

