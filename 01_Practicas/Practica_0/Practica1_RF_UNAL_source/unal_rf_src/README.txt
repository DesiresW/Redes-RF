PRACTICA 1 - EQUIPOS DE RF - ANALIZADOR DE ESPECTROS
Universidad Nacional de Colombia - Circuitos de RF 2026-II

Contenido:
- Main.tex: fuente principal de la presentación Beamer.
- assets/: recursos gráficos del template UNAL utilizado como base.
- statale_colors.sty y beamertheme_statale.sty: archivos del tema.
- imgs/rf/: gráficas experimentales de la práctica.
- Main.pdf: versión compilada y verificada.

Dependencias:
- Git.
- TeX Live o TinyTeX actualizado.
- Paquetes TeX: beamer, pgf, pgfplots, babel, booktabs, mfnfss,
  caladea, carlito, fontaxes y collection-fontsrecommended.

Compilación manual verificada con pdflatex ejecutado dos veces:
  pdflatex -interaction=nonstopmode -halt-on-error Main.tex
  pdflatex -interaction=nonstopmode -halt-on-error Main.tex

Compilación recomendada en Windows:
  .\compilar_presentacion.ps1

El script compila dos veces, reemplaza Main.pdf y crea un commit de Git
únicamente si el PDF cambió. No hace push automáticamente; después de revisar
el PDF se debe ejecutar `git push origin main`.

Preparación de un solo clic:
  .\preparar_espacio_trabajo.bat

Este ejecutable verifica Git y TinyTeX/TeX Live, actualiza el repositorio con
origin/main, instala los paquetes TeX, compila dos veces y actualiza Main.pdf.
Si el PDF cambió, crea un commit. No hace push automáticamente.
Se detiene si encuentra cambios locales para no sobrescribir trabajo.

Para comenzar una sesión, abre en VS Code la raíz del repositorio, la carpeta
que contiene .git, README.md, 00_Recursos, 01_Practicas y 02_Software.
Después actualiza el espacio de trabajo:
  git fetch origin
  git status
  git pull --ff-only origin main

Si hay cambios locales, primero haz commit de ellos o guárdalos temporalmente:
  git stash push -u -m "Trabajo local antes de actualizar"
  git pull --ff-only origin main
  git stash pop

Si varias personas trabajan en paralelo, antes de publicar cambios usa:
  git pull --rebase origin main

Para trabajar simultáneamente, cada persona debe crear una rama propia:
  git fetch origin
  git switch main
  git pull --ff-only origin main
  git switch -c nombre-corto-de-la-tarea

La compilación y el visor de LaTeX Workshop funcionan de forma local dentro de
esa rama. El ejecutable compilar_presentacion.bat crea el commit de Main.pdf en
la rama actual. Antes de publicar, actualiza la rama:
  git fetch origin
  git rebase origin/main

Después publica la rama y abre un Pull Request:
  git push -u origin nombre-corto-de-la-tarea

Los conflictos se resuelven en VS Code, luego se recompila y se continúa el
rebase. Para reducir conflictos, no edites simultáneamente la misma diapositiva
o el mismo bloque de Main.tex. No uses push --force sobre main.

Edición simultánea en vivo con tres personas:
- El anfitrión abre la raíz del repositorio en VS Code.
- Inicia "Live Share: Start Collaboration Session".
- Comparte el enlace con las otras dos personas.
- Los invitados instalan MS-vsliveshare.vsliveshare y abren el enlace.
- Todos pueden editar Main.tex al mismo tiempo.

La compilación y el visor PDF deben ejecutarse en la máquina anfitriona,
que debe tener LaTeX Workshop y la compilación automática onSave activada.
Live Share permite editar en vivo, pero no reemplaza Git. Al finalizar,
el anfitrión revisa Main.pdf, crea el commit integrado y ejecuta git push.

Al terminar:
  git status
  git add <archivos-editados>
  git commit -m "Describe tus cambios"
  git push origin main

Extensiones recomendadas de VS Code:
- LaTeX Workshop (James-Yu.latex-workshop).
- GitLens (eamodio.gitlens), opcional.

La presentación tiene 20 páginas incluyendo la diapositiva final del tema.
