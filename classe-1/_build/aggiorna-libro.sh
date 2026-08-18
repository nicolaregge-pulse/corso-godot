#!/usr/bin/env bash
# Rigenera il "libro unico" del corso (MD + PDF con indice e segnalibri).
# Da lanciare ogni volta che un documento del corso è stato aggiornato.
#
# Uso (dalla cartella classe-1/_build/):
#     bash aggiorna-libro.sh
#
# Nota: se il PDF non esce, indica dove sta Chromium con CHROMIUM_PATH, es.:
#     CHROMIUM_PATH=/opt/pw-browsers/chromium-1194/chrome-linux/chrome bash aggiorna-libro.sh
set -e
cd "$(dirname "$0")"

echo "1/2  Assemblo il libro dai singoli documenti…"
python3 assembla_libro.py

echo "2/2  Genero il PDF con indice e segnalibri…"
PDF_OUTLINE=1 node genera_pdf.js

echo "Fatto. Trovi LIBRO-COMPLETO.md e LIBRO-COMPLETO-vX.Y.pdf nella radice del progetto."
