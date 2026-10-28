package com.servicioshogar.controlador;

import com.servicioshogar.dao.UsuarioDAO;
import com.servicioshogar.modelo.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Locale;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {
    private final UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String nombre = val(req,"nombre");
        String correo = val(req,"correo").toLowerCase(Locale.ROOT);
        String telefono = val(req,"telefono");
        String rol = val(req,"rol");
        String pass = req.getParameter("password");
        String confirmar = req.getParameter("confirmar");

        if (nombre.isBlank() || correo.isBlank() || pass == null || confirmar == null
                || pass.isBlank() || confirmar.isBlank()) {
            volver(req,resp,"registro.jsp","Completa los campos obligatorios."); return;
        }
        if (!correo.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            volver(req,resp,"registro.jsp","Ingresa un correo válido."); return;
        }
        if (!rol.equals("COMPRADOR") && !rol.equals("PROVEEDOR")) {
            volver(req,resp,"registro.jsp","Selecciona un tipo de cuenta válido."); return;
        }
        if (pass.length() < 8) {
            volver(req,resp,"registro.jsp","La contraseña debe tener al menos 8 caracteres."); return;
        }
        if (!pass.equals(confirmar)) {
            volver(req,resp,"registro.jsp","Las contraseñas no coinciden."); return;
        }

        Usuario u = new Usuario();
        u.setNombre(nombre); u.setCorreo(correo); u.setTelefono(telefono);
        u.setRol(rol); u.setPasswordHash(BCrypt.hashpw(pass, BCrypt.gensalt(12)));
        try {
            dao.registrar(u);
            resp.sendRedirect(req.getContextPath()+"/login.jsp?registro=ok");
        } catch (SQLException ex) {
            if ("23000".equals(ex.getSQLState())) {
                volver(req,resp,"registro.jsp","Ese correo ya está registrado.");
            } else throw new ServletException("No se pudo registrar el usuario.", ex);
        }
    }
    private String val(HttpServletRequest r,String k) {
        String v=r.getParameter(k); return v==null?"":v.trim();
    }
    private void volver(HttpServletRequest req,HttpServletResponse resp,String pagina,String mensaje)
            throws IOException {
        resp.sendRedirect(req.getContextPath()+"/"+pagina+"?error="+
            URLEncoder.encode(mensaje, StandardCharsets.UTF_8));
    }
}
