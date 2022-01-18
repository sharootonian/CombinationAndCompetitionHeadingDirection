function tb = makeFigureTitle(figHandle, str, fontsize, fontweight, dy)

if exist('dy') ~= 1
    dy = 0.1;
end



tb = annotation('textbox', [0 1-dy 1 dy]);
set(tb, 'string', str, 'fontsize', fontsize, ...
    'fontweight', fontweight, ...
    'linestyle', 'none', 'horizontalAlignment', 'center', ...
    'verticalAlignment', 'middle')




