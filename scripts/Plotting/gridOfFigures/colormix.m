function kol = colormix(col1, col2, i, L)

kol = col1 * (i-1)/(L-1) + col2 * (1 - (i-1)/(L-1));