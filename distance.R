# distance.R
# Implementação em R usando R6 que espelha a classe `distance` em Python.
#
# Classe R6 `distance`:
# - campos: P1 (c(lat, lon)), P2 (c(lat, lon))
# - métodos: geodesic(), euclidean()
#
# Uso:
#   dobj <- distance$new(c(lat1, lon1), c(lat2, lon2))
#   dobj$geodesic()
#   dobj$euclidean()

library(R6)

R <- 6371 # raio da Terra em km

deg2rad <- function(deg) {
  deg * pi / 180
}

distance <- R6Class(
  "distance",
  public = list(
    P1 = NULL,
    P2 = NULL,
    initialize = function(P1, P2) {
      self$P1 <- as.numeric(P1)
      self$P2 <- as.numeric(P2)
    },
    geodesic = function() {
      lat1 <- deg2rad(self$P1[1])
      lon1 <- deg2rad(self$P1[2])
      lat2 <- deg2rad(self$P2[1])
      lon2 <- deg2rad(self$P2[2])

      # fórmula do cosseno esférico
      cos_angle <- cos(lat1) *
        cos(lat2) *
        cos(lon2 - lon1) +
        sin(lat1) * sin(lat2)
      d <- R * acos(cos_angle)
      d
    },
    euclidean = function() {
      lat1 <- deg2rad(self$P1[1])
      lon1 <- deg2rad(self$P1[2])
      lat2 <- deg2rad(self$P2[1])
      lon2 <- deg2rad(self$P2[2])

      x1 <- R * cos(lat1) * cos(lon1)
      y1 <- R * cos(lat1) * sin(lon1)
      z1 <- R * sin(lat1)

      x2 <- R * cos(lat2) * cos(lon2)
      y2 <- R * cos(lat2) * sin(lon2)
      z2 <- R * sin(lat2)

      sqrt((x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2)
    }
  )
)
