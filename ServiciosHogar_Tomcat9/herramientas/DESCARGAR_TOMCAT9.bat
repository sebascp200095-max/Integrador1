@echo off
setlocal
cd /d "%~dp0.."
set "URL=https://downloads.apache.org/tomcat/tomcat-9/v9.0.123/bin/apache-tomcat-9.0.123-windows-x64.zip"
set "ZIP=%TEMP%\apache-tomcat-9.0.123-windows-x64.zip"
echo Descargando Apache Tomcat 9.0.123 oficial para Windows x64...
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri '%URL%' -OutFile '%ZIP%' -UseBasicParsing } catch { Write-Host $_; exit 1 }"
if errorlevel 1 (
 echo No se pudo descargar Tomcat. Comprueba tu conexion y vuelve a ejecutar este archivo.
 pause
 exit /b 1
)
echo Extrayendo Tomcat 9...
if exist "Tomcat9" rmdir /s /q "Tomcat9"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '%ZIP%' -DestinationPath '%TEMP%\Tomcat9_extract' -Force"
if errorlevel 1 (
 echo No se pudo extraer Tomcat.
 pause
 exit /b 1
)
for /d %%D in ("%TEMP%\Tomcat9_extract\apache-tomcat-9.0.123*") do (
 move "%%~fD" "Tomcat9" >nul
)
rmdir /s /q "%TEMP%\Tomcat9_extract" 2>nul
del "%ZIP%" 2>nul
echo.
echo Tomcat quedo en: %CD%\Tomcat9
echo Registra esta carpeta como servidor en NetBeans.
pause
