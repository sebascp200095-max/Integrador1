<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
private String esc(String s) {
 if(s==null)return "";
 return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#39;");
}
%>
<!DOCTYPE html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Crear cuenta | ServiciosHogar</title><link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css"></head>
<body class="auth-page"><main class="auth-card">
<a class="logo centered" href="${pageContext.request.contextPath}/"><span class="logo-icon">S</span>ServiciosHogar</a>
<h1>Crear una cuenta</h1><p class="muted">Únete como comprador o proveedor.</p>
<% String error=request.getParameter("error"); if(error!=null){ %><div class="alert"><%=esc(error)%></div><% } %>
<form action="${pageContext.request.contextPath}/registro" method="post">
<label>Nombre completo<input class="field" name="nombre" maxlength="100" required></label>
<label>Correo electrónico<input class="field" type="email" name="correo" maxlength="150" required></label>
<label>Teléfono<input class="field" type="tel" name="telefono" maxlength="25"></label>
<label>Tipo de cuenta<select class="field" name="rol" required><option value="COMPRADOR">Quiero contratar servicios</option><option value="PROVEEDOR">Quiero ofrecer servicios</option></select></label>
<label>Contraseña<input class="field" type="password" name="password" minlength="8" required></label>
<label>Confirmar contraseña<input class="field" type="password" name="confirmar" minlength="8" required></label>
<button class="btn btn-primary full" type="submit">Crear cuenta</button></form>
<p class="center muted">¿Ya tienes cuenta? <a class="green" href="${pageContext.request.contextPath}/login.jsp">Inicia sesión</a></p>
</main></body></html>
