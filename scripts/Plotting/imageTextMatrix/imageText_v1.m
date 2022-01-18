function t = imageText_v1(M, threshold, xtl, ytl)

% M = rand(10,5);


for i = 1:size(M,1)
    for j = 1:size(M,2)
        
        str = [num2str(M(i,j))];
        t(j,i) = text(j,i,str);
        set(t(j,i), 'horizontalalignment', 'center', ...
            'verticalalignment', 'middle');
        
    end
end
if exist('xtl') == 1
    set(gca, 'xticklabel', xtl)
end
if exist('ytl') == 1
    set(gca, 'yticklabel', ytl)
end

