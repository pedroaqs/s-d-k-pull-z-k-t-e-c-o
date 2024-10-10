@echo off
setlocal

cd /d "%~dp0"

rem Definir las rutas a las carpetas de librerías
set "x64Path=.\dll\x64"
set "x86Path=.\dll\x86"

rem Verificar la arquitectura del sistema
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo Eliminando y desregistrando librerías en x64...
    
    for %%f in ("%x64Path%\*.dll") do (
        rem Desregistrar la DLL
        regsvr32 /u /s "%SystemRoot%\System32\%%~nxf"
        echo Desregistrada: %%f

        rem Eliminar la DLL de System32
        del "%SystemRoot%\System32\%%~nxf"
        echo Eliminada de System32: %%f
    )
    
) else (
    echo Eliminando y desregistrando librerías en x86...
    
    for %%f in ("%x86Path%\*.dll") do (
        rem Desregistrar la DLL
        regsvr32 /u /s "%SystemRoot%\System32\%%~nxf"
        echo Desregistrada: %%f

        rem Eliminar la DLL de System32
        del "%SystemRoot%\System32\%%~nxf"
        echo Eliminada de System32: %%f
    )
    
    echo No se eliminan DLL x64 en sistemas de 32 bits.
)

endlocal
echo Eliminación y desregistro completados.
pause
