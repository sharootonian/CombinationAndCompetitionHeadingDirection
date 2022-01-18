function col = make_coolColorMap_v1(c1, c2, c3)

% make a colormap with red negative and blue positive, white in middle
% c1 = AZred;
% c2 = [1 1 1];
% c3 = AZblue;

N = 64;

for i = 1:N/2
    f = (i-1)/(N/2-1);
    col(i,:) = c1*(1-f) + c2*f;
end
for i = N/2+1:N
    f = (i-N/2-1)/(N/2-1);
    col(i,:) = c2*(1-f) + c3*f;
end

% colormap(col)
