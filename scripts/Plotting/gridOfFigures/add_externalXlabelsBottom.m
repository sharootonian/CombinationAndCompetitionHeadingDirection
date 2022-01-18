function [b] = add_externalXlabelsBottom(wg, hg, wb, hb, delta2, str)


% delta2 = 0.06;
for i = 1:length(str)
    b(i) = annotation('textbox', [sum(wg(1:i))+sum(wb(1:i-1)) max([0 delta2]) wb(i) hg(1)+delta2], 'string', str{i});
end
set(b, 'fontsize', 16, 'linestyle', 'none', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'middle')
