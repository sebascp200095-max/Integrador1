<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>

<%!
private String esc(String s) {
    if (s == null) return "";
    return s.replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Proveedores | ServiciosHogar</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilos.css">
</head>

<body>

<header class="navbar">
    <a class="logo" href="${pageContext.request.contextPath}/">
        <span class="logo-icon">S</span>
        ServiciosHogar
    </a>

    <nav>
        <a href="${pageContext.request.contextPath}/servicios">Servicios</a>
        <a href="${pageContext.request.contextPath}/panel">Mi panel</a>
        <a href="${pageContext.request.contextPath}/login.jsp">Iniciar sesión</a>
    </nav>
</header>

<main class="section">

    <span class="eyebrow">PROFESIONALES DE CONFIANZA</span>

    <h1>Encuentra al especialista que necesitas</h1>

    <p class="muted">
        Compara categorías, conoce la experiencia de cada proveedor
        y elige quién puede ayudarte en casa.
    </p>

    <% if (request.getAttribute("errorPerfiles") != null) { %>
        <div class="alert">
            <%= esc(String.valueOf(request.getAttribute("errorPerfiles"))) %>
        </div>
    <% } %>

    <div class="grid">

        <%
        List<Map<String, Object>> lista =
            (List<Map<String, Object>>) request.getAttribute("perfiles");

        if (lista == null || lista.isEmpty()) {
        %>

            <article class="card">
                <h3>Aún no hay proveedores</h3>
                <p>
                    Cuando se registren proveedores, sus perfiles aparecerán aquí.
                </p>
                <a class="btn btn-primary"
                   href="${pageContext.request.contextPath}/registro.jsp">
                    Registrarme como proveedor
                </a>
            </article>

        <%
        } else {
            for (Map<String, Object> p : lista) {

                String nombre = (String) p.get("nombre");
                if (nombre == null) nombre = "";

                String desc = (String) p.get("descripcion");

                Object promedioObj = p.get("promedio");
                double promedio = promedioObj instanceof Number
                    ? ((Number) promedioObj).doubleValue() : 0.0;

                String foto = (String) p.get("fotoUrl");
                String rutaFoto = "";

                if (foto != null && !foto.isBlank()) {
                    foto = foto.trim();

                    if (foto.startsWith("https://") || foto.startsWith("http://")) {
                        rutaFoto = foto;
                    } else if (foto.startsWith(request.getContextPath() + "/")) {
                        rutaFoto = foto;
                    } else if (foto.startsWith("/")) {
                        rutaFoto = request.getContextPath() + foto;
                    } else {
                        rutaFoto = request.getContextPath() + "/" + foto;
                    }
                }

                boolean disponible = Boolean.TRUE.equals(p.get("disponible"));

                String categorias = p.get("categorias") == null
                    ? "Servicios para el hogar"
                    : String.valueOf(p.get("categorias"));

                String inicial = nombre.isEmpty()
                    ? "P"
                    : nombre.substring(0, 1).toUpperCase(Locale.ROOT);

                String nombreBusqueda = URLEncoder.encode(nombre, "UTF-8");
        %>

            <article class="card">

                <div class="profile-head">

                    <div class="avatar-container">

                        <% if (!rutaFoto.isBlank()) { %>

                            <img
                                class="avatar provider-photo"
                                src="<%= esc(rutaFoto) %>"
                                alt="Foto de <%= esc(nombre) %>"
                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                            >

                            <div class="avatar avatar-fallback" style="display:none;">
                                <%= esc(inicial) %>
                            </div>

                        <% } else { %>

                            <div class="avatar avatar-fallback">
                                <%= esc(inicial) %>
                            </div>

                        <% } %>

                    </div>

                    <div>
                        <h3><%= esc(nombre) %></h3>

                        <span class="tag">
                            <%= disponible
                                ? "Disponible para trabajos"
                                : "No disponible por ahora" %>
                        </span>
                    </div>

                </div>

                <div class="provider-category">
                    <span class="category-icon">⌂</span>

                    <div>
                        <small>ESPECIALIDAD</small>
                        <strong><%= esc(categorias) %></strong>
                    </div>
                </div>

                <p class="provider-description">
                    <strong>Sobre el proveedor</strong><br>

                    <%= desc == null || desc.isBlank()
                        ? "Este proveedor aún no ha añadido una descripción a su perfil."
                        : esc(desc) %>
                </p>

                <p>
                    Experiencia:
                    <strong><%= p.get("experiencia") %> años</strong>
                </p>

                <p>
                    Tarifa referencial:
                    <strong class="price">
                        S/ <%= p.get("tarifa") == null
                            ? "Por consultar"
                            : esc(String.valueOf(p.get("tarifa"))) %>
                    </strong>
                </p>

                <p class="rating">
                    ★ <%= String.format(Locale.US, "%.1f", promedio) %> / 5
                    <span class="muted">
                        (<%= p.get("resenas") == null ? 0 : p.get("resenas") %>
                        reseñas)
                    </span>
                </p>

                <div class="card-actions">

                    <a class="btn btn-primary"
                       href="${pageContext.request.contextPath}/servicios?q=<%= nombreBusqueda %>">
                        Ver servicios
                    </a>

                    <% if (disponible) { %>
                        <a class="btn btn-outline"
                           href="${pageContext.request.contextPath}/servicios?q=<%= nombreBusqueda %>">
                            Contratar
                        </a>
                    <% } %>

                </div>

            </article>

        <%
            }
        }
        %>

    </div>
</main>

<footer class="footer">
    <strong>ServiciosHogar</strong>
    <span>Elige con información y confianza.</span>
</footer>

</body>
</html>