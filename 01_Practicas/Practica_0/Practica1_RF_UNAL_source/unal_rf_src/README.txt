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

Extensiones recomendadas de VS Code:
- LaTeX Workshop (James-Yu.latex-workshop).
- GitLens (eamodio.gitlens), opcional.

La presentación tiene 20 páginas incluyendo la diapositiva final del tema.
