function [b, e, dd] = barErrorbar(X, Y, Ysem, Ysem_high)

if nargin<4
    Ysem_high = Ysem;
end

hold on;

Xdist = 1;
[a, numbar] = size(Y);
if (numbar>1)
    barwidth = Xdist/(numbar+1);
else
    barwidth = Xdist/numbar;
end
% d = [-ceil(numbar/2):2:ceil(numbar/2)]; 

% if mod(numbar,2) == 0
%     d = [-ceil((numbar+1)/2):2:ceil((numbar+1)/2)];
% else
%     d = [-ceil(numbar/2):2:ceil(numbar/2)]; 
% end

d = 2*([1:numbar]-mean([1:numbar]));
% b = bar(X, Y);

for i = 1:numbar
    b(i) = bar(X+d(i)*barwidth/2,Y(:,i),barwidth/Xdist);
end
for i = 1:numbar;%length(d)
    
    e(i) = errorbar(X+d(i)*barwidth/2,Y(:,i),Ysem(:,i),Ysem(:,i));
    set(e(i), 'linestyle', 'none', 'color', 'k');
end

dd = d * barwidth/2;
