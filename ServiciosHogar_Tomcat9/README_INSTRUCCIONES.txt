SERVICIOSHOGAR — PROYECTO MAVEN PARA APACHE TOMCAT 9 (WINDOWS x64)

CONTENIDO
- Proyecto Java web Maven (WAR), compatible con Tomcat 9 y javax.servlet 4.0.1.
- Imágenes locales en src/main/webapp/img/ (no dependen de URLs externas).
- Carpeta herramientas con un script para descargar y extraer Tomcat 9 oficial.
- No se modifica automáticamente la base de datos.

IMPORTANTE SOBRE TU BASE DE DATOS
El proyecto apunta a servicios_hogar en localhost:3306, usuario root y contraseña vacía.
Tu phpMyAdmin en localhost:8012 usa un puerto web distinto del puerto MySQL.
No ejecutes el archivo SQL incluido si ya tienes tu base creada; así evitamos duplicar o alterar tablas.
Si MySQL usa otro puerto o clave, edita src/main/java/com/servicioshogar/config/Conexion.java.

1) TOMCAT 9
Abre herramientas\DESCARGAR_TOMCAT9.bat y espera a que termine. Necesitas internet.
El script descargará la distribución oficial Apache Tomcat 9.0.123 para Windows x64 y la extraerá en la carpeta Tomcat9.
Tomcat no pudo incrustarse dentro de este ZIP porque el entorno de preparación no tuvo acceso directo para descargar el binario; el script lo obtiene desde el sitio oficial cuando lo ejecutes.

2) ABRIR EN NETBEANS
Descomprime este paquete. En NetBeans usa File > Open Project y selecciona la carpeta ServiciosHogar_Tomcat9 (la que contiene pom.xml).
Registra/selecciona Tomcat 9 desde Tools > Servers (o Services > Servers, según la versión de NetBeans) apuntando a la carpeta Tomcat9 descargada.
Configura el JDK 21. Maven descargará las dependencias cuando haya conexión.

3) EJECUTAR
Clean and Build; luego Run. URL habitual: http://localhost:8080/ServiciosHogar/
Si NetBeans no despliega automáticamente, ejecuta `mvn clean package` en la carpeta del proyecto y copia target\ServiciosHogar.war a Tomcat9\webapps; luego inicia Tomcat.

4) BASE DE DATOS
Asegúrate de que MySQL esté iniciado. La aplicación no crea ni modifica tablas automáticamente.

NOTA
Las fotos incluidas son ilustrativas. Este ZIP no afirma que todas sean fotografías reales de proveedores.

ACTUALIZACION FOTO DE PROVEEDORES
1. Si ya tienes la base de datos creada, ejecuta database/ACTUALIZACION_FOTO_PROVEEDORES.sql una sola vez.
2. Limpia y vuelve a desplegar el proyecto en Tomcat 9.
3. Entra con una cuenta PROVEEDOR > Mi perfil profesional.
4. Selecciona una foto JPG/PNG/WEBP (max. 5 MB), completa descripcion, experiencia y tarifa, y guarda.
5. En una cuenta COMPRADOR > Ver proveedores se mostraran foto, nombre, especialidad, descripcion, experiencia, tarifa y valoracion.
Nota: se corrigieron tambien los textos literales \\n que aparecian en el panel.
