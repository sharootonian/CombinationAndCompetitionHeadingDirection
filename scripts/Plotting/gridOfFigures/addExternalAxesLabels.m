function [hv, hh] = addExternalAxesLabels(ax, xlab, ylab, ox, oy)

% [hv, hh] = addExternalAxesLabels(ax, xlab, ylab, ox, oy)
%
% ax - axes must be a rectangular grid of axes
% xlab - xlabels
% ylab - ylabels
% ox - x offset
% oy - y offset

% Robert Wilson 09/03/12

pos= get(ax, 'position');
if iscell(pos)
    pos = vertcat(pos{:});
end
    
% round pos to nearest 10^-10
pos = round(pos*10^10)/10^10;

x = unique(pos(:,1));
y = unique(pos(:,2));
dx = unique(pos(:,3));
dy = unique(pos(:,4));

i = 1;
for j = 1:length(y)
    
    hv(j)=annotation('textarrow',...
        [x(i)+dx/2 y(j) ],[ y(j) x(i)+dx], ...
        'string',ylab{j}, ...
        'HeadStyle','none','LineStyle', 'none', 'color', 'k');
    
    set(hv(j), 'position', [x(i)-ox y(j)+dy/2 0 0], ...
        'textrotation', 90, ...
        'horizontalAlignment', 'center', ...
        'verticalAlignment', 'middle')
end

j = length(y);
for i = 1:length(x)
    
    hh(i)=annotation('textbox',...
        [x(i)+dx/2 y(j) y(j) x(i)+dx], ...
        'string',xlab{i});
    
    set(hh(i), 'position', [x(i) y(j)+dy-oy dx 0.05], ...
        'horizontalAlignment', 'center', ...
        'verticalAlignment', 'middle', ...
        'linestyle', 'none')
end



