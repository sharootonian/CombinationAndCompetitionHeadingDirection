function a = add_oneExternalXLabel_v1(hg, wg, hb, wb, delta, str, location)

wg2 = [wg(1) sum(wg(2:end-1))+sum(wb) wg(end)];
hg2 = hg;
wb2 = sum(wg(2:end-1))+sum(wb);
hb2 = hb;
switch location
    case 'top'
        [a] = add_externalXlabelsTop(wg2, hg2, wb2, hb2, delta, str);
        
    case 'bottom'
        [a] = add_externalXlabelsBottom(wg2, hg2, wb2, hb2, delta, str);
end
