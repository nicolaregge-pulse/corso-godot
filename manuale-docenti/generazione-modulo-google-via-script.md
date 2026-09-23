# Manuale docenti — Generazione di un Modulo Google via script

**Versione 0.1** — 23/09/2026
*Capitolo del manuale per i docenti: come creare in automatico un'esercitazione
(quiz) su Google Moduli usando un piccolo script (Google Apps Script), invece di
inserire le domande a mano una per una. Basato sulla procedura provata in classe
il 23/09/2026 (funzionante). Documento interno per il docente.*

## 00 A cosa serve

1. Creare un **quiz/esercitazione su Google Moduli** in automatico, con le
   domande, le risposte esatte e il **punteggio automatico** già impostati.
2. È molto utile quando le domande sono **tante** o **trilingui** (IT/AR/ZH):
   scriverle a mano nel Modulo sarebbe lunghissimo.
3. Lo script si esegue **una volta** e genera il Modulo pronto.

## 01 L'idea in breve

1. Uno **script** è un piccolo programma. Il nostro legge un **elenco di domande**
   e costruisce il Modulo al posto nostro.
2. Ogni domanda ha un **testo** e alcune **opzioni**; una è segnata come giusta.
3. Lo script mette tutto nel Modulo e attiva il punteggio automatico.

## 02 Com'è fatto lo script (struttura)

1. Comincia con `function creaQuiz(){` e finisce con `}`.
2. Contiene un elenco `D` con **una riga per domanda**. Ogni riga è così:
   `["Testo della domanda", [["opzione giusta", true], ["opzione sbagliata", false], ...]]`.
3. La parola **`true`** segna la **risposta giusta** (è la chiave delle risposte).
4. Regola pratica: **una riga per domanda** — così quando si incolla il testo non
   si spezza a metà.

Esempio breve (2 domande) — quello completo sull'hardware è in
`classe-1/quiz-hardware/crea-modulo-hardware.gs`:

```
function creaQuiz(){
  var f=FormApp.create("Esercitazione - Hardware del PC").setIsQuiz(true);
  var D=[
  ["A cosa serve la CPU?",[["È il cervello del PC: fa i calcoli",true],["Conserva i file",false]]],
  ["Dove si salvano i file in modo permanente?",[["Nel disco (Hard Disk o SSD)",true],["Nella RAM",false]]]
  ];
  D.forEach(function(q){var i=f.addMultipleChoiceItem();i.setTitle(q[0]).setPoints(1).setRequired(true);i.setChoices(q[1].map(function(o){return i.createChoice(o[0],o[1]);}));});
  Logger.log("PRONTO. Modifica: "+f.getEditUrl());
}
```

## 03 Come eseguire lo script (passo-passo, provato)

1. Nella **barra dell'indirizzo** del browser scrivi

```
script.new
```

   e premi Invio: si apre un progetto nuovo (accedi con l'account scuola).
2. Nel riquadro del codice al centro: premi **Ctrl+A** poi **Canc** (svuotalo).
3. **Incolla** lo script (Ctrl+V). Controlla che l'**ultima riga** sia una graffa `}`.
4. Premi **Ctrl+S** (salva): la scritta "Modifiche non salvate" sparisce.
5. In alto, nel menù delle funzioni (dove c'è "Nessuna funzione"), scegli **`creaQuiz`**.
6. Premi **"Esegui"** (il triangolino ▶ a sinistra, accanto a "Debug"). Attenzione:
   **NON** premere "Esegui il deployment" (il bottone blu in alto a destra).
7. La prima volta chiede il permesso: **"Rivedi autorizzazioni"** → scegli
   l'**account scuola** → se compare "Google non ha verificato questa app", clicca
   **"Avanzate"** → **"Vai a Progetto senza titolo (non sicuro)"** → poi **"Consenti"**.
8. In basso, nel **"Log esecuzione"**, compare **"PRONTO. Modifica: https://…"** e
   **"Esecuzione completata"**. **Clicca quel link**: si apre il Modulo già pronto.

## 04 Allegare il Modulo su Google Classroom

1. In Classroom, apri il corso → scheda **"Lavori del corso"**.
2. In alto a sinistra premi **"+ Crea"** → **"Compito"**.
3. In basso premi **"Aggiungi"** → **"Google Moduli"** → scegli il quiz creato.
4. Scrivi il titolo e premi **"Assegna"**.

## 05 Cambiare le domande

1. Riapri lo script (resta salvato in `script.new` → "I miei progetti").
2. Modifica il testo dentro `D`: cambia domande, opzioni e la parola `true` (che
   segna la risposta giusta).
3. Ri-esegui: si crea un **nuovo** Modulo (non modifica il vecchio).

## 06 Errori da evitare (imparati in classe)

1. **Non usare "Esegui il deployment"** (bottone blu in alto a destra): non serve
   e apre una finestra "Nuovo deployment" che confonde. Si usa **"Esegui"** a sinistra.
2. **Incolla troncato** (errore "Unexpected end of input"): la copia si è spezzata.
   Rifai copia-incolla, usa la versione **compatta** (una riga per domanda) e
   controlla che l'ultima riga sia `}`.
3. **"Google non ha verificato questa app"** è **normale**: Avanzate → Vai a…
   (non sicuro) → Consenti. È roba tua, è sicura.
4. **Rieseguendo** si creano **più Moduli** uguali: i doppioni inutili si
   cancellano da Google Drive (cestino).

## 07 Note utili

1. Le domande possono essere **trilingui** (italiano/arabo/cinese) nel testo.
2. La **chiave delle risposte** è già dentro lo script (le opzioni con `true`).
3. Lo script si riusa l'anno dopo o per altri argomenti cambiando solo le domande.

## 08 Changelog

1. **v0.1 (23/09/2026)**: primo capitolo, scritto dopo la prima creazione riuscita
   in classe (quiz Hardware del PC). Struttura dello script, esecuzione passo-passo,
   allegare su Classroom, come cambiare le domande, errori da evitare.
