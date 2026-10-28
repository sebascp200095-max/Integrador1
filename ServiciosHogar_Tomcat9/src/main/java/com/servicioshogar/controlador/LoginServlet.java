package com.servicioshogar.controlador;

import com.servicioshogar.dao.UsuarioDAO;
import com.servicioshogar.modelo.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Locale;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest req,HttpServletResponse resp)
            throws ServletException,IOException {
        req.setCharacterEncoding("UTF-8");
        String correo=req.getParameter("correo"), pass=req.getParameter("password");
        if (correo==null || pass==null || correo.isBlank() || pass.isBlank()) {
            resp.sendRedirect(req.getContextPath()+"/login.jsp?error=1"); return;
        }
        try {
            Usuario u=dao.buscarPorCorreo(correo.trim().toLowerCase(Locale.ROOT));
            boolean ok=u!=null && u.getPasswordHash()!=null
                && BCrypt.checkpw(pass,u.getPasswordHash()) && "ACTIVO".equals(u.getEstado());
            if (!ok) { resp.sendRedirect(req.getContextPath()+"/login.jsp?error=1"); return; }
            HttpSession old=req.getSession(false);
            if(old!=null) old.invalidate();
            HttpSession ses=req.getSession(true);
            ses.setAttribute("usuarioId",u.getId());
            ses.setAttribute("nombre",u.getNombre());
            ses.setAttribute("rol",u.getRol());
            ses.setMaxInactiveInterval(1800);
            resp.sendRedirect(req.getContextPath()+"/panel");
        } catch(SQLException ex) {
            throw new ServletException("Error al consultar el usuario. Revisa la conexión MySQL.",ex);
        }
    }
}
