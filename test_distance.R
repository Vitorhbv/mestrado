source("distance.R")

cities <- list(
  list(name = "Belo Horizonte, Brasil", p = c(-19.9191, -43.9386)),
  list(name = "Sao Jose dos Campos, Brasil", p = c(-23.1848, -45.8784)),
  list(name = "Manaus, Brasil", p = c(-3.1301, -60.0234)),
  list(name = "Miami, EUA", p = c(25.7715, -80.1920)),
  list(name = "Toquio, Japao", p = c(35.6812, 139.7619))
)

cat("Distances between cities (geodesic vs euclidean) in kilometers:\n\n")

for (i in seq_len(length(cities) - 1)) {
  for (j in seq((i + 1), length(cities))) {
    name_city1 <- cities[[i]]$name
    name_city2 <- cities[[j]]$name
    p1 <- cities[[i]]$p
    p2 <- cities[[j]]$p
    D <- distance$new(p1, p2)
    geo <- D$geodesic()
    euc <- D$euclidean()
    cat(sprintf(
      "%s <-> %s: geodesic=%.2f km, euclidean=%.2f km\n",
      name_city1,
      name_city2,
      geo,
      euc
    ))
  }
}
