package com.servicioshogar.controlador;

import com.servicioshogar.dao.ServicioDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/servicios")
public class ServiciosServlet extends HttpServlet {
    private final ServicioDAO dao = new ServicioDAO();

    @Override
    protected void doGet(HttpServletRequest req,HttpServletResponse resp)
            throws ServletException,IOException {
        try {
            req.setAttribute("servicios", dao.listar(req.getParameter("q"), req.getParameter("categoria")));
            req.setAttribute("categorias", dao.categorias());
            req.getRequestDispatcher("/WEB-INF/vistas/servicios.jsp").forward(req,resp);
        } catch(SQLException ex) {
            throw new ServletException("No se pudo cargar el catálogo.",ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req,HttpServletResponse resp)
            throws ServletException,IOException {
        HttpSession s=req.getSession(false);
        if(s==null || s.getAttribute("usuarioId")==null ||
           !"PROVEEDOR".equals(s.getAttribute("rol"))) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN,"Solo proveedores registrados pueden publicar servicios.");
            return;
        }
        req.setCharacterEncoding("UTF-8");
        try {
            String titulo=req.getParameter("titulo");
            String descripcion=req.getParameter("descripcion");
            String cat=req.getParameter("categoriaId");
            String precio=req.getParameter("precio");
            if(titulo==null || titulo.isBlank() || descripcion==null || descripcion.isBlank()
                    || cat==null || precio==null || new java.math.BigDecimal(precio).signum()<0) {
                resp.sendRedirect(req.getContextPath()+"/servicios?error=datos"); return;
            }
            dao.crear((Long)s.getAttribute("usuarioId"),Integer.parseInt(cat),
                titulo.trim(),descripcion.trim(),new java.math.BigDecimal(precio));
            resp.sendRedirect(req.getContextPath()+"/servicios?publicado=ok");
        } catch(NumberFormatException ex) {
            resp.sendRedirect(req.getContextPath()+"/servicios?error=datos");
        } catch(SQLException ex) {
            throw new ServletException("No se pudo publicar el servicio.",ex);
        }
    }
}
