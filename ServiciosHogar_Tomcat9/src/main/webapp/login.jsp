<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Iniciar sesión | ServiciosHogar</title><link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css"></head>
<body class="auth-page"><main class="auth-card">
<a class="logo centered" href="${pageContext.request.contextPath}/"><span class="logo-icon">S</span>ServiciosHogar</a>
<h1>¡Qué bueno verte de nuevo!</h1><p class="muted">Ingresa para gestionar tus servicios desde un solo lugar.</p>
<% if("ok".equals(request.getParameter("registro"))){ %><div class="success">Tu cuenta se creó correctamente. Ya puedes iniciar sesión.</div><% } %>
<% if(request.getParameter("error")!=null){ %><div class="alert">No pudimos validar tus datos. Revisa tu correo y contraseña, e inténtalo nuevamente.</div><% } %>
<form action="${pageContext.request.contextPath}/login" method="post">
<label>Correo electrónico<input class="field" type="email" name="correo" placeholder="tucorreo@ejemplo.com" autocomplete="username" required></label>
<label>Contraseña<input class="field" type="password" name="password" placeholder="Ingresa tu contraseña" autocomplete="current-password" required></label>
<button class="btn btn-primary full" type="submit">Iniciar sesión</button></form>
<div class="auth-note">Encuentra proveedores, compara perfiles y solicita servicios para tu hogar.</div>
<p class="center muted">¿Aún no tienes cuenta? <a class="green" href="${pageContext.request.contextPath}/registro.jsp">Crear cuenta</a></p>
</main></body></html>