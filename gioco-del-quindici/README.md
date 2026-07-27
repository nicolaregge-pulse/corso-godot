# Gioco del Quindici con la foto 🧩

Il classico **gioco del quindici**, ma le tessere sono i **pezzi di una foto**:
l'obiettivo è rimetterle in ordine e **ricomporre l'immagine**. Le tessere hanno
una cornice in stile **legno**.

> ⚠️ **Prima bozza** da provare e migliorare (idea di Nicola). Non è ancora un
> esercizio per i ragazzi.

## Come si gioca
1. All'avvio scegli la **foto** — la tua (`Scegli dal computer…`) oppure quella
   di **esempio** — e la **difficoltà**: `3 × 3` (facile) o `4 × 4` (classico).
2. Una tessera manca: resta un **buco**. Clicca una tessera **vicina al buco** e
   ci scivola dentro.
3. Quando tutte le tessere sono al posto giusto, la **foto è ricomposta**: hai vinto.
- **↻ Rimescola** = nuova partita · **Menu** = torna alla scelta di foto e difficoltà.
- In alto a destra c'è l'**anteprima** ("Modello"): la foto intera in piccolo, per
  sapere dove va ogni pezzo.
- L'interruttore **Mostra i numeri** accende/spegne i numeri sulle tessere: aiuto
  per chi è in difficoltà, sfida in più per chi lo tiene spento.

## Come si apre (per Nicola)
1. `[APP — Godot]` finestra iniziale, in alto a destra **`Importa`**.
2. Scegli la cartella **`gioco-del-quindici`** e il file **`project.godot`**,
   poi **`Importa e modifica`**.
3. Premi **`F5`** per giocare.

## Cosa possiamo ancora migliorare
- Vera **texture di legno** (una foto di legno) al posto del marrone finto.
- Suono quando una tessera scivola.
- Un **timer** e il record delle mosse.

Già fatti: anteprima "Modello", interruttore mostra-numeri, festa alla vittoria.

## Nota tecnica
La foto viene tagliata con `AtlasTexture` (ritaglia un pezzo di immagine). Il
mescolamento si fa con tante **mosse casuali valide**, così il puzzle è **sempre
risolvibile** (un mescolamento del tutto casuale a volte non lo è).
