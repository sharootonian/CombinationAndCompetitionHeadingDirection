function [ax, wb, wg, hb, hg] = rectangularGrid(...
    Nx, Ny, dw, dh, wg1, wgEnd, hg1, hgEnd)

% ax = rectangularGrid(Nx, Ny, dh, dw, wg1, wgEnd, hg1, hgEnd)

% 
% Nx = 4;
% Ny = 6;
% 
% dh = 0.01;
% dw = 0.03;

hg = ones(Ny+1,1)*dh;
wg = ones(Nx+1,1)*dw;

if exist('hg1') == 1
    hg(1) = hg1;
end
if exist('hgEnd') == 1
    hg(end) = hgEnd;
end
if exist('wg1') == 1
    wg(1) = wg1;
end
if exist('wgEnd') == 1
    wg(end) = wgEnd;
end


hb = (ones(Ny, 1)-sum(hg))/Ny;
wb = (ones(Nx, 1)-sum(wg))/Nx;


ax = gridOfEqualFigures(hb, wb, hg, wg);