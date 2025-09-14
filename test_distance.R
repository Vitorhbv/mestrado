source("distance.R")

cidades <- list(
    list(nome = "Belo Horizonte, Brasil", coords = c(-19.9191, -43.9386)),
    list(nome = "Sao Jose dos Campos, Brasil", coords = c(-23.1848, -45.8784)),
    list(nome = "Manaus, Brasil", coords = c(-3.1301, -60.0234)),
    list(nome = "Miami, EUA", coords = c(25.7715, -80.1920)),
    list(nome = "Toquio, Japao", coords = c(35.6812, 139.7619))
)

cat("Distâncias entre cidades (geodésica vs euclidiana) em km:\n\n")

for (i in seq_along(cidades)) {
    for (j in seq((i + 1), length(cidades))) {
        p1 <- cidades[[i]]$coords
        p2 <- cidades[[j]]$coords
        nome1 <- cidades[[i]]$nome
        nome2 <- cidades[[j]]$nome
        g <- geodesic_distance(p1, p2)
        e <- euclidean_distance(p1, p2)
        cat(sprintf(
            "%s <-> %s: geodésica=%.2f km, euclidiana=%.2f km\n",
            nome1,
            nome2,
            g,
            e
        ))
    }
}
