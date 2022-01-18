function t = imageTextMatrix_JustStars_v1(M, pp, thresh, offset)

% specify decimal places too (nDP)
% M = rand(10,5);


imagesc(M)

for i = 1:size(pp,1)
    for j = 1:size(pp,2)
        if pp(i,j) < thresh
            t(i,j) = text(i, j+offset, '*', ...
                'horizontalalignment', 'center', ...
                'verticalalignment', 'middle', ...
                'fontsize', 24);
        end
    end
end
