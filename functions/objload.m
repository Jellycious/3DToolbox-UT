function out = objload(filename, scale_factor)
if nargin < 1
    error('Missing filename to OBJ file');
elseif nargin < 2
    scale_factor = 1;
end

fd = fopen(filename, 'rt');
fseek(fd, 50, 'bof');

vertices = [];
edges = [];
while ~feof(fd)
    line = fgetl(fd);
    
    % Skip if line is empty
    if isempty(line)
        continue;
    end
    
    if line(1) == 'v'
        vertices = [vertices; str2num(line(4:end))];
    elseif line(1) == 'f'
        % TODO: Fix for negative indices and more obscure definitions (like
        % vertex/normal/texture format)
        e = str2num(line(4:end));
        edges = [edges; e(1) e(2); e(2) e(3); e(3) e(1)];
    end
    
end

out = vertices(edges', :) .* (scale_factor*[1 1 1]);