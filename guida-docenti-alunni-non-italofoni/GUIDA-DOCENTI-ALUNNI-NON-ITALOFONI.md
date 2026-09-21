# Come gestire le lezioni con alunni che non parlano italiano

**Versione 0.1** — 21/09/2026
*Guida pratica per i docenti: come tenere una lezione efficace quando in classe
ci sono alunni che parlano poco o niente italiano (nel nostro caso soprattutto
arabo e cinese). Raccoglie le cose che stiamo già facendo, con esempi concreti.
Documento interno per i docenti (in italiano).*

## 00 A chi serve e perché

1. Serve a **qualunque docente** si trovi in classe alunni che non seguono in
   italiano e rischiano di **restare esclusi** e mollare.
2. L'idea di fondo: **non abbassare il livello**, ma **abbassare la barriera
   della lingua**. Il contenuto resta serio; cambia il modo di renderlo
   raggiungibile.
3. Qui non c'è teoria astratta: sono **pratiche già in uso** nel corso di
   informatica, riutilizzabili in altre materie.

## 01 Il contesto (chi sono gli alunni)

1. Molti hanno **background migratorio** e situazioni di svantaggio; alcuni
   arrivano dopo esperienze scolastiche negative.
2. Il rischio numero uno non è che "non capiscano il concetto", ma che **si
   sentano tagliati fuori** dalla lingua e **si arrendano**.
3. Perciò ogni scelta punta a farli sentire **capaci e inclusi**: se il
   materiale è comprensibile, partecipano.

## 02 I principi (il metodo in breve)

1. **Ogni testo per gli alunni nelle loro lingue.** Nel nostro gruppo: italiano,
   arabo, cinese semplificato. Anche solo la traccia della consegna tradotta
   cambia tutto.
2. **Materiali "a prova di errore".** Istruzioni complete, un passo alla volta,
   che spiegano anche l'ovvio (a cosa serve un link, come si consegna).
3. **Mostrare, non solo dire.** Immagini, disegni, frecce, esempi a schermo:
   un'immagine supera la barriera della lingua.
4. **Piccole vittorie subito.** Un primo risultato concreto in pochi minuti
   tiene agganciati anche chi non segue bene la spiegazione a voce.
5. **La prova del nove: "saperlo spiegare".** Se l'alunno sa raccontare a parole
   sue (anche nella sua lingua) cosa ha fatto, ha capito davvero.

## 03 Le cose concrete che facciamo

### 03.1 Ogni consegna in 3 lingue
1. Ogni scheda/consegna esiste in **italiano, arabo e cinese**: o tre file
   separati (uno per lingua) o un unico file con le tre lingue affiancate.
2. Per le consegne operative preferiamo **tre file monolingui**, ciascuno
   completo di tutte le indicazioni.
3. I PDF con arabo e cinese si generano da **HTML** con i font giusti (cinese
   WenQuanYi Zen Hei, arabo Amiri); l'arabo va scritto da destra a sinistra.

### 03.2 Come scrivere i riferimenti dentro l'arabo e il cinese
1. **Indirizzi e email** (per esempio un sito o una casella di posta) **non si
   traducono**: si scrivono sempre in lettere latine e si marcano chiaramente
   come "scrivilo esattamente così".
2. **I nomi dei bottoni dei siti non si scrivono in inglese.** L'alunno spesso
   fa **tradurre la pagina** nella sua lingua, quindi il testo inglese non
   coincide con ciò che vede. Meglio descrivere il bottone per **posizione +
   colore + a cosa serve**, con la parola italiana probabile come aiuto.
3. Invitare sempre l'alunno a **tradurre la pagina nel browser** nella sua
   lingua (tasto destro sulla pagina, voce "Traduci").

### 03.3 L'AI degli alunni come "traduttore che spiega"
1. Diamo agli alunni la versione **MD** (testo semplice) dei materiali: la
   incollano nella loro AI (per esempio un assistente sul telefono) che gliela
   **spiega e traduce** nella loro lingua.
2. Regola d'uso: l'AI serve a **capire**, non a saltare il pensiero. Vale la
   prova del nove (saperlo spiegare a parole proprie).

### 03.4 Consegna anche senza scrivere in italiano
1. Per chi non scrive in italiano prevediamo vie alternative: **foglio a mano +
   foto**, oppure scrittura a mano **col mouse**, o consegna con **immagini**.
2. Le consegne su **Classroom** possono essere una foto: nessuno resta indietro
   perché "non sa scrivere".

### 03.5 Carta e penna sempre
1. In ogni lezione ogni alunno ha **carta e penna** per appunti e schemi a mano:
   disegnare e scrivere aiuta a fissare i concetti oltre la lingua.

## 04 Gli strumenti che usiamo

1. **Google Classroom** — dove compaiono le consegne; l'alunno sa che il lavoro
   nuovo è sempre lì. Si possono allegare documenti, moduli, foto.
2. **Google Moduli** — quiz e questionari (anche auto-corretti). Le domande si
   scrivono nelle 3 lingue.
3. **NotebookLM** — si caricano i materiali del corso e l'alunno (o il docente)
   fa domande e ottiene spiegazioni; utile come supporto nella loro lingua.
4. **Traduzione della pagina nel browser** — gratuita, immediata, sempre
   disponibile: da insegnare come prima mossa.

## 05 Esempio pratico: un quiz trilingue su Google Moduli con uno script

Questo è un esempio concreto di "cosa stiamo facendo" e di come si gestisce uno
**script** (un piccolo programma che fa un lavoro noioso al posto nostro).

### 05.1 Il problema
1. Scrivere a mano un quiz su Google Moduli **in tre lingue** è lunghissimo:
   ogni domanda va ripetuta in italiano, arabo e cinese.

### 05.2 La soluzione (lo script)
1. Usiamo un piccolo script di **Google Apps Script**: lo eseguiamo una volta e
   ci **costruisce il Modulo già pronto**, con tutte le domande trilingui e il
   punteggio automatico.
2. Il nostro esempio è il file

```
crea-modulo.gs
```

3. Come si esegue, in breve: si apre

```
script.google.com
```

   si crea un "Nuovo progetto", si **incolla** lo script, si sceglie la funzione
   `creaQuiz` e si preme **Esegui**; la prima volta si autorizza con l'account
   scuola. Nel registro compare il link del Modulo creato.

### 05.3 Come si gestisce lo script (importante)
1. Lo script **resta salvato** nel tuo account Google, in `script.google.com` →
   "I miei progetti": lo ritrovi quando vuoi, non si perde.
2. **Ogni esecuzione crea un Modulo NUOVO**, non sovrascrive il precedente. Se lo
   lanci più volte ottieni più Moduli: i doppioni inutili si cancellano da
   Google Drive.
3. Il **Modulo creato è indipendente**: una volta nato vive in Google Moduli e
   lo puoi modificare a mano lì, senza toccare lo script.
4. Per **cambiare le domande**: o modifichi il testo dentro lo script e
   ri-esegui, o modifichi direttamente il Modulo già creato.
5. Teniamo la **fonte** dello script versionata (su Git): così è riutilizzabile
   l'anno dopo o per un altro quiz, cambiando solo il testo delle domande.
6. Regola generale sugli script: **uno script fa sempre la stessa cosa** ogni
   volta che lo esegui; è comodo per lavori ripetitivi, ma ricordati che
   **rieseguirlo ripete l'azione** (qui: crea un altro Modulo).

## 06 Errori da evitare

1. Dare per scontato che l'alunno capisca il **testo dei bottoni in inglese**:
   spesso vede la pagina tradotta e non lo trova.
2. Consegnare **solo in italiano** e pensare "poi si arrangiano": chi non capisce
   si stacca subito.
3. Istruzioni **troppo sintetiche**: con la barriera di lingua servono più
   dettagli, non meno.
4. Puntare tutto sulla **spiegazione a voce**: chi non segue l'italiano parlato
   resta indietro. Serve sempre il supporto scritto/visivo.

## 07 Checklist rapida (prima di una lezione)

1. La consegna è **nelle 3 lingue**?
2. Ci sono **immagini/esempi** che si capiscono anche senza leggere?
3. I **bottoni** sono descritti per posizione e colore, non solo col nome inglese?
4. C'è una via di **consegna senza scrivere in italiano** (foto, disegno)?
5. L'alunno sa come **tradurre la pagina** e usare l'MD con la sua AI?
6. C'è una **piccola vittoria** raggiungibile nei primi minuti?

## 08 Changelog

1. **v0.1 (21/09/2026)**: prima versione. Principi, pratiche concrete, strumenti
   (Classroom, Moduli, NotebookLM, traduzione pagina) ed esempio del quiz
   trilingue su Moduli con lo script `crea-modulo.gs` e la sua gestione.
