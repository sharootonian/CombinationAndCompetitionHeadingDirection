function t = imageTextMatrixStars_v2(M, P, threshold, xtl, ytl)

% M = rand(10,5);

imagesc(M)
for i = 1:size(M,1)
    for j = 1:size(M,2)
        
        if P(i,j) < threshold
            str = [num2str(M(i,j)) '*'];
        else
            str = [num2str(M(i,j))];
        end
        t(j,i) = text(j,i,str);
        set(t(j,i), 'horizontalalignment', 'center', ...
            'verticalalignment', 'middle');
        if P(i,j) < threshold
            set(t(j,i), 'fontweight', 'bold');
        end
    end
end
if exist('xtl') == 1
    set(gca, 'xticklabel', xtl)
end
if exist('ytl') == 1
    set(gca, 'yticklabel', ytl)
end

