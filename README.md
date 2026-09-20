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

### Preparar el espacio de trabajo con un solo ejecutable

Para una persona que no necesite conocer el flujo de Git o LaTeX, después de
clonar el repositorio puede ejecutar:

[preparar_espacio_trabajo.bat](./01_Practicas/Practica_0/Practica1_RF_UNAL_source/unal_rf_src/preparar_espacio_trabajo.bat)

Ese ejecutable:

1. Comprueba que Git y TinyTeX/TeX Live estén instalados.
2. Verifica que no haya cambios locales sin guardar.
3. Descarga la versión más reciente desde `origin/main`.
4. Actualiza `tlmgr`.
5. Instala las dependencias TeX de la presentación.
6. Ejecuta la compilación de dos pasadas.
7. Actualiza `Main.pdf` y crea un commit si el PDF cambió.

No hace `git push` automáticamente. Cuando se haya revisado el PDF, se debe
ejecutar `git push origin main`. Si existen cambios locales, el ejecutable se
detiene para evitar sobrescribirlos; primero hay que hacer commit o guardarlos
con `git stash`.

La primera preparación requiere que el equipo ya tenga instalados:

- Git.
- TinyTeX o TeX Live con `pdflatex` y `tlmgr` disponibles en el `PATH`.

Después de esa preparación, para las sesiones normales basta con editar `Main.tex`
y ejecutar `compilar_presentacion.bat`.

### Empezar una sesión de trabajo

Después de clonar el repositorio, abre la carpeta raíz `Redes RF` en VS Code.
La carpeta raíz correcta es la que contiene `.git`, `README.md`, `00_Recursos`,
`01_Practicas` y `02_Software`.

Antes de editar, actualiza tu copia local:

```powershell
git fetch origin
git status
git pull --ff-only origin main
```

`git pull --ff-only` actualiza el espacio de trabajo únicamente cuando no hay
divergencias. Si Git informa que tienes cambios locales, no fuerces el pull:

```powershell
git status
git add <archivos-que-quieras-conservar>
git commit -m "Describe tus cambios"
git pull --rebase origin main
```

Si todavía no quieres crear un commit, guarda temporalmente los cambios:

```powershell
git stash push -u -m "Trabajo local antes de actualizar"
git pull --ff-only origin main
git stash pop
```

Si `git stash pop` produce conflictos, resuélvelos en VS Code, prueba la
compilación y crea un commit. Nunca uses `git reset --hard` para resolverlo sin
haber guardado antes tu trabajo.

Cuando termines una sesión:

```powershell
git status
git add <archivos-editados>
git commit -m "Describe tus cambios"
git push origin main
```

Si varias personas trabajan en paralelo, actualiza de nuevo con
`git pull --rebase origin main` antes de hacer `push`. La secuencia recomendada
es: actualizar, editar, compilar, revisar `Main.pdf`, hacer commit y finalmente
hacer `push`.

### Trabajo simultáneo con VS Code

Cada persona debe trabajar en una rama propia; no se recomienda editar y hacer
push directamente sobre `main`:

```powershell
git fetch origin
git switch main
git pull --ff-only origin main
git switch -c nombre-corto-de-la-tarea
```

Abre esa copia en VS Code, edita `Main.tex` y usa LaTeX Workshop para compilar y
ver el PDF en tiempo real. La compilación local no modifica el trabajo de las
otras personas. El ejecutable `compilar_presentacion.bat` crea el commit del PDF
en la rama actual, por lo que también debe ejecutarse dentro de la rama de la
persona que hizo la edición.

Antes de publicar:

```powershell
git status
git add Main.tex imgs/ assets/ *.sty
git commit -m "Describe la modificación"
git fetch origin
git rebase origin/main
```

Si el rebase presenta conflictos, resuélvelos en VS Code, recompila y continúa:

```powershell
git add <archivos-resueltos>
git rebase --continue
```

Después publica la rama:

```powershell
git push -u origin nombre-corto-de-la-tarea
```

Luego se integra mediante un Pull Request. Una sola persona debe revisar la
presentación completa y fusionar el Pull Request en `main`. Después de la
fusión, todos actualizan sus copias con:

```powershell
git switch main
git pull --ff-only origin main
```

Para reducir conflictos, dividan el trabajo por diapositivas o bloques
separados de `Main.tex`, y no editen simultáneamente la misma diapositiva. No
usen `git push --force` sobre `main`.

### Extensiones recomendadas para VS Code

- **LaTeX Workshop** (`James-Yu.latex-workshop`): compilación, visor PDF y sincronización fuente-PDF.
- **GitLens** (`eamodio.gitlens`): historial y comparación de cambios.

Git ya viene integrado en VS Code; GitLens es opcional. Para un equipo con pocos
recursos, LaTeX Workshop y Git integrado son suficientes.

## Repositorio
- GitHub: https://github.com/DesiresW/Redes-RF
