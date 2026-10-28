package com.servicioshogar.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class Conexion {
    private static final String URL =
        "jdbc:mysql://localhost:3306/servicios_hogar?serverTimezone=America/Lima&characterEncoding=UTF-8";
    private static final String USUARIO = "root";
    private static final String CLAVE = ""; // Cambiar si tu MySQL tiene contraseña.

    private Conexion() {}

    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró MySQL Connector/J. En NetBeans usa Clean and Build y verifica la dependencia mysql-connector-j del pom.xml.", e);
        }
        return DriverManager.getConnection(URL, USUARIO, CLAVE);
    }
}
