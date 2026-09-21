# Quiz — Regole della classe e Versioning (per Google Moduli)

**Versione 1.1** — 21/09/2026
*Quiz trilingue (IT/AR/ZH) per interrogare la Classe 1 su: regole della classe e
versioning. Si crea su Google Moduli con lo script `crea-modulo.gs` (1 clic) e si
allega come Compito su Classroom. Documento interno per il docente (istruzioni +
chiave delle risposte). v1.1: aggiunta la guida illustrata passo-passo
`come-eseguire-script.html` → `Come-Eseguire-Script-v1.0.pdf` (con i disegni di
dove cliccare, compresa la schermata "app non verificata").*

## 1. Cosa contiene

1. `crea-modulo.gs` — lo **script** che crea il Modulo già pronto (quiz con
   punteggio automatico), 12 domande, ogni domanda in italiano, arabo e cinese.
2. Questo foglio — **istruzioni** per crearlo e **chiave delle risposte**.

## 2. Come creare il Modulo con lo script (passo-passo)

1. `[BROWSER]` apri il sito degli script di Google: indirizzo da scrivere così

```
script.google.com
```

2. `[BROWSER — sito Apps Script]` in alto a sinistra premi il bottone **"Nuovo progetto"** (in italiano; è il primo in alto).
3. `[BROWSER — editor Apps Script]` nel riquadro centrale del codice **seleziona tutto e cancella** il codice di esempio (`function myFunction() {}`).
4. `[BROWSER — editor Apps Script]` **incolla tutto** il contenuto del file `crea-modulo.gs`.
5. `[BROWSER — editor Apps Script]` nella barra in alto, nel menù a tendina delle funzioni, scegli **`creaQuiz`**.
6. `[BROWSER — editor Apps Script]` sempre in alto, premi il bottone **"Esegui"** (icona a forma di triangolino ▶).
7. `[BROWSER — finestra di autorizzazione]` la prima volta chiede il permesso: accedi col tuo **account scuola**, poi "Consenti" (in fondo). È normale.
8. `[BROWSER — editor Apps Script, in basso]` nel riquadro **"Registro di esecuzione"** compaiono due link: uno per **modificare** il Modulo, uno per **compilarlo**. Apri quello di modifica.

Fatto: il Modulo è creato con tutte le domande e le risposte giuste già segnate
(il punteggio si calcola da solo).

> Se non sei pratico di computer, segui la **guida illustrata** passo-passo con i
> disegni di dove cliccare: `come-eseguire-script.html` →
> `Come-Eseguire-Script-v1.0.pdf` (mostra anche la schermata "app non verificata").

## 3. Come allegarlo su Google Classroom

1. `[BROWSER — Google Classroom, corso Classe 1]` in alto scegli la scheda **"Lavori del corso"**.
2. `[BROWSER — Classroom, Lavori del corso]` premi il bottone **"+ Crea"** (in alto a sinistra) e scegli **"Compito"**.
3. `[BROWSER — Classroom, nuovo Compito]` in basso premi **"Aggiungi"** e scegli **"Google Moduli"**.
4. `[BROWSER — Classroom]` seleziona il Modulo del quiz appena creato.
5. `[BROWSER — Classroom]` a destra scrivi il titolo (es. "Quiz: regole e versioning") e premi **"Assegna"**.

Nota: Classroom, con un Modulo-quiz, può importare i voti in automatico.

## 4. Chiave delle risposte (per il docente)

1. Domanda 1 (regole): la **prima** opzione — alza la mano ben alta e aspetta la parola.
2. Domanda 2 (regole): la **prima** — puoi abbassare la mano, ti darà la parola.
3. Domanda 3 (regole): la **prima** — attivarti e fare l'esercitazione.
4. Domanda 4 (regole): la **prima** — no, niente YouTube.
5. Domanda 5 (regole): la **prima** — su Google Classroom.
6. Domanda 6 (versioning): la **prima** — il secondo numero (il 3).
7. Domanda 7 (versioning): **v1.3**.
8. Domanda 8 (versioning): **v2.0**.
9. Domanda 9 (versioning): la **prima** — un ramo che si stacca per lavorare senza rompere il resto.
10. Domanda 10 (versioning): la **prima** — riunire un ramo con quello principale.
11. Domanda 11 (versioning): la **prima** — aumento (bump) il numero e ne faccio una nuova.
12. Domanda 12 (versioning): la **prima** — è ancora in prova, non completa.

Nota: nello script le risposte giuste sono già marcate; qui la chiave serve solo
al docente per la correzione a mano o per il ripasso in classe.

## 5. Changelog

1. **v1.0 (21/09/2026)**: prima versione. Script `crea-modulo.gs` (12 domande
   trilingui, Regole + Versioning) + istruzioni + chiave delle risposte.
