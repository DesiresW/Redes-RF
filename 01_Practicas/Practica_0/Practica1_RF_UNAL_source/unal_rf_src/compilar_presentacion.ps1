$ErrorActionPreference = "Stop"

$sourceDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$texFile = Join-Path $sourceDir "Main.tex"
$pdfFile = Join-Path $sourceDir "Main.pdf"

if (-not (Test-Path -LiteralPath $texFile)) {
    throw "No se encontró Main.tex en $sourceDir"
}

$pdflatex = Get-Command pdflatex -ErrorAction SilentlyContinue
if ($null -eq $pdflatex) {
    throw "No se encontró pdflatex. Instala TeX Live o TinyTeX y agrega su carpeta bin al PATH."
}

$git = Get-Command git -ErrorAction SilentlyContinue
if ($null -eq $git) {
    throw "No se encontró Git."
}

Push-Location $sourceDir
try {
    & $pdflatex.Source "-interaction=nonstopmode" "-halt-on-error" "Main.tex"
    if ($LASTEXITCODE -ne 0) {
        throw "La primera compilación de Main.tex falló."
    }

    & $pdflatex.Source "-interaction=nonstopmode" "-halt-on-error" "Main.tex"
    if ($LASTEXITCODE -ne 0) {
        throw "La segunda compilación de Main.tex falló."
    }

    if (-not (Test-Path -LiteralPath $pdfFile)) {
        throw "La compilación terminó sin generar Main.pdf."
    }

    & $git.Source "add" "--" "Main.pdf"
    if ($LASTEXITCODE -ne 0) {
        throw "No se pudo añadir Main.pdf al índice de Git."
    }

    & $git.Source "diff" "--cached" "--quiet" "--" "Main.pdf"
    $hasStagedChanges = $LASTEXITCODE -ne 0
    if ($hasStagedChanges) {
        $commitMessage = "Update compiled RF presentation"
        & $git.Source "commit" "-m" $commitMessage "-m" "Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
        if ($LASTEXITCODE -ne 0) {
            throw "Main.pdf quedó preparado en Git, pero el commit falló."
        }
        Write-Host "Main.pdf compilado y commit creado. Ejecuta git push origin main para publicarlo."
    }
    else {
        Write-Host "Main.pdf compilado; no hubo cambios para crear un commit."
    }
}
finally {
    Pop-Location
}
