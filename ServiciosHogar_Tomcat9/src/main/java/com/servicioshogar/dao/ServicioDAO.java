package com.servicioshogar.dao;

import com.servicioshogar.config.Conexion;
import java.sql.*;
import java.util.*;

public class ServicioDAO {
    public List<Map<String,Object>> listar(String busqueda, String categoria) throws SQLException {
        List<Map<String,Object>> lista = new ArrayList<>();
        String sql = """
            SELECT s.id,s.titulo,s.descripcion,s.precio,s.imagen_url,c.nombre AS categoria,
                   u.nombre AS proveedor, pp.id AS proveedor_id,
                   pp.descripcion AS perfil, pp.experiencia_anios
            FROM servicios s
            JOIN categorias c ON c.id=s.categoria_id
            JOIN perfiles_proveedor pp ON pp.id=s.proveedor_id
            JOIN usuarios u ON u.id=pp.usuario_id
            WHERE s.activo=TRUE AND u.estado='ACTIVO'
              AND (?='' OR s.titulo LIKE ? OR s.descripcion LIKE ? OR u.nombre LIKE ?)
              AND (?='' OR c.nombre=?)
            ORDER BY s.fecha_creacion DESC
            """;
        String filtro = busqueda == null ? "" : busqueda.trim();
        String cat = categoria == null ? "" : categoria.trim();
        try (Connection con = Conexion.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, filtro);
            ps.setString(2, "%" + filtro + "%");
            ps.setString(3, "%" + filtro + "%");
            ps.setString(4, "%" + filtro + "%");
            ps.setString(5, cat);
            ps.setString(6, cat);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String,Object> m = new LinkedHashMap<>();
                    m.put("id", rs.getLong("id"));
                    m.put("titulo", rs.getString("titulo"));
                    m.put("descripcion", rs.getString("descripcion"));
                    m.put("precio", rs.getBigDecimal("precio"));
                    m.put("categoria", rs.getString("categoria"));
                    m.put("proveedor", rs.getString("proveedor"));
                    m.put("proveedorId", rs.getLong("proveedor_id"));
                    m.put("perfil", rs.getString("perfil"));
                    m.put("experiencia", rs.getInt("experiencia_anios"));
                    m.put("imagenUrl", rs.getString("imagen_url"));
                    lista.add(m);
                }
            }
        }
        return lista;
    }

    public List<String> categorias() throws SQLException {
        List<String> lista = new ArrayList<>();
        try (Connection con = Conexion.obtenerConexion();
             PreparedStatement ps = con.prepareStatement("SELECT nombre FROM categorias ORDER BY nombre");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(rs.getString(1));
        }
        return lista;
    }

    public void crear(long usuarioId, int categoriaId, String titulo,
                      String descripcion, java.math.BigDecimal precio) throws SQLException {
        String buscarPerfil = "SELECT id FROM perfiles_proveedor WHERE usuario_id=?";
        String insert = "INSERT INTO servicios(proveedor_id,categoria_id,titulo,descripcion,precio) VALUES(?,?,?,?,?)";
        try (Connection con = Conexion.obtenerConexion()) {
            long perfilId;
            try (PreparedStatement ps = con.prepareStatement(buscarPerfil)) {
                ps.setLong(1, usuarioId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) throw new SQLException("No existe el perfil del proveedor.");
                    perfilId = rs.getLong(1);
                }
            }
            try (PreparedStatement ps = con.prepareStatement(insert)) {
                ps.setLong(1, perfilId);
                ps.setInt(2, categoriaId);
                ps.setString(3, titulo);
                ps.setString(4, descripcion);
                ps.setBigDecimal(5, precio);
                ps.executeUpdate();
            }
        }
    }
}
