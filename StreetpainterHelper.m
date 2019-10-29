d = 14;  % Distance from origin to camera

% E(2) is y hoogte van camera
E = [0, 10, d];

w_n = [0 1 0];

vertices = [
    0, 0;
    2, 0;
    2, 2;
    0, 2;
    
    .5, .5;
    2.5, .5;
    2.5, 2.5;
    .5, 2.5;
];

edges = [
    1 2;
    2 3;
    3 4;
    4 1;
    
    5 6;
    6 7;
    7 8;
    8 5;
    
    5 1;
    6 2;
    7 3;
    8 4;
];

p = vertices(edges', :);
p = p * [1 0 0; 0 1 0];

%%
figure;
plot(p(:, 1), p(:, 2));
axis square;

%%
r = p - E;
pj = (dot(-E, -w_n)./(r*(-w_n)')) .* r + E;
pj = [pj(:, 1) pj(:, 3)];
pj = pj * [1 0; 0 -1];      % Fix by mirror over x axis. Beetje hacky maar oke.
                            % Zit een fout in de berekening (minnetje ergens)

x = reshape(pj(:,1), 2, []);
y = reshape(pj(:,2), 2, []);

plot(x, y);
axis square;