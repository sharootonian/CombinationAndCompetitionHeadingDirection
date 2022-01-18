function [hh] = addExternalAxesLabels_Xonly(ax, xlab, oy)

% [hv, hh] = addExternalAxesLabels_Xonly(ax, xlab, oy)
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
    
x = unique(pos(:,1));
y = unique(pos(:,2));
dx = unique(pos(:,3));
dy = unique(pos(:,4));
dy = dy(1);

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



