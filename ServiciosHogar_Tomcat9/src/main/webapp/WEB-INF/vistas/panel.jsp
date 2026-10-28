<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
private String esc(String s) { if(s==null)return ""; return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#39;"); }
%>
<%
String nombre=(String)session.getAttribute("nombre");
String rol=(String)session.getAttribute("rol");
if(nombre==null || rol==null){response.sendRedirect(request.getContextPath()+"/login.jsp");return;}
%>
<!DOCTYPE html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Mi panel | ServiciosHogar</title><link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css"></head>
<body><header class="navbar"><a class="logo" href="${pageContext.request.contextPath}/"><span class="logo-icon">S</span>ServiciosHogar</a>
<div>Hola, <strong><%=esc(nombre)%></strong> · <a class="green" href="${pageContext.request.contextPath}/logout">Cerrar sesión</a></div></header>
<main class="section"><span class="eyebrow">PANEL PERSONAL</span><h1>Bienvenido, <%=esc(nombre)%></h1><p class="muted">Tipo de cuenta: <strong><%=esc(rol)%></strong></p>
<% if("ok".equals(request.getParameter("contratacion"))){ %><div class="success">Tu solicitud se registró correctamente y está pendiente de respuesta del proveedor.</div><% } %>
<div class="grid">
<article class="card"><h3>Perfiles de proveedores</h3><p>Consulta descripciones, experiencia y puntuaciones para comparar opciones.</p><a class="btn btn-primary" href="${pageContext.request.contextPath}/perfiles">Ver proveedores</a></article>
<article class="card"><h3>Catálogo de servicios</h3><p>Busca servicios publicados por proveedores.</p><a class="btn btn-primary" href="${pageContext.request.contextPath}/servicios">Explorar catálogo</a></article>
<% if("PROVEEDOR".equals(rol)){ %>
<article class="card"><h3>Mi perfil profesional</h3><p>Actualiza tu descripción, experiencia, tarifa y disponibilidad para que los clientes te conozcan mejor.</p><a class="btn btn-primary" href="${pageContext.request.contextPath}/mi-perfil">Editar mi perfil</a></article>
<article class="card"><h3>Publicar un servicio</h3><p>Agrega una oferta al catálogo.</p><a class="btn btn-outline" href="${pageContext.request.contextPath}/servicios#publicar">Publicar servicio</a></article>
<% } else if("COMPRADOR".equals(rol)){ %>
<article class="card"><h3>Mis solicitudes</h3><p>Este módulo se añadirá en la siguiente etapa.</p><span class="muted">Próximamente</span></article>
<% } else { %><article class="card"><h3>Administración</h3><p>El panel administrativo se conectará después.</p></article><% } %>
</div></main></body></html>
