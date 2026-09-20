@echo off
setlocal
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0preparar_espacio_trabajo.ps1"
set "exitCode=%ERRORLEVEL%"
echo.
if not "%exitCode%"=="0" (
    echo No se pudo preparar el espacio de trabajo. Codigo: %exitCode%
) else (
    echo Espacio de trabajo listo.
)
pause
exit /b %exitCode%
