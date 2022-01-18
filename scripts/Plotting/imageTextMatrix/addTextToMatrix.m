function t = addTextToMatrix(M, xtl, ytl)

% M = rand(10,5);

if iscell(M)
    for i = 1:size(M,1)
        for j = 1:size(M,2)
            t(j,i) = text(j,i, M{i,j});
            set(t(j,i), 'horizontalalignment', 'center', ...
                'verticalalignment', 'middle');
        end
    end
    
else
    
    for i = 1:size(M,1)
        for j = 1:size(M,2)
            t(j,i) = text(j,i, num2str(M(i,j)));
            set(t(j,i), 'horizontalalignment', 'center', ...
                'verticalalignment', 'middle');
        end
    end
    
end
if exist('xtl') == 1
        set(gca, 'xticklabel', xtl)
    end
    if exist('ytl') == 1
        set(gca, 'xticklabel', ytl)
    end