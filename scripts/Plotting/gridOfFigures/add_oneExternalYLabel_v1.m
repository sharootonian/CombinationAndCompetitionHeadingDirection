function a = add_oneExternalYLabel_v1(hg, wg, hb, wb, rot, delta, str)

hg2 = [hg(1) sum(hg(2:end-1))+sum(hb) hg(end)];
wg2 = wg;
hb2 = sum(hg(2:end-1))+sum(hb);
wb2 = wb;
[a] = add_externalYlabelsRotation_v1(wg2, hg2, wb2, hb2, rot, delta, str)