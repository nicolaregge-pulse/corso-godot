# Riprendiamo da qui — nota per la prossima sessione

*Aggiornato: 26/07/2026, fine giornata.*

## Dove siamo (tutto su `main`)
- **Manuale v0.7** e **Eserciziario v0.7** (in `manuale/`), impaginati in PDF.
- **Esercizi funzionanti** in `esercizi/` (01 bottone, 02 quadrato, 03 moneta).
- **Progetto boss** in `battaglia-navale-3d/` + versione **Web** in `docs/`.

## Cosa manca (prossimi passi, in ordine)
1. **Nicola carica gli screenshot** dei nuovi capitoli in `manuale/immagini/`,
   con questi nomi esatti (nel PDF ci sono già i segnaposto pronti):
   - `es1-scena.png` · `es1-gioca.png`
   - `es2-gioca.png`
   - `es3-scena.png` · `es3-gioca.png`
2. **Claude rigenera** i PDF con le immagini dentro → si bumpa la versione.
3. **Prima Release `v1.0`** congelata per i ragazzi (tag/Release su GitHub).
4. **Git di Nicola:** passare al branch **`main`** su GitHub Desktop e fare
   **Pull**, così ha tutto sul PC.

## Idee più avanti
- Invitare la classe; primo giro branch → Pull Request dal browser.
- Impaginare il **quaderno-studente** in PDF.
- Aggiungere altri esercizi (poi si riordinano per difficoltà).

### Nuovo gioco da fare — "Il quindici con la foto" (idea di Nicola)
Il classico **gioco del quindici** (griglia 4×4: 15 tessere + 1 buco), ma le
tessere mostrano i **pezzi di una foto**; obiettivo: ricomporre l'immagine.
- La foto si taglia in 16 quadretti con `AtlasTexture` (ritaglia un pezzo).
- Clic su una tessera vicina al buco → scivola nel buco.
- Mescolare con tante **mosse casuali valide** (così è sempre risolvibile).
- Vittoria = tutte le tessere a posto, foto intera.
- **Aspetto legno**: cornice + tessere in legno (o texture `legno.jpg` fornita
  da Nicola, oppure finto legno con marroni + smusso).
- **Da decidere:** come carica la foto — file `foto.jpg` nella cartella (semplice,
  come Serena) oppure finestra "Scegli file" all'avvio (più fedele, ottima su PC).
- Ottimo per "Fallo tuo" (la tua foto) e "Mostralo". Possibile Esercizio 4.

## Preferenze da ricordare SEMPRE (decise da Nicola)
- Aspetto **sobrio, serio, professionale**: **niente icone/emoji**. Unica
  eccezione: i **4 livelli d'aiuto** restano colorati (verde/giallo/arancione/rosso).
- **Niente parentesi** nei **titoli** e nelle **scritte in grassetto** (nel testo
  discorsivo e nel codice possono restare).
- Il libro **parla ai ragazzi** ("tu"), non è una riflessione tra docente e AI.
- **Changelog** solo nel sorgente `.md`, **non** nel PDF. Versione nel footer.
- Ogni PDF ha la **versione nel nome file**; mai riusare una versione.
- Con Nicola e i ragazzi: **tutto visuale** (GitHub Desktop / browser), mai la
  riga di comando. Coordinate complete a ogni passo.
