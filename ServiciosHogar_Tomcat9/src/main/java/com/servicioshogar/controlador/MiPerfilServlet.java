package com.servicioshogar.controlador;

import com.servicioshogar.dao.MiPerfilDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Map;
import java.nio.file.*;
import java.util.UUID;

@WebServlet("/mi-perfil")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 6 * 1024 * 1024)
public class MiPerfilServlet extends HttpServlet {
    private final MiPerfilDAO dao = new MiPerfilDAO();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        if(session==null || session.getAttribute("usuarioId")==null){resp.sendRedirect(req.getContextPath()+"/login.jsp");return;}
        if(!"PROVEEDOR".equals(String.valueOf(session.getAttribute("rol")))){resp.sendError(HttpServletResponse.SC_FORBIDDEN,"Esta sección es solo para proveedores.");return;}
        try {
            Map<String,Object> perfil=dao.obtener(((Number)session.getAttribute("usuarioId")).longValue());
            req.setAttribute("perfil",perfil);
            req.getRequestDispatcher("/WEB-INF/vistas/mi-perfil.jsp").forward(req,resp);
        } catch(SQLException ex){throw new ServletException("No se pudo cargar el perfil del proveedor.",ex);}
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session=req.getSession(false);
        if(session==null || session.getAttribute("usuarioId")==null){resp.sendRedirect(req.getContextPath()+"/login.jsp");return;}
        if(!"PROVEEDOR".equals(String.valueOf(session.getAttribute("rol")))){resp.sendError(HttpServletResponse.SC_FORBIDDEN);return;}
        String nombre=valor(req,"nombre"), telefono=valor(req,"telefono"), descripcion=valor(req,"descripcion");
        String exp=valor(req,"experiencia"), tarifa=valor(req,"tarifa");
        if(nombre.isBlank() || descripcion.isBlank() || exp.isBlank() || tarifa.isBlank()) { volver(req,resp,"Completa el nombre, la descripción, la experiencia y la tarifa."); return; }
        try {
            int experiencia=Integer.parseInt(exp); BigDecimal precio=new BigDecimal(tarifa);
            if(nombre.length()>100 || telefono.length()>25 || descripcion.length()>5000 || experiencia<0 || experiencia>80 || precio.compareTo(BigDecimal.ZERO)<0 || precio.compareTo(new BigDecimal("99999999"))>0) {
                volver(req,resp,"Revisa los datos: la experiencia debe ser de 0 a 80 años y la tarifa no puede ser negativa."); return;
            }
            boolean disponible="on".equals(req.getParameter("disponibilidad"));
            long usuarioId=((Number)session.getAttribute("usuarioId")).longValue();
            String fotoUrl = null;
            Part foto = req.getPart("foto");
            if (foto != null && foto.getSize() > 0) {
                String tipo = foto.getContentType()==null?"":foto.getContentType().toLowerCase();
                if (!tipo.equals("image/jpeg") && !tipo.equals("image/png") && !tipo.equals("image/webp")) {
                    volver(req,resp,"La foto debe ser JPG, PNG o WEBP."); return;
                }
                String ext = tipo.equals("image/png")?".png":tipo.equals("image/webp")?".webp":".jpg";
                String carpetaReal = getServletContext().getRealPath("/img/proveedores");
                if (carpetaReal == null) throw new ServletException("No se pudo acceder a la carpeta de imágenes del proyecto.");
                Path carpeta = Paths.get(carpetaReal); Files.createDirectories(carpeta);
                String archivo = "proveedor_"+usuarioId+"_"+UUID.randomUUID().toString().replace("-","")+ext;
                try (java.io.InputStream in = foto.getInputStream()) { Files.copy(in, carpeta.resolve(archivo), StandardCopyOption.REPLACE_EXISTING); }
                fotoUrl = "/img/proveedores/"+archivo;
            }
            dao.guardar(usuarioId,nombre,telefono,descripcion,experiencia,precio,disponible,fotoUrl);
            session.setAttribute("nombre",nombre);
            resp.sendRedirect(req.getContextPath()+"/mi-perfil?guardado=ok");
        } catch(NumberFormatException ex){ volver(req,resp,"Ingresa una experiencia y una tarifa válidas."); }
          catch(SQLException ex){throw new ServletException("No se pudo guardar el perfil.",ex);}
    }
    private String valor(HttpServletRequest req,String clave){String v=req.getParameter(clave);return v==null?"":v.trim();}
    private void volver(HttpServletRequest req,HttpServletResponse resp,String mensaje)throws IOException {
        req.getSession().setAttribute("errorPerfil",mensaje); resp.sendRedirect(req.getContextPath()+"/mi-perfil");
    }
}
