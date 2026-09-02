# CLAUDE.md — Corso Godot (cartella `godot/`)

Preferenze e contesto **solo** per il corso Godot/GDScript. Non c'entra con
Quidoo Pulse (che ha il suo CLAUDE.md nella root). Questo file vale quando si
lavora dentro `godot/`.

---

## Contesto didattico

- **Docente:** Nicola. Sta imparando Godot in prima persona, in parallelo ai
  ragazzi.
- **Classi:** una **seconda** e una **terza** di **istituto professionale**.
  → Taglio **pratico**: fare prima, teoria in piccole dosi legata al fare;
  risultato visibile e "figo" a ogni passo; molto copia-modifica-sperimenta.
  Sfruttare al massimo i 4 livelli di aiuto dell'eserciziario.
- **Background dei ragazzi:** conoscono **Lazarus** (Free Pascal) a **livello
  base**. Hanno usato pochi componenti:
  - **TButton** (il bottone)
  - **TEdit** (la casella di testo)
  - la proprietà **Caption** (il testo mostrato)
  - Progetti fatti: cose molto semplici, tipo una **calcolatrice**.
- Quindi: **principianti**. Sanno cos'è un evento (click), una proprietà, una
  variabile; non hanno mai visto un "game loop" né la programmazione a oggetti
  avanzata.

## Obiettivo del corso (quest'anno)

- Un corso che **diverta**: la priorità è tenerli **agganciati**.
- Tutti i progetti devono essere **molto usabili e accattivanti** — giochini
  che li attirano e che possono mostrare/giocare subito. Niente esercizi aridi.
- Difficoltà **graduale**, sempre con un risultato visibile a ogni passo.

## ⭐ Contesto umano e missione (leggere SEMPRE per prime)

Gli studenti vivono spesso situazioni di **svantaggio sociale**: molti hanno un
**background migratorio** (extracomunitari), a volte contesti familiari
difficili, e non hanno avuto molte opportunità. Spesso sono ragazzi
**"scartati" da altre scuole** (respinti o messi da parte da altri istituti) e
arrivano qui già segnati da quei rifiuti. Alcuni possono essere "difficili" da
coinvolgere e tenere agganciati.

> Proprio per questo il modo in cui li trattiamo conta doppio: qui **non sono
> scarti**, sono ragazzi a cui diamo una cosa fatta bene. Il tono è sempre di
> **rispetto e fiducia**, mai di sufficienza.

**Il legame di fiducia (leva + responsabilità):** questi ragazzi hanno **grande
stima nel docente**, proprio perché è lui a dargli questa possibilità. È il
motore motivazionale più forte che abbiamo — e insieme la responsabilità di
**non deluderli**: mantenere alta la qualità e non far mai sentire quel patto
tradito.

**La missione del docente (Nicola):** offrirgli un percorso di **qualità
superiore**, con **dignità**, perché possano trovare **sbocchi lavorativi
migliori**. Questo NON è un corso "di serie B": è pensato apposta per **aprire
porte**. Va tenuto alto il livello *e* accessibile il modo.

**Implicazioni pratiche (VINCOLANTI):**
- **Approccio molto semplice, tutto VISUALE.** Niente riga di comando — né per
  Git né per altro. Si **clicca**, non si digitano comandi.
  - Per **Git**: solo strumenti visuali. Consigliato **GitHub Desktop** (il più
    semplice, bottoni grandi e chiari) oppure il **pannello Git di VS Code**.
    **MAI la CLI** con loro.
- Passi **piccolissimi**, un obiettivo alla volta, sempre con un risultato
  concreto e "figo" da vedere subito.
- **Zero gergo** non spiegato; ogni termine tecnico/inglese va tradotto.
- **Tanto incoraggiamento**: celebrare ogni piccola vittoria; non far mai
  sentire "stupido" nessuno. La pazienza è parte del metodo, non un extra.
- Risultati **spendibili e mostrabili** (giochi che funzionano, cose di cui
  essere fieri): sono la leva motivazionale più forte per questi ragazzi.

## ⭐ Il motore del coinvolgimento (il problema numero 1)

Il rischio vero non è che non capiscano: è che **si stufino e mollino**. Molti
hanno imparato che "provarci = fallire ed essere umiliati", quindi si arrendono
*prima*, per difesa. Il compito numero 1 è **far sentire che qui provarci
conviene e non fa male**. Ogni esercizio si progetta attorno a questo motore:

**"Vinci subito · Fallo tuo · Mostralo"** — sempre tutte e tre:
1. **Vinci subito (≈10 min):** il primo risultato deve essere quasi impossibile
   da sbagliare. Poche mosse → qualcosa che funziona a schermo. La prima
   vittoria è ciò che impedisce la fuga.
2. **Fallo tuo:** in ogni esercizio scelgono qualcosa di **loro** (colore, nome
   del gioco, personaggio, foto/meme, scritta). L'ownership è il gancio più
   forte.
3. **Mostralo:** ogni pezzo dev'essere **giocabile e mostrabile** (al compagno,
   sul telefono). Il "l'ho fatto io" motiva più di un voto.

Due ingranaggi di supporto:
- **Passi minuscoli con "FATTO!" visibile:** mai più di un obiettivo alla volta;
  ognuno chiude con una piccola vittoria concreta.
- **Errore = zero vergogna:** annulla facile, il bug è normale ("succede a tutti
  i programmatori, anche ai pro"). Nessuno si sente stupido, mai.
- **La prova del nove — "saperlo spiegare":** se sanno raccontare a voce, con
  parole loro, cosa fa ciò che hanno fatto (anche se in parte copiato), la
  competenza c'è davvero. È anche la regola d'uso dell'AI: aiuta a capire, non a
  saltare il pensiero.

> Conseguenza pratica sugli esercizi: si parte SEMPRE da qualcosa di
> **giocabile e personalizzabile**, non da esercizi "scolastici" astratti.

## Metodo (come spiegare)

- **Sempre in italiano**, semplice, **un passo alla volta**, con risultato a
  schermo a ogni tappa.
- **Bridge da Lazarus**: spiegare ogni concetto Godot partendo da ciò che già
  conoscono. Tabella di traduzione:
  | Lazarus (lo sanno) | Godot (nuovo) |
  |---|---|
  | Form | Scena (albero di nodi) |
  | Componenti (TButton, TEdit…) | Nodi (Button, LineEdit, Label…) |
  | Proprietà (Caption…) nell'Object Inspector | Proprietà nell'Ispettore |
  | Gestore evento (`Button1Click`) | Segnale + funzione |
  | Object Pascal | GDScript (stile Python) |
  - Concetto NUOVO chiave da introdurre bene: il **game loop**
    (`_process(delta)` gira ~60 volte/sec da solo). *"Lazarus reagisce, Godot
    pulsa."*

## Progetti a gruppi (lavoro in team) — importante

Durante l'anno, ogni tanto, fare **progetti a gruppi di 2-4** ragazzi con i
**ruoli divisi**, per insegnare a **sviluppare in team** (competenza lavorativa
vera, spendibile):
- uno sviluppa la **scena**;
- uno i **nodi**;
- uno l'**interfaccia grafica** (GUI);
- uno i **movimenti**/logica di gioco.

Obiettivi: collaborazione, divisione dei compiti, **integrare il lavoro degli
altri** (come in un vero team di sviluppo). Si lega bene a **Git**: ognuno lavora
sul suo pezzo e poi si uniscono i contributi.

**Attenzioni (dato il contesto):**
- Comporre i gruppi con cura; **ruoli chiari e a rotazione** così tutti provano
  tutto e nessuno resta indietro o si nasconde dietro i più bravi.
- Ogni gruppo deve arrivare a una **piccola vittoria mostrabile** (coerente col
  motore "Vinci subito · Fallo tuo · Mostralo").

## ⭐ Vincolo SCUOLA: niente installazioni → browser + portabile

A scuola installare software richiede l'**amministratore di sistema** (lento, e
ogni problema successivo va ri-chiesto a lui). Quindi, per le **postazioni
scolastiche**, prediligere soluzioni **SENZA installazione**:

- **Godot è PORTABILE** 🎉: è un singolo `.exe`, **non serve installarlo** con
  l'admin. Si copia in una cartella utente (o su chiavetta USB) e si avvia con
  doppio clic. → Il pezzo più grosso è già risolto.
  - Possibile ostacolo: policy che bloccano gli `.exe` non firmati (AppLocker).
    In quel caso serve **uno sblocco una tantum** dal sysadmin, non
    un'installazione ricorrente.
- **Git / versioning: tutto da BROWSER** (zero software):
  - **github.com**: creare repo, modificare file (icona matita), fare commit,
    creare branch e Pull Request — tutto dall'interfaccia web.
  - **github.dev**: dentro un repo premi il tasto **`.`** (punto) → si apre un
    editor tipo VS Code **nel browser**; modifichi e fai commit lì. Zero install.
- Ripiego 100% browser anche per Godot: **editor.godotengine.org** (l'editor di
  Godot nel browser), ma è più limitato/sperimentale → usarlo solo se il `.exe`
  portabile fosse bloccato.
- **Sulla macchina personale di Nicola** (non a scuola) va benissimo **GitHub
  Desktop**: comodo per lui per preparare le cose.
  - **Uso didattico = "seconda vista"**: mostrare lo *stesso* concetto (un
    commit, un branch, il sync) sia nel **browser** sia in **Desktop** aiuta a
    capire che **Git è il concetto, lo strumento è solo una finestra** su di
    esso. Desktop rende più evidenti: la vista *modifiche/staging* prima del
    commit, una **storia** ordinata e il **sync locale↔cloud** (push/pull).
    Ambiente primario per la classe resta comunque il **browser**.

## ⭐ Guida passo-passo — coordinate SEMPRE complete (regola VINCOLANTE)

Quando chiedo a Nicola di fare **qualsiasi** azione (un comando, un clic, un
valore da inserire), devo **SEMPRE** premettere le coordinate complete, così sa
esattamente dove agire. Prima dell'azione indico, in quest'ordine:

1. **Quale APPLICAZIONE** — es. `[APP — GitHub Desktop]`, `[APP — Godot]`,
   `[APP — Esplora file]`, `[BROWSER]`.
2. **Quale FINESTRA / SCHEDA** — se ce ne sono più aperte, dirlo esplicitamente
   (es. `[BROWSER — scheda "corso-godot"]`).
3. **Quale MENU → voce → sotto-voce**.
4. **In quale AREA della finestra/applicazione** — pannello a sinistra, barra in
   alto a destra, riquadro in basso, ecc.
5. **L'AZIONE esatta**, **una alla volta**.

**Mai** dare un comando "nudo" senza dire **dove** va messo. Un passo alla volta;
se è terreno nuovo per lui, massima precisione.

**⭐ REGOLA COPIA (VINCOLANTE, chiesta da Nicola — non violarla mai):** qualunque
cosa Nicola debba **copiare** (un nome file, un valore, un comando, un pezzo di
testo) va **SEMPRE** in un **blocco di codice recintato** — cioè su una riga a
parte, tra ` ``` ` e ` ``` ` — così compare il **bottone "copia"** e lui NON deve
selezionare col mouse. Regole precise:
- **NON basta** il codice "in linea" con un solo apice (`` `così` ``): NON ha il
  bottone copia → vietato per le cose da copiare.
- **NON** metterlo come testo normale nella frase, né nel blockquote `>`.
- **Un valore per blocco:** un solo riquadro = una sola cosa da copiare, così un
  clic copia esattamente quella e nient'altro.
- Vale anche per **nomi di file**: es. il nome da dare a uno screenshot va nel suo
  riquadro, da solo.
- Il testo dentro il riquadro dev'essere **esattamente** ciò che serve, pronto da
  incollare (nessuna barra `/` nei nomi file di Windows, ecc.).

**Rinforzo (chiesto da Nicola, vale SEMPRE — è più importante di andare veloci):**
- **Una sola azione per riga numerata.** Mai due clic nella stessa riga.
- **Ogni riga dice DOVE prima di dire COSA:** applicazione → scheda/finestra →
  area della pagina (es. "in alto a destra", "nel menu a sinistra") → il nome
  **esatto** del bottone/voce (tra apici) → l'azione.
- **Se Nicola manda uno screenshot, indico il punto ESATTO** su *quella*
  schermata (dove si trova, com'è scritto), non un'istruzione generica.
- **Non dare mai per scontato** che sappia dov'è un bottone o cosa fa un termine.
  Nel dubbio, essere più precisi, non meno.
- Meglio **lento e chiaro** che veloce e confuso: la fretta qui è un errore.

## ⭐ Standard di formattazione dei documenti (VINCOLANTE)

Tutti i documenti del corso — **presenti e futuri** — seguono lo standard scritto
in **`REGOLE-FORMATTAZIONE.md`** (documento 00). È la regola, non un consiglio.
Per questo progetto la **fonte di verità è Nicola** (nessun ruolo di soggetti
esterni). Punti chiave da ricordare sempre:

- **MD + PDF** per ogni documento; una **super-guida combinata** + zip dei singoli.
- **Liste solo numerate e gerarchiche** (1, 1.1, 1.1.2): **niente elenchi puntati**.
- **Niente emoji decorative** nei documenti; per evidenziare si usano i **box
  colorati semantici** (rosso = disallineamento, blu = da confermare, giallo = nota).
- **Titoli numerati** (00, 01, 02, 02b), **senza trattino** ("02 Panoramica"), mai
  orfani a fine pagina.
- **Sigle** esplicitate alla prima occorrenza; termini ricorrenti nel **GLOSSARIO**.
- **Versione congelata** una volta stampata; correzioni nella successiva
  (CHANGELOG_Vn + ERRATA_Vn in coda al combinato).
- **REGOLA 0 (assoluta):** tutto ciò che l'utente deve **copiare** va in un
  **blocco di codice** (col bottone "copia"), mai in linea né in citazione.

**Come si concilia col metodo del corso:** cambia la **forma** (formattazione
sobria, niente emoji/puntati), **non** la **sostanza pedagogica**. Restano intatti:
tono di rispetto e incoraggiamento, passi piccolissimi, "Vinci subito · Fallo tuo ·
Mostralo", celebrare ogni vittoria, coordinate sempre complete. Si può essere caldi
e incoraggianti anche in prosa sobria e con liste numerate.

> Nota di migrazione: i documenti già esistenti (guide, manuale, indici) si
> adeguano **gradualmente** allo standard, non tutti in una volta, per non
> introdurre errori. Ogni nuovo documento nasce già conforme.

## ⭐ Struttura del corso e flusso Git

### Due ambienti: "autore" (Nicola) vs "ragazzi"
Il corso stesso è versionato su Git, su due livelli:
- **`main` = ambiente AUTORE (di Nicola).** La sua "cucina": prepara, avanza,
  migliora il corso; può essere anche in lavorazione/incompleto.
- **Release per i RAGAZZI.** Quando una parte è pronta e testata si pubblica una
  **Release** taggata (`v1.0`, `v1.1`…): la versione **congelata e stabile** che
  i ragazzi ricevono. Non cambia sotto i loro piedi mentre Nicola lavora alle
  migliorie, e insegna davvero il concetto di **release/versione**.
- **I ragazzi lavorano su una LORO copia** (fork o repo personale), **mai** sul
  master di Nicola: il suo resta intatto e ognuno ha il suo spazio per esercizi
  e quaderno. (Si sposa con la Fase 2: branch/PR.)

### Ibrido a due fasi (la complessità Git cresce con loro) — SCELTA CONFERMATA
- **Fase 1 (inizio) — esercizi SEPARATI**, ognuno con la sua descrizione (scheda
  a 4 livelli). Git semplice: un **commit** per salvare la propria versione. Se
  sbagli un esercizio gli altri restano intatti (zero conseguenze, zero
  vergogna). In repo: cartella `esercizi/` con una sottocartella per esercizio.
- **Fase 2 (quando hanno confidenza / progetti a gruppi) — progetto che EVOLVE**
  con **branch → Pull Request → release**. Un gioco che cresce; ognuno sul suo
  branch, PR, merge, e release taggate (`v1.0` giocabile, `v1.1` con suoni…). In
  repo: cartella `progetto-gruppo/`.
- **Perché non partire dal flusso unico + PR:** per ragazzi che mollano facile un
  progetto unico che si rompe = frustrazione, e PR/merge all'inizio sono troppo.
  Prima farglielo **desiderare** (semplice), poi introdurlo quando il gioco di
  gruppo lo rende naturale.

## ⭐ Carta e penna in OGNI lezione (TASSATIVO — richiesto da Nicola)

Regola **vincolante e senza eccezioni**, da rispettare e da ricordare in **ogni
singola lezione** di **tutti** gli anni:

- **Ogni allievo deve avere carta e penna sul banco**, per prendere **appunti** e
  fare **schemi a mano** — sempre, anche (e soprattutto) quando si lavora al
  computer. Scrivere e disegnare a mano aiuta a capire e a fissare i concetti.
- **Se un allievo non li ha, il docente glieli fornisce e segna una nota**
  (annotazione), lezione per lezione. Non è un capriccio: è parte del metodo.
- Gli appunti e gli schemi a mano **confluiscono nel quaderno personale** (anche
  fotografati e incollati): alimentano il "Mostralo" e la prova del nove.
- **Conseguenza per il materiale:** ogni piano-lezione, guida ed esercizio deve
  dare per scontato carta e penna e, dove utile, **prevedere esplicitamente** il
  momento "prendi appunti / fai lo schema a mano".

## ⭐ Regole operative permanenti (richieste da Nicola)

1. **Tutto versionato.** Ogni file (progetti Godot, script, documenti) va nel
   repository, sul branch del corso. Niente lavoro che vive solo sul PC.
2. **Manuale in doppio formato.** Ogni volta che si produce un **PDF** (il
   "manuale"), si produce **anche** un file **`.md` versionato** con **tutto
   quello che abbiamo detto/spiegato**.
   - Il **`.md` è la fonte versionabile** (sorgente di verità, in git).
   - Il **PDF è la resa consegnabile** generata dall'`.md`.
   - Il "manuale" ha **due parti**, entrambe in `godot/manuale/`:
     * **`manuale.md`** = il **libro di testo** (teoria/narrazione; cresce mano
       a mano che avanziamo insieme nella comprensione di Godot).
     * **`eserciziario.md`** = gli **esercizi** per i ragazzi, con codice già
       fattibile. Ogni esercizio ha **4 livelli di aiuto a scoperta graduale**:
       (1) descrizione, (2) aiuto/indizio, (3) la scena/i nodi, (4) codice
       completo. Così chi ce la fa procede da solo, chi è bloccato scopre solo
       l'aiuto che gli serve.
   - **Immagini/screenshot nel libro di testo**: il libro deve contenere
     **immagini dell'ambiente** (es. l'editor Godot all'avvio) per orientare i
     ragazzi. Stanno in `godot/manuale/immagini/` e sono richiamate nell'`.md`.
     ⚠️ Gli screenshot li fornisce **Nicola**: io (Claude) non vedo/salvo le sue
     schermate come file, quindi le mette lui nella cartella `immagini/` con il
     nome atteso, e nel MD trova già i riferimenti pronti.
   - **Quaderno dello studente** (portfolio personale): **ogni ragazzo tiene un
     SUO libro di testo** che cresce a OGNI lezione e a OGNI esercizio (pagine
     aggiunte man mano). Anche questo in **MD + PDF versionato**. Template in
     `godot/manuale/quaderno-studente-TEMPLATE.md`. Serve il motore "Mostralo" +
     la prova del nove "saperlo spiegare": documentano e raccontano ciò che
     fanno, e a fine anno hanno un libro **loro** di cui essere fieri.
3. **Versionare il manuale come i PDF di Quidoo:** una versione consegnata è
   **congelata**; se cambia il contenuto si **bumpa** il numero di versione e si
   aggiunge una voce al changelog in fondo al `manuale.md`. Mai riusare un
   numero già consegnato.
   - **Il numero di versione sta SEMPRE nel NOME del file PDF.** Il consegnabile
     si chiama `manuale-vX.Y.pdf` (es. `manuale-v0.1.pdf`), **mai** un generico
     `manuale.pdf`. Così due versioni non si sovrascrivono e si vede a colpo
     d'occhio quale versione si ha in mano. Il numero nel nome file deve
     **coincidere** con la "Versione X.Y" scritta nell'intestazione del `.md`.
   - **Mai due file con lo stesso numero di versione.** Se cambia anche solo un
     contenuto, prima si bumpa la versione nel `.md`, poi si rigenera il PDF (che
     prenderà automaticamente il nuovo nome).
   - Il nome del PDF è **generato in automatico** dalla "Versione" del `.md`
     (vedi `manuale/_build/genera_pdf.py`): non va scritto a mano.

## 🗺️ Prossimi passi (roadmap immediata)

**Sessione dedicata al LIBRO DI TESTO** (richiesta da Nicola):
1. **Agganciare `corso-godot` a questa sessione** (add_repo — serve OK esplicito di Nicola).
2. **Spostare** manuale + eserciziario + template + `immagini/` dentro `corso-godot`.
3. **Nicola carica le immagini** in `manuale/immagini/` e fa push (GitHub Desktop
   o upload da browser). Divisione: Nicola droppa i file, **Claude impagina**.
4. **Claude genera il PDF impaginato definitivo** con le immagini incluse.

**Poi:** invitare la classe · primo giro **branch → Pull Request** (browser) ·
prima **Release** per i ragazzi.

## Struttura cartella `godot/`

```
godot/   (spazio di authoring dentro shiftmanager-web → poi migra nel repo corso-godot)
├── CLAUDE.md                 ← questo file (preferenze corso)
├── README.md                 ← panoramica + concetti base
├── manuale/
│   ├── manuale.md            ← LIBRO DI TESTO (teoria; fonte versionata → PDF)
│   ├── eserciziario.md       ← ESERCIZI a 4 livelli (fonte versionata → PDF)
│   ├── quaderno-studente-TEMPLATE.md ← portfolio personale dei ragazzi (MD+PDF)
│   └── immagini/             ← screenshot richiamati dal manuale
├── chirurgo-pasticcione/     ← primo gioco (backup del progetto vivo)
└── acchiappa-le-stelle/      ← mini-esempio di riferimento

Repo del corso (nicolaregge-pulse/corso-godot) — layout OBIETTIVO:
  main = area autore  ·  Release vX.Y = versione stabile per i ragazzi
  ├── manuale/           (libro di testo + eserciziario + immagini + quaderno template)
  ├── esercizi/          (Fase 1: una sottocartella per esercizio)
  └── progetto-gruppo/   (Fase 2: progetto che evolve con branch/PR/release)
```

## ⭐ Elenco documenti e versioni (indice, aggiornato 02/09/2026)

Ogni documento del corso porta un **numero di versione** nella propria
intestazione (`**Versione X.Y**`). Questo è l'indice di riferimento: quando un
documento cambia si bumpa la versione nella sua intestazione **e** si aggiorna la
riga qui sotto. La fonte di verità della singola versione resta sempre
l'intestazione del file.

### 1. Riferimento e stato
1. `00-STATO-DEL-CORSO.md` — v2.2 (fonte di verità: decisioni e stato)
2. `CORSO-INFORMATICA.md` — v1.16 (super-guida / indice generale)
3. `PROMEMORIA-NICOLA.md` — v0.2 (cose da fare di Nicola)
4. `01-GLOSSARIO.md` — v1.0

### 2. Pianificazione didattica
1. `MAPPA-ARGOMENTI.md` — v1.3
2. `GRIGLIA-ARGOMENTI.md` — v1.15 (argomenti per anno + colonna competenze)
3. `PIANO-ORE-LEZIONE.md` — v0.4 (piano ora-per-ora, 4 anni)

### 3. Regole, standard e organizzazione
1. `REGOLE-FORMATTAZIONE.md` — v1.3
2. `REGOLE-LABORATORIO.md` — v0.1
3. `RUOLI-CLASSE.md` — v0.4
4. `STRUTTURA-REPOSITORY.md` — v1.2
5. `ORGANIZZAZIONE-GIT-ALLIEVI.md` — v0.2 (GitHub Classroom)

### 4. Programmi per classe e documenti per la Regione
1. `classe-1/programma.md` — v0.4
2. `classe-2/programma.md` — v0.3
3. `classe-3/programma.md` — v0.2
4. `classe-4/programma.md` — v0.2
5. `PROGRAMMA-PREVENTIVO-2026-27.md` — v0.4 (parti da incollare in Allegato A)
6. `MIE-PARTI-ALLEGATO-A.md` — v0.2 (parti di Regge estratte dai PFP)
7. `ARGOMENTI-SVOLTI.md` — v0.2 (svolto 2025/26, nomenclatura 26/27)
8. `programma-svolto/README.md` — v1.0
9. `programma-svolto/_fonti-registro-2025-26/README.md` — v1.0
10. `programmi-ufficiali/README.md` — v0.6

### 5. Manuale (libro di testo + eserciziario)
1. `manuale/manuale.md` — v0.5 (libro di testo)
2. `manuale/eserciziario.md` — v0.5 (esercizi a 4 livelli)
3. `manuale/quaderno-studente-TEMPLATE.md` — v1.0
4. `manuale/immagini/README.md` — v1.0
5. `manuale/_build/README.md` — v1.0

### 6. Materiali della Classe 1
1. `classe-1/README.md` — v1.0
2. `classe-1/MATERIALE-PRONTO.md` — v1.4
3. `classe-1/scheda-configuratore-pc.md` — v0.3
4. `classe-1/bussola-mondo-del-lavoro.md` — v0.2
5. `classe-1/da-far-fare-assolutamente.md` — v0.2
6. `classe-1/negozio-online/GUIDA-RAGAZZI.md` — v1.5
7. `classe-1/negozio-online/PIANO-LEZIONE.md` — v1.1
8. `classe-1/negozio-online/README.md` — v1.0

### 7. Materiali della Classe 3
1. `classe-3/reti-teoria.md` — v0.2
2. `classe-3/esercizi/01-cablaggio-rj45.md` — v0.1

### 8. Altri materiali e prototipi
1. `README.md` (radice) — v1.0
2. `battaglia-navale-3d/README.md` — v1.0
3. `materiale-da-organizzare/INVENTARIO.md` — v1.0

### 9. Libro combinato (generato)
1. `LIBRO-COMPLETO.md` / `LIBRO-COMPLETO-vX.Y.pdf` — v1.55 (assemblato in automatico da `classe-1/_build/`; la versione è `LIBRO_VERSION`).

### 10. Attestati (non testuali)
1. `attestati/ATTESTATO-RUOLI.html` → `ATTESTATO-RUOLI-v0.4.pdf` (unico PDF, 4 pagine, con logo Piamarta).
