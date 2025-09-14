# distance.R
# Funções para cálculo de distância geodésica e euclidiana entre dois pontos (lat, lon)

R <- 6371 # raio da Terra em km

deg2rad <- function(deg) {
  return(deg * pi / 180)
}

geodesic_distance <- function(p1, p2) {
  # p1 e p2 são vetores c(lat, lon) em graus
  lat1 <- deg2rad(p1[1])
  lon1 <- deg2rad(p1[2])
  lat2 <- deg2rad(p2[1])
  lon2 <- deg2rad(p2[2])

  # fórmula do cosseno esférico
  d <- R *
    acos(cos(lat1) * cos(lat2) * cos(lon2 - lon1) + sin(lat1) * sin(lat2))
  return(d)
}

euclidean_distance <- function(p1, p2) {
  # converte lat/lon para coordenadas cartesianas e calcula norma da diferença
  lat1 <- deg2rad(p1[1])
  lon1 <- deg2rad(p1[2])
  lat2 <- deg2rad(p2[1])
  lon2 <- deg2rad(p2[2])

  x1 <- R * cos(lat1) * cos(lon1)
  y1 <- R * cos(lat1) * sin(lon1)
  z1 <- R * sin(lat1)

  x2 <- R * cos(lat2) * cos(lon2)
  y2 <- R * cos(lat2) * sin(lon2)
  z2 <- R * sin(lat2)

  d <- sqrt((x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2)
  return(d)
}
