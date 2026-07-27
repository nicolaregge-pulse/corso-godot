# Riprendiamo da qui — nota per la prossima sessione

*Aggiornato: 27/07/2026.*

## Dove siamo (tutto su `main`)
- **Manuale v0.14** — teoria, lettera a mano firmata "Nicola", schede, i 3
  capitoli di costruzione degli esercizi 1-2-3 (con foto), progetto boss.
- **Eserciziario v0.8** — esercizi 1-3 (4 livelli + foto del risultato) + BOSS.
- **Esercizi funzionanti** in `esercizi/` (01 bottone, 02 quadrato, 03 moneta).
- **Giochi:** `battaglia-navale-3d/` (Affonda la Bonomi, + Web in `docs/`) e
  `gioco-del-quindici/` (15-puzzle con la foto, prima bozza da testare).
- Tutte le foto degli esercizi sono in `manuale/immagini/`
  (es1-ambiente, es1-gioca, es2-gioca, es3-ambiente, es3-gioca).

## Cosa manca (prossimi passi)
1. **Release `v1.0`** da pubblicare dal browser (tag v1.0 su GitHub) — è la
   versione congelata per i ragazzi. (Claude non ha lo strumento per crearla.)
2. **Kit di consegna dei ragazzi** — vedi sotto: preparare il modello e la
   struttura delle cartelle.

## Kit di consegna dei ragazzi (in progettazione)
Ogni consegna = una cartella con: **`scheda.md`** (modulo: cognome, nome, classe,
esercizio/titolo, data, "cosa ho fatto con parole mie", "il mio tocco", "dove mi
sono bloccato"), il **codice**, le **immagini**.
- Struttura nel repository per gestire più classi e più anni (idea di Nicola):
  `consegne/<anno-classe>/<cognome-nome>/<esercizio>/…`
  es. `consegne/2026-2027-1informatica/rossi-mario/es1/`.
- Giro: ragazzo consegna → Claude corregge → **voto = numero + breve giudizio**
  (deciso insieme, ultima parola a Nicola) → Claude aggiunge una pagina al
  **manuale personale** dello studente → si restituisce il suo manuale aggiornato.
- I ragazzi lavorano con **Gemini**; Claude corregge e compila i loro manuali.

## Idee più avanti
- Impaginare il **quaderno-studente** in PDF (base del manuale personale).
- Riordinare gli esercizi per difficoltà; aggiungerne altri.
- Gioco del quindici: eventuale vera texture di legno; Esercizio 4.

## Preferenze da ricordare SEMPRE (decise da Nicola)
- Aspetto **sobrio, serio, professionale**: **niente icone/emoji**. Unica
  eccezione: i **4 livelli d'aiuto** restano colorati (verde/giallo/arancione/rosso).
- **Niente parentesi** nei **titoli** e nelle **scritte in grassetto** (nel testo
  discorsivo e nel codice possono restare).
- Il libro **parla ai ragazzi** ("tu"), non è una riflessione tra docente e AI.
- **Changelog** solo nel sorgente `.md`, **non** nel PDF. Versione nel footer.
- Ogni PDF ha la **versione nel nome file**; mai riusare una versione.
- **Mai far salvare/consegnare un nome di file che esiste già:** ogni file
  consegnato ha nome unico con versione; non re-inviare mai un file identico che
  Nicola ha già (causa "file già esistente" quando salva). Regola sacra.
- Con Nicola e i ragazzi: **tutto visuale** (GitHub Desktop / browser), mai la
  riga di comando. Coordinate complete a ogni passo.
