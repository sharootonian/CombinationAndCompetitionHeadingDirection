% defaultPlotParameters

% colors
global AZred AZblue AZcactus AZsky AZriver AZsand AZmesa AZbrick

AZred = [171,5,32]/256;
AZblue = [12,35,75]/256;
AZcactus = [92, 135, 39]/256;
AZsky = [132, 210, 226]/256;
AZriver = [7, 104, 115]/256;
AZsand = [241, 158, 31]/256;
AZmesa = [183, 85, 39]/256;
AZbrick = [74, 48, 39]/256;


% axes
fontsize = 12;
linewidth = 1;
fontweight = 'normal';

set(0, 'defaultfigurecolor', 'w', ...
    'defaultaxesfontsize', fontsize, ...
    'defaultaxesfontweight', fontweight, ...
    'defaultaxestickdir', 'out', ...
    'defaultaxesbox', 'off', ...
    'defaultaxesydir', 'normal', ...
    'defaultlinelinewidth', linewidth, ...
    'defaultlinemarkersize', 30, ...
    'defaultfigureposition', [440   504   468   200])