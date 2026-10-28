<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html><html lang="es"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>ServiciosHogar | Profesionales para tu hogar</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head><body>
<header class="navbar">
<a class="logo" href="${pageContext.request.contextPath}/"><span class="logo-icon">S</span>ServiciosHogar</a>
<nav><a href="${pageContext.request.contextPath}/servicios">Servicios</a><a href="${pageContext.request.contextPath}/perfiles">Proveedores</a>
<a href="#como">Cómo funciona</a><a href="${pageContext.request.contextPath}/login.jsp">Iniciar sesión</a>
<a class="btn btn-primary" href="${pageContext.request.contextPath}/registro.jsp">Crear cuenta</a></nav>
</header>
<main>
<section class="hero"><div>
<span class="eyebrow">SOLUCIONES PARA TU HOGAR</span>
<h1>Encuentra al profesional ideal para tu hogar.</h1>
<p>Compara servicios, consulta precios y encuentra profesionales para reparaciones y mantenimiento.</p>
<div class="actions"><a class="btn btn-primary" href="${pageContext.request.contextPath}/servicios">Explorar servicios</a>
<a class="btn btn-outline" href="${pageContext.request.contextPath}/registro.jsp">Ofrecer mis servicios</a></div>
<p class="muted">Servicios organizados · Perfiles profesionales · Solicitudes desde casa</p>
</div><div class="hero-art"><div class="house">⌂</div><div class="floating"><strong>Servicios para tu hogar</strong><br><span class="muted">Todo en un solo lugar</span></div></div></section>
<section class="section" id="como"><div class="section-title"><span class="eyebrow">FÁCIL Y ORGANIZADO</span><h2>¿Qué necesitas resolver?</h2><p>Explora las categorías y encuentra la ayuda que necesitas.</p></div>
<div class="grid">
<article class="card"><span class="emoji">⚡</span><h3>Electricidad</h3><p>Instalaciones y reparaciones eléctricas.</p></article>
<article class="card"><span class="emoji">🔧</span><h3>Gasfitería</h3><p>Tuberías, grifería y fugas.</p></article>
<article class="card"><span class="emoji">❄</span><h3>Electrodomésticos</h3><p>Mantenimiento y reparación de equipos.</p></article>
<article class="card"><span class="emoji">🖌</span><h3>Pintura</h3><p>Renovación y acabado de ambientes.</p></article>
<article class="card"><span class="emoji">🪚</span><h3>Carpintería</h3><p>Reparaciones y trabajos en madera.</p></article>
<article class="card"><span class="emoji">🏠</span><h3>Mantenimiento</h3><p>Soluciones generales para el hogar.</p></article>
</div></section>
<section class="cta"><h2>Comienza hoy</h2><p>Regístrate para contratar o publicar servicios.</p><a class="btn btn-light" href="${pageContext.request.contextPath}/registro.jsp">Crear una cuenta</a></section>
</main><footer class="footer"><strong>ServiciosHogar</strong><span>Proyecto académico · 2026</span></footer>
</body></html>
