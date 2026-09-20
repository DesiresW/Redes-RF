# Redes RF

Repositorio con el material del curso de Redes RF, prácticas, referencias y herramientas de apoyo.

## Estructura
- `00_Recursos/Libro/libro.pdf`
- `00_Recursos/Manuales/hm5010_manu.pdf`
- `01_Practicas/Practica_0/`
- `01_Practicas/Practica_0/Practica1_RF_UNAL_source/unal_rf_src/`
- `02_Software/RFExplorerWindowsSuiteSetup_v3.27.2604.02/`

## Contenido
- Bibliografía del curso
- Prácticas y muestras de laboratorio
- Manuales y documentación técnica
- Software de apoyo para RF Explorer

## Clonar
```bash
git clone https://github.com/DesiresW/Redes-RF.git
```

## Compilar la presentación

La fuente de la presentación está en `01_Practicas/Practica_0/Practica1_RF_UNAL_source/unal_rf_src/`.
El documento usa LaTeX Beamer y debe compilarse con **pdfLaTeX** dos veces para resolver
referencias y generar la versión actualizada de `Main.pdf`.

### Dependencias

- Windows 10/11.
- Git.
- TeX Live o TinyTeX actualizado.
- Paquetes TeX: `beamer`, `pgf`, `pgfplots`, `babel`, `booktabs`, `mfnfss`,
  `caladea`, `carlito`, `fontaxes` y `collection-fontsrecommended`.
- Los archivos locales `beamertheme_statale.sty`, `statale_colors.sty` y `assets/`
  forman parte del tema y deben permanecer junto a `Main.tex`.

En TinyTeX se pueden instalar los paquetes con:

```powershell
tlmgr update --self
tlmgr install beamer pgf pgfplots babel booktabs mfnfss caladea carlito fontaxes collection-fontsrecommended
```

### Actualizar y compilar

Desde la carpeta `unal_rf_src`, ejecutar:

```powershell
.\compilar_presentacion.ps1
```

El script:

1. Ejecuta `pdflatex` con `-interaction=nonstopmode -halt-on-error`.
2. Repite la compilación.
3. Reemplaza `Main.pdf`.
4. Añade **solo** `Main.pdf` al índice de Git.
5. Crea un commit con la versión compilada si el PDF cambió.

También se puede usar `compilar_presentacion.bat` con doble clic. El `.bat` abre
PowerShell, muestra los errores y conserva la ventana abierta al terminar.

El script no hace `push` automáticamente. Después de revisar el PDF:

```bash
git push origin main
```

Si hay cambios locales en `Main.tex`, el script no los descarta. Los archivos
temporales de LaTeX están excluidos por `.gitignore`.

### Extensiones recomendadas para VS Code

- **LaTeX Workshop** (`James-Yu.latex-workshop`): compilación, visor PDF y sincronización fuente-PDF.
- **GitLens** (`eamodio.gitlens`): historial y comparación de cambios.

Git ya viene integrado en VS Code; GitLens es opcional. Para un equipo con pocos
recursos, LaTeX Workshop y Git integrado son suficientes.

## Repositorio
- GitHub: https://github.com/DesiresW/Redes-RF
