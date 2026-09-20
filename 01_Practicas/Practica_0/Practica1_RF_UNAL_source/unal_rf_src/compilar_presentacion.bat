@echo off
setlocal
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0compilar_presentacion.ps1"
set "exitCode=%ERRORLEVEL%"
echo.
if not "%exitCode%"=="0" (
    echo La compilacion fallo con codigo %exitCode%.
) else (
    echo La compilacion termino correctamente.
)
pause
exit /b %exitCode%
