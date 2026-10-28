-- Ejecutar UNA VEZ en phpMyAdmin sobre la base servicios_hogar
USE servicios_hogar;

ALTER TABLE perfiles_proveedor
ADD COLUMN foto_url VARCHAR(500) NULL AFTER descripcion;

-- La foto se guarda desde "Mi perfil profesional".
-- La ruta se registra automáticamente en foto_url.
