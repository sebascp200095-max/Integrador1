package com.servicioshogar.dao;

import com.servicioshogar.config.Conexion;
import java.sql.*;
import java.util.*;

public class PerfilProveedorDAO {
    public List<Map<String,Object>> listar() throws SQLException {
        List<Map<String,Object>> out = new ArrayList<>();
        String sql = """
            SELECT pp.id, pp.usuario_id, u.nombre, pp.descripcion, pp.foto_url,
                   pp.experiencia_anios, pp.tarifa_referencial, pp.disponibilidad,
                   COALESCE(GROUP_CONCAT(DISTINCT c.nombre ORDER BY c.nombre SEPARATOR ', '),
                            'Servicios para el hogar') AS categorias,
                   COUNT(DISTINCT r.id) AS total_resenas,
                   COALESCE(AVG(r.puntuacion), 0) AS promedio
            FROM perfiles_proveedor pp
            JOIN usuarios u ON u.id = pp.usuario_id
            LEFT JOIN servicios s ON s.proveedor_id = pp.id AND s.activo = TRUE
            LEFT JOIN categorias c ON c.id = s.categoria_id
            LEFT JOIN resenas r ON r.proveedor_id = pp.id
            WHERE u.estado = 'ACTIVO'
            GROUP BY pp.id, pp.usuario_id, u.nombre, pp.descripcion, pp.foto_url,
                     pp.experiencia_anios, pp.tarifa_referencial, pp.disponibilidad
            ORDER BY promedio DESC, u.nombre
            """;
        try (Connection c = Conexion.obtenerConexion();
             PreparedStatement p = c.prepareStatement(sql);
             ResultSet r = p.executeQuery()) {
            while (r.next()) {
                Map<String,Object> m = new LinkedHashMap<>();
                m.put("id", r.getLong("id"));
                m.put("usuarioId", r.getLong("usuario_id"));
                m.put("nombre", r.getString("nombre"));
                m.put("descripcion", r.getString("descripcion"));
                m.put("fotoUrl", r.getString("foto_url"));
                m.put("experiencia", r.getInt("experiencia_anios"));
                m.put("tarifa", r.getBigDecimal("tarifa_referencial"));
                m.put("disponible", r.getBoolean("disponibilidad"));
                m.put("categorias", r.getString("categorias"));
                m.put("resenas", r.getInt("total_resenas"));
                m.put("promedio", r.getDouble("promedio"));
                out.add(m);
            }
        }
        return out;
    }
}
