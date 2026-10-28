package com.servicioshogar.controlador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/panel")
public class PanelServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req,HttpServletResponse resp)
            throws ServletException,IOException {
        HttpSession s=req.getSession(false);
        if(s==null || s.getAttribute("usuarioId")==null) {
            resp.sendRedirect(req.getContextPath()+"/login.jsp"); return;
        }
        req.getRequestDispatcher("/WEB-INF/vistas/panel.jsp").forward(req,resp);
    }
}
