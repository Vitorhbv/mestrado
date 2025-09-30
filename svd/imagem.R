imagem = function(y, mini = -1, maxi = 1, cores = 0) {
    # y: data matrix to be displayed
    # maxi: maximum value to be displayed with the highest color
    # cores: pattern of colors (1 = blue/red, 0 = white/black)
    require(lattice)
    y = as.matrix(y)
    xl = "colunas"
    yl = "linhas"
    nr = nrow(y)
    nc = ncol(y)
    #
    if (nr <= 5) {
        spr = 1
    } else {
        spr = round(nr / 10)
    }
    if (nc <= 5) {
        spc = 1
    } else {
        spc = round(nc / 7)
    }
    lab.x = seq(1, nc, spc) #lab.x[length(lab.x)] = nc;
    lab.y = seq(1, nr, spr) #lab.y[length(lab.y)] = nr;
    sc = list(
        x = list(at = seq(1, nc, spc), labels = as.character(lab.x), cex = 2.0),
        y = list(
            at = seq(nr, 1, -spr),
            labels = as.character(lab.y),
            rot = 90,
            cex = 2.0
        )
    )
    if (cores == 1) {
        col.l = colorRampPalette(c("blue", "white", "red"))
        aux.cor = "white"
    }
    if (cores == 0) {
        col.l = colorRampPalette(c("white", "gray", "black"))
        aux.cor = "gray"
    }
    cbar = seq(mini, maxi, length.out = 100)
    ckey = list(labels = list(cex = 2.5))
    levelplot(
        t(y[nr:1, ]),
        panel = function(...) {
            panel.levelplot(...)
        },
        col.regions = col.l,
        xlab = list(xl, cex = 2.5),
        ylab = list(yl, cex = 2.5),
        scales = sc,
        at = cbar,
        colorkey = ckey,
        aspect = "fill"
    )
}
