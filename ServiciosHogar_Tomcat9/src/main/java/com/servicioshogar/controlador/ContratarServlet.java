package com.servicioshogar.controlador;
import com.servicioshogar.config.Conexion;
import javax.servlet.*;import javax.servlet.annotation.WebServlet;import javax.servlet.http.*;
import java.io.IOException;import java.sql.*;import java.math.BigDecimal;
@WebServlet("/contratar")
public class ContratarServlet extends HttpServlet {
 protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException{
  HttpSession s=req.getSession(false);if(s==null||s.getAttribute("usuarioId")==null){resp.sendRedirect(req.getContextPath()+"/login.jsp");return;}
  if(!"COMPRADOR".equals(s.getAttribute("rol"))){resp.sendError(403,"Solo las cuentas de comprador pueden contratar servicios.");return;}
  try(Connection c=Conexion.obtenerConexion();PreparedStatement p=c.prepareStatement("SELECT s.id,s.titulo,s.descripcion,s.precio,u.nombre proveedor FROM servicios s JOIN perfiles_proveedor pp ON pp.id=s.proveedor_id JOIN usuarios u ON u.id=pp.usuario_id WHERE s.id=? AND s.activo=TRUE")){
   p.setLong(1,Long.parseLong(req.getParameter("servicio")));try(ResultSet r=p.executeQuery()){if(!r.next()){resp.sendError(404,"Servicio no encontrado.");return;}req.setAttribute("servicioId",r.getLong("id"));req.setAttribute("titulo",r.getString("titulo"));req.setAttribute("descripcionServicio",r.getString("descripcion"));req.setAttribute("precio",r.getBigDecimal("precio"));req.setAttribute("proveedor",r.getString("proveedor"));req.getRequestDispatcher("/WEB-INF/vistas/contratar.jsp").forward(req,resp);}
  }catch(NumberFormatException e){resp.sendError(400,"Identificador de servicio inválido.");}catch(SQLException e){throw new ServletException("No se pudo cargar el servicio.",e);}
 }
 protected void doPost(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException{
  req.setCharacterEncoding("UTF-8");HttpSession s=req.getSession(false);if(s==null||s.getAttribute("usuarioId")==null||!"COMPRADOR".equals(s.getAttribute("rol"))){resp.sendError(403);return;}
  try{long id=Long.parseLong(req.getParameter("servicioId"));String problema=req.getParameter("problema"),direccion=req.getParameter("direccion"),fecha=req.getParameter("fecha");
   if(problema==null||problema.isBlank()||direccion==null||direccion.isBlank()||fecha==null||fecha.isBlank()){resp.sendRedirect(req.getContextPath()+"/contratar?servicio="+id+"&error=datos");return;}
   try(Connection c=Conexion.obtenerConexion();PreparedStatement p=c.prepareStatement("INSERT INTO solicitudes(comprador_id,servicio_id,descripcion_problema,direccion,fecha_solicitada,precio_acordado) SELECT ?,s.id,?,?,?,s.precio FROM servicios s WHERE s.id=? AND s.activo=TRUE")){
    p.setLong(1,(Long)s.getAttribute("usuarioId"));p.setString(2,problema.trim());p.setString(3,direccion.trim());p.setTimestamp(4,Timestamp.valueOf(fecha.replace("T"," ")+":00"));p.setLong(5,id);if(p.executeUpdate()==0){resp.sendError(404,"Servicio no encontrado.");return;}
   }resp.sendRedirect(req.getContextPath()+"/panel?contratacion=ok");
  }catch(IllegalArgumentException|SQLException e){if(e instanceof SQLException)throw new ServletException("No se pudo registrar la solicitud.",e);resp.sendRedirect(req.getContextPath()+"/servicios?error=datos");}
 }
}