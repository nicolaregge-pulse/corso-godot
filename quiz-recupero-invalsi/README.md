# Quiz Sicurezza — Recupero INVALSI (pagina HTML)

**Versione 1.0** — 10/09/2026
*Pagina web che si autocorregge, con i 18 scenari del recupero (Sicurezza da
utente e Comunicazione). I ragazzi rispondono e vedono subito verde/rosso con la
spiegazione, piu il punteggio finale. E la versione "giocabile e mostrabile"
degli esercizi di RECUPERO-INVALSI-esercizi. Sorgente unico e autonomo:
index.html (nessuna installazione, nessun file esterno).*

---

## 1. Cos'e
1. Una singola pagina `index.html`, senza dipendenze: funziona anche aperta con il doppio clic.
2. Le opzioni si mescolano a ogni caricamento, cosi la posizione della risposta non aiuta.
3. Ogni risposta si corregge da sola e spiega il perche; alla fine c'e un messaggio di incoraggiamento (zero vergogna).

## 2. Come si apre (a scuola, senza installare nulla)
1. Doppio clic su `index.html`: si apre nel browser.
2. Oppure, da GitHub, si legge il file e lo si pubblica su Pages (sotto).

## 3. Come si pubblica su GitHub Pages (link per i ragazzi)
1. Nel repository, andare in `Settings` -> `Pages`.
2. In `Build and deployment`, come sorgente scegliere il ramo `main` e la cartella radice.
3. Salvare: dopo qualche minuto la pagina e online all'indirizzo
   `https://<utente>.github.io/corso-godot/quiz-recupero-invalsi/`.
4. Quel link si puo condividere con la classe: si apre anche dal telefono.

## 4. Da dove nascono le domande
1. Le 18 domande sono le stesse di `RECUPERO-INVALSI-esercizi.md` (sezioni 3-8).
2. Se si aggiornano li, vanno aggiornate anche nell'array `QUIZ` dentro `index.html` (per ora a mano).

## 5. Collegamenti
1. `RECUPERO-INVALSI-esercizi.md`: schede, esercizi a scenario e laboratorio pratico.
2. `RECUPERO-INVALSI.md`: il piano di recupero.
3. Corso HTML/CSS (Panaccione): questa pagina e un esempio concreto di cosa si costruisce con HTML, CSS e un po' di JavaScript.
