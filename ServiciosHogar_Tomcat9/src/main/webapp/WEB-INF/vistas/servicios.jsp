<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.math.BigDecimal" %>
<%!
private String esc(String s){if(s==null)return "";return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#39;");}
%>
<!DOCTYPE html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Servicios | ServiciosHogar</title><link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css"></head><body>
<header class="navbar"><a class="logo" href="${pageContext.request.contextPath}/"><span class="logo-icon">S</span>ServiciosHogar</a>
<nav><a href="${pageContext.request.contextPath}/perfiles">Proveedores</a><a href="${pageContext.request.contextPath}/panel">Mi panel</a><a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a></nav></header>
<main class="section"><span class="eyebrow">CATÁLOGO</span><h1>Encuentra un servicio</h1><p class="muted">Busca por nombre, descripción o proveedor y filtra por categoría.</p>
<form class="searchbar" method="get" action="${pageContext.request.contextPath}/servicios">
<input class="field" name="q" placeholder="Ej. reparación de lavadora" value="<%=esc(request.getParameter("q"))%>">
<select class="field" name="categoria"><option value="">Todas las categorías</option>
<% List<String> cats=(List<String>)request.getAttribute("categorias"); String selected=request.getParameter("categoria"); if(cats!=null)for(String c:cats){ %>
<option value="<%=esc(c)%>" <%=c.equals(selected)?"selected":""%>><%=esc(c)%></option><% } %></select>
<button class="btn btn-primary" type="submit">Buscar</button></form>
<% if("ok".equals(request.getParameter("publicado"))){ %><div class="success">Servicio publicado correctamente.</div><% } %>
<% if("datos".equals(request.getParameter("error"))){ %><div class="alert">Revisa los datos del servicio.</div><% } %>
<div class="grid">
<% List<Map<String,Object>> lista=(List<Map<String,Object>>)request.getAttribute("servicios");
if(lista==null||lista.isEmpty()){ %><article class="card"><h3>Aún no hay servicios publicados</h3><p>Registra un proveedor y publica el primer servicio.</p></article>
<% } else for(Map<String,Object> s:lista){ %>
<article class="card"><span class="tag"><%=esc((String)s.get("categoria"))%></span><h3><%=esc((String)s.get("titulo"))%></h3>
<p><%=esc((String)s.get("descripcion"))%></p><p class="muted">Proveedor: <strong><%=esc((String)s.get("proveedor"))%></strong></p>
<p class="price">S/ <%=s.get("precio")%></p><p class="muted">Experiencia: <%=s.get("experiencia")%> años</p><div class="card-actions"><a class="btn btn-outline" href="${pageContext.request.contextPath}/perfiles">Ver perfiles</a><% if("COMPRADOR".equals(session.getAttribute("rol"))){ %><a class="btn btn-primary" href="${pageContext.request.contextPath}/contratar?servicio=<%=s.get("id")%>">Contratar</a><% } else if(session.getAttribute("usuarioId")==null){ %><a class="btn btn-primary" href="${pageContext.request.contextPath}/login.jsp">Iniciar sesión para contratar</a><% } %></div></article>
<% } %></div>

<% if("PROVEEDOR".equals(session.getAttribute("rol"))){ %>
<section class="publish" id="publicar"><h2>Publicar un servicio</h2><p class="muted">Completa los datos de tu oferta.</p>
<form method="post" action="${pageContext.request.contextPath}/servicios">
<label>Nombre del servicio<input class="field" name="titulo" maxlength="120" required></label>
<label>Descripción<textarea class="field" name="descripcion" rows="4" required></textarea></label>
<label>Categoría<select class="field" name="categoriaId" required><option value="">Selecciona</option>
<% if(cats!=null) for(int i=0;i<cats.size();i++){ %><option value="<%=categoriaIdPorNombre(cats.get(i))%>"><%=esc(cats.get(i))%></option><% } %>
</select></label>
<label>Precio referencial (S/)<input class="field" type="number" name="precio" min="0" step="0.01" required></label>
<button class="btn btn-primary" type="submit">Publicar servicio</button></form>
</section>
<% } %>
</main></body></html>
<%!
private int categoriaIdPorNombre(String nombre) {
 // Los IDs iniciales se insertan en el orden de las categorías del SQL, pero pueden cambiar.
 // Se reemplaza por el identificador real en una versión posterior si se administran categorías.
 switch(nombre){
 case "Electricidad": return 1;
 case "Gasfitería": return 2;
 case "Reparación de electrodomésticos": return 3;
 case "Pintura": return 4;
 case "Carpintería": return 5;
 case "Mantenimiento general": return 6;
 default: return 1;
 }
}
%>
