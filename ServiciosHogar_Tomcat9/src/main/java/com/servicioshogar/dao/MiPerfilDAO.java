package com.servicioshogar.dao;

import com.servicioshogar.config.Conexion;
import java.math.BigDecimal;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

public class MiPerfilDAO {
    public Map<String,Object> obtener(long usuarioId) throws SQLException {
        String sql = "SELECT u.nombre,u.telefono,pp.descripcion,pp.foto_url,pp.experiencia_anios,pp.tarifa_referencial,pp.disponibilidad "
                   + "FROM usuarios u JOIN perfiles_proveedor pp ON pp.usuario_id=u.id WHERE u.id=? AND u.rol='PROVEEDOR'";
        try (Connection c=Conexion.obtenerConexion(); PreparedStatement ps=c.prepareStatement(sql)) {
            ps.setLong(1, usuarioId);
            try (ResultSet rs=ps.executeQuery()) {
                if (!rs.next()) return null;
                Map<String,Object> m=new LinkedHashMap<>();
                m.put("nombre",rs.getString("nombre")); m.put("telefono",rs.getString("telefono"));
                m.put("descripcion",rs.getString("descripcion")); m.put("fotoUrl",rs.getString("foto_url")); m.put("experiencia",rs.getInt("experiencia_anios"));
                m.put("tarifa",rs.getBigDecimal("tarifa_referencial")); m.put("disponibilidad",rs.getBoolean("disponibilidad"));
                return m;
            }
        }
    }

    public void guardar(long usuarioId, String nombre, String telefono, String descripcion,
                        int experiencia, BigDecimal tarifa, boolean disponibilidad, String fotoUrl) throws SQLException {
        String usuarioSql="UPDATE usuarios SET nombre=?, telefono=? WHERE id=? AND rol='PROVEEDOR'";
        String perfilSql="INSERT INTO perfiles_proveedor(usuario_id,descripcion,experiencia_anios,tarifa_referencial,disponibilidad,foto_url) "
                + "VALUES(?,?,?,?,?,?) ON DUPLICATE KEY UPDATE descripcion=VALUES(descripcion),experiencia_anios=VALUES(experiencia_anios),tarifa_referencial=VALUES(tarifa_referencial),disponibilidad=VALUES(disponibilidad),foto_url=COALESCE(VALUES(foto_url),foto_url)";
        try (Connection c=Conexion.obtenerConexion()) {
            c.setAutoCommit(false);
            try (PreparedStatement u=c.prepareStatement(usuarioSql); PreparedStatement p=c.prepareStatement(perfilSql)) {
                u.setString(1,nombre); u.setString(2,telefono.isBlank()?null:telefono); u.setLong(3,usuarioId);
                if(u.executeUpdate()!=1) throw new SQLException("No se encontró la cuenta de proveedor.");
                p.setLong(1,usuarioId); p.setString(2,descripcion); p.setInt(3,experiencia); p.setBigDecimal(4,tarifa); p.setBoolean(5,disponibilidad); p.setString(6,(fotoUrl==null || fotoUrl.isBlank())?null:fotoUrl);
                p.executeUpdate(); c.commit();
            } catch(SQLException ex) { c.rollback(); throw ex; }
            finally { c.setAutoCommit(true); }
        }
    }
}
