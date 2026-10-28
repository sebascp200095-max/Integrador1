<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map,java.math.BigDecimal" %>
<%!
private String esc(String s){if(s==null)return "";return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#39;");}
private String val(Map<String,Object> m,String k){Object v=m==null?null:m.get(k);return v==null?"":String.valueOf(v);}
%>
<%
String rol=(String)session.getAttribute("rol");
if(session.getAttribute("usuarioId")==null){response.sendRedirect(request.getContextPath()+"/login.jsp");return;}
if(!"PROVEEDOR".equals(rol)){response.sendError(403);return;}
Map<String,Object> perfil=(Map<String,Object>)request.getAttribute("perfil");
String error=(String)session.getAttribute("errorPerfil"); session.removeAttribute("errorPerfil");
boolean disponible=perfil==null || !perfil.containsKey("disponibilidad") || Boolean.TRUE.equals(perfil.get("disponibilidad"));
%>
<!DOCTYPE html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Mi perfil profesional | ServiciosHogar</title><link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css"></head>
<body>
<header class="navbar"><a class="logo" href="${pageContext.request.contextPath}/"><span class="logo-icon">S</span>ServiciosHogar</a><nav><a href="${pageContext.request.contextPath}/panel">Mi panel</a><a href="${pageContext.request.contextPath}/perfiles">Ver perfiles</a><a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a></nav></header>
<main class="section profile-editor"><div class="editor-intro"><span class="eyebrow">TU PRESENCIA PROFESIONAL</span><h1>Mi perfil de proveedor</h1><p class="muted">Cuéntales a tus futuros clientes qué sabes hacer, cuánta experiencia tienes y cuándo pueden contratarte.</p></div>
<% if("ok".equals(request.getParameter("guardado"))){ %><div class="success">¡Perfil actualizado! Los cambios se guardaron correctamente.</div><% } %>
<% if(error!=null){ %><div class="alert"><%=esc(error)%></div><% } %>
<div class="editor-layout"><aside class="card preview-card"><% if(!val(perfil,"fotoUrl").isBlank()){ %><img class="avatar avatar-large provider-photo" src="<%=request.getContextPath()+esc(val(perfil,"fotoUrl"))%>" alt="Mi foto"><% } else { %><div class="avatar avatar-large"><%=esc(perfil==null||val(perfil,"nombre").isBlank()?"P":val(perfil,"nombre").substring(0,1).toUpperCase())%></div><% } %><span class="tag">PERFIL PROFESIONAL</span><h2><%=esc(val(perfil,"nombre").isBlank()?String.valueOf(session.getAttribute("nombre")):val(perfil,"nombre"))%></h2><p class="preview-description"><%=esc(val(perfil,"descripcion").isBlank()?"Tu descripción aparecerá aquí para que los clientes conozcan tus servicios.":val(perfil,"descripcion"))%></p><div class="preview-stat"><strong><%=esc(val(perfil,"experiencia").isBlank()?"0":val(perfil,"experiencia"))%></strong><span>años de experiencia</span></div><div class="preview-stat"><strong>S/ <%=esc(val(perfil,"tarifa").isBlank()?"0.00":val(perfil,"tarifa"))%></strong><span>tarifa referencial</span></div><span class="availability <%=disponible?"is-available":"is-unavailable"%>"><%=disponible?"● Disponible para nuevos trabajos":"● No disponible por ahora"%></span></aside>
<section class="card editor-form"><h2>Información profesional</h2><p class="muted">Mantén tus datos actualizados para generar confianza.</p>
<form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/mi-perfil">
<label for="foto">Foto profesional<input class="field" type="file" id="foto" name="foto" accept="image/jpeg,image/png,image/webp"><span class="field-hint">JPG, PNG o WEBP. Máximo 5 MB. Si no eliges otra foto, se conserva la actual.</span></label>
<label for="nombre">Nombre que verán los clientes <span class="required">*</span><input class="field" id="nombre" name="nombre" maxlength="100" required value="<%=esc(val(perfil,"nombre").isBlank()?String.valueOf(session.getAttribute("nombre")):val(perfil,"nombre"))%>"></label>
<label for="telefono">Teléfono de contacto<input class="field" id="telefono" name="telefono" maxlength="25" value="<%=esc(val(perfil,"telefono"))%>" placeholder="Ej. 999 888 777"></label>
<label for="descripcion">Descripción profesional <span class="required">*</span><textarea class="field" id="descripcion" name="descripcion" rows="5" maxlength="5000" required placeholder="Describe los trabajos que realizas, tus especialidades y qué te diferencia..."><%=esc(val(perfil,"descripcion"))%></textarea><span class="field-hint">Sé claro y honesto sobre los servicios que ofreces.</span></label>
<div class="form-two-cols"><label for="experiencia">Experiencia (años) <span class="required">*</span><input class="field" type="number" id="experiencia" name="experiencia" min="0" max="80" step="1" required value="<%=esc(val(perfil,"experiencia").isBlank()?"0":val(perfil,"experiencia"))%>"></label>
<label for="tarifa">Tarifa referencial (S/) <span class="required">*</span><input class="field" type="number" id="tarifa" name="tarifa" min="0" max="99999999" step="0.01" required value="<%=esc(val(perfil,"tarifa").isBlank()?"0.00":val(perfil,"tarifa"))%>"></label></div>
<label class="availability-toggle"><input type="checkbox" name="disponibilidad" <%=disponible?"checked":""%>> <span><strong>Estoy disponible para nuevos trabajos</strong><small>Si desactivas esta opción, los clientes sabrán que no estás aceptando solicitudes por ahora.</small></span></label>
<div class="form-actions"><a class="btn btn-outline" href="${pageContext.request.contextPath}/panel">Cancelar</a><button class="btn btn-primary" type="submit">Guardar cambios</button></div>
</form></section></div></main>
<footer class="footer"><span>ServiciosHogar · Conectando hogares con profesionales</span><a href="${pageContext.request.contextPath}/perfiles">Explorar proveedores</a></footer>
</body></html>
