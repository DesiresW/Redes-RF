$ErrorActionPreference = "Stop"

$sourceDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$git = Get-Command git -ErrorAction SilentlyContinue
if ($null -eq $git) {
    throw "No se encontró Git. Instala Git y vuelve a ejecutar este script."
}

$repoRoot = (& $git.Source "-C" $sourceDir "rev-parse" "--show-toplevel").Trim()
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($repoRoot)) {
    throw "La presentación no está dentro de un repositorio Git."
}

Push-Location $repoRoot
try {
    $status = & $git.Source "status" "--porcelain"
    if (@($status).Count -gt 0) {
        throw "Hay cambios locales. Guárdalos en un commit o usa git stash antes de actualizar."
    }

    & $git.Source "fetch" "origin"
    if ($LASTEXITCODE -ne 0) {
        throw "No se pudo descargar la información de origin."
    }

    & $git.Source "pull" "--ff-only" "origin" "main"
    if ($LASTEXITCODE -ne 0) {
        throw "No se pudo actualizar origin/main sin crear una mezcla. Revisa el estado de Git."
    }
}
finally {
    Pop-Location
}

$tlmgr = Get-Command tlmgr -ErrorAction SilentlyContinue
if ($null -eq $tlmgr) {
    throw "No se encontró tlmgr. Instala TinyTeX o TeX Live y vuelve a ejecutar este script."
}

& $tlmgr.Source "update" "--self"
if ($LASTEXITCODE -ne 0) {
    throw "No se pudo actualizar tlmgr."
}

$packages = @(
    "beamer",
    "pgf",
    "pgfplots",
    "babel",
    "booktabs",
    "mfnfss",
    "caladea",
    "carlito",
    "fontaxes",
    "collection-fontsrecommended"
)

& $tlmgr.Source "install" $packages
if ($LASTEXITCODE -ne 0) {
    throw "No se pudieron instalar todos los paquetes LaTeX."
}

& (Join-Path $sourceDir "compilar_presentacion.ps1")
if ($LASTEXITCODE -ne 0) {
    throw "La preparación terminó sin poder compilar la presentación."
}

Write-Host "Espacio de trabajo preparado. Puedes abrir Main.pdf y empezar a editar Main.tex."
