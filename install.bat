@echo off
setlocal

cd /d "%~dp0"

rem Definir las rutas a las carpetas de librerías
echo Ruta actual: %cd%
set "x64Path=.\dll\x64"
set "x86Path=.\dll\x86"

rem Verificar la arquitectura del sistema
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo Registrando y copiando librerías en x64...
    for %%f in ("%x64Path%\*.dll") do (
        rem Copiar la DLL a System32
        echo Intentando copiar "%%f" a %SystemRoot%\System32...
        copy "%%f" "%SystemRoot%\System32\" 
        if errorlevel 1 (
            echo Error al copiar: %%f - Acceso denegado o archivo en uso.
        ) else (
            echo Copiada a System32: %%f
            rem Registrar la DLL
            regsvr32 /s "%SystemRoot%\System32\%%~nxf"
            echo Registrada: %%f
        )
    )
) else (
    echo Registrando y copiando librerías en x86...
    for %%f in ("%x86Path%\*.dll") do (
        echo Intentando copiar "%%f" a %SystemRoot%\System32...
        copy "%%f" "%SystemRoot%\System32\" 
        if errorlevel 1 (
            echo Error al copiar: %%f - Acceso denegado o archivo en uso.
        ) else (
            echo Copiada a System32: %%f
            rem Registrar la DLL
            regsvr32 /s "%SystemRoot%\System32\%%~nxf"
            echo Registrada: %%f
        )
    )
    echo No se registran DLL x64 en sistemas de 32 bits.
)

endlocal
echo Registro y copia completados.
pause
