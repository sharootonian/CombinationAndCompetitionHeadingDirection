function set_legendLines(l, linewidth, markersize)

M = findobj(l,'type','line');
set(M,'linewidth',linewidth, 'markersize', markersize) ;
