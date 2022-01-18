function [a] = add_externalYlabelsRotation_v1(wg, hg, wb, hb, rot, delta, str)

% delta = 0.05;
for i = 1:length(str)
    Y = sum(hg(1:i))+sum(hb(1:i-1))+hb(i)/2;
    X = wg(1)/2;
    a(i) = annotation('textarrow', ...
        [X X]+delta,  [Y Y], 'string' ,str, ...
        'linestyle', 'none', 'headstyle', 'none',  'textrotation', rot, ...
        'horizontalalignment', 'center')
    
end
% set(a, 'fontsize', 16, 'linestyle', 'none', ...
%     'horizontalalignment', 'middle', ...
%     'verticalalignment', 'middle')

% 