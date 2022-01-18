function xxx = setAxesLabelsFontSize(ax, fontsize, fontweight)



xxx = get(ax, 'children');

for i = 1:length(xxx)
    
    if iscell(xxx)
        for j = 1:length(xxx{i})
            try
                set(xxx{i}(j), 'fontsize', fontsize, 'fontweight', fontweight)
            end
        end
    else
        try
            set(xxx(i), 'fontsize', fontsize, 'fontweight', fontweight)
        end
    end
end
