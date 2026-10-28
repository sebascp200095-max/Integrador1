package com.servicioshogar.controlador;

import com.servicioshogar.dao.PerfilProveedorDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;

@WebServlet("/perfiles")
public class PerfilesServlet extends HttpServlet {
    private final PerfilProveedorDAO dao = new PerfilProveedorDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("perfiles", dao.listar());
        } catch (SQLException e) {
            getServletContext().log("No se pudieron cargar los perfiles de proveedores", e);
            req.setAttribute("perfiles", Collections.emptyList());
            req.setAttribute("errorPerfiles",
                "Por el momento no se pudo conectar con la base de datos. Verifica MySQL y la dependencia MySQL Connector/J en NetBeans.");
        }
        req.getRequestDispatcher("/WEB-INF/vistas/perfiles.jsp").forward(req, resp);
    }
}
