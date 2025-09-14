from distance import distance

cities = [
    ("Belo Horizonte, Brasil", (-19.9191, -43.9386)),
    ("Sao Jose dos Campos, Brasil", (-23.1848, -45.8784)),
    ("Manaus, Brasil", (-3.1301, -60.0234)),
    ("Miami, EUA", (25.7715, -80.1920)),
    ("Toquio, Japao", (35.6812, 139.7619)),
]


def main():
    print("Distances between cities (geodesic vs euclidean) in kilometers:\n")
    for i in range(len(cities)):
        for j in range(i + 1, len(cities)):
            name_city1, p1 = cities[i]
            name_city2, p2 = cities[j]
            D = distance(p1, p2)
            geo = D.geodesic()
            euc = D.euclidean()
            print(f"{name_city1} <-> {name_city2}: geodesic={geo:.2f} km, euclidean={euc:.2f} km")


if __name__ == "__main__":
    main()
