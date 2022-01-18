function a = x2a(x, xl, ax1, ax2)

% normalized units in axes coordinates
dum = (x - xl(1)) / (xl(2) - xl(1));

% transform axes coordinates into figure coordinates
a = dum*(ax2-ax1) + ax1;