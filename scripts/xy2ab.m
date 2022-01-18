function [a,b] = xy2ab(x, y, xl, yl)

a = (x - xl(1))/(xl(2)-xl(1));
b = (y - yl(1))/(yl(2)-yl(1));