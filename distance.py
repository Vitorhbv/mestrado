import numpy as np

R = 6371  # Earth radius in kilometers


class distance:
    """Class to calculate distances between two points on Earth given their latitude and longitude."""

    def __init__(self, P1, P2):

        self.P1 = P1
        self.P2 = P2

    def geodesic(self):

        (latitude_P1, longitude_P1) = self.P1
        (latitude_P2, longitude_P2) = self.P2

        D = R * np.arccos(
            np.cos(np.radians(latitude_P1))
            * np.cos(np.radians(latitude_P2))
            * np.cos(np.radians(longitude_P2) - np.radians(longitude_P1))
            + np.sin(np.radians(latitude_P1)) * np.sin(np.radians(latitude_P2))
        )
        return D

    def euclidean(self):

        (latitude_P1, longitude_P1) = self.P1
        (latitude_P2, longitude_P2) = self.P2

        x_1 = R * np.cos(np.radians(latitude_P1)) * np.cos(np.radians(longitude_P1))
        y_1 = R * np.cos(np.radians(latitude_P1)) * np.sin(np.radians(longitude_P1))
        z_1 = R * np.sin(np.radians(latitude_P1))

        x_2 = R * np.cos(np.radians(latitude_P2)) * np.cos(np.radians(longitude_P2))
        y_2 = R * np.cos(np.radians(latitude_P2)) * np.sin(np.radians(longitude_P2))
        z_2 = R * np.sin(np.radians(latitude_P2))

        u_1 = np.array([x_1, y_1, z_1])
        u_2 = np.array([x_2, y_2, z_2])

        D = np.linalg.norm(u_1 - u_2)

        return D
