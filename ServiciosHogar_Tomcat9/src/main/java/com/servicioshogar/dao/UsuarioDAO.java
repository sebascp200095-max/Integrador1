package com.servicioshogar.dao;

import com.servicioshogar.config.Conexion;
import com.servicioshogar.modelo.Usuario;
import java.sql.*;

public class UsuarioDAO {
    public void registrar(Usuario u) throws SQLException {
        String sql = "INSERT INTO usuarios(nombre,correo,password_hash,telefono,rol) VALUES(?,?,?,?,?)";
        try (Connection con = Conexion.obtenerConexion()) {
            con.setAutoCommit(false);
            try {
                long id;
                try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, u.getNombre());
                    ps.setString(2, u.getCorreo());
                    ps.setString(3, u.getPasswordHash());
                    ps.setString(4, u.getTelefono());
                    ps.setString(5, u.getRol());
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (!rs.next()) throw new SQLException("No se generó el ID.");
                        id = rs.getLong(1);
                    }
                }
                if ("PROVEEDOR".equals(u.getRol())) {
                    try (PreparedStatement ps = con.prepareStatement(
                            "INSERT INTO perfiles_proveedor(usuario_id) VALUES(?)")) {
                        ps.setLong(1, id);
                        ps.executeUpdate();
                    }
                }
                con.commit();
            } catch (SQLException ex) {
                con.rollback();
                throw ex;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    public Usuario buscarPorCorreo(String correo) throws SQLException {
        String sql = "SELECT id,nombre,correo,password_hash,telefono,rol,estado FROM usuarios WHERE correo=?";
        try (Connection con = Conexion.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, correo);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                Usuario u = new Usuario();
                u.setId(rs.getLong("id"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
                u.setPasswordHash(rs.getString("password_hash"));
                u.setTelefono(rs.getString("telefono"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getString("estado"));
                return u;
            }
        }
    }
}
