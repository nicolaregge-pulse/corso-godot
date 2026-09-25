# Regole nostre — Nicola & Claude (convenzioni di lavoro)

**Versione 2.0** — 25/09/2026
*Convenzioni operative INTERNE tra Nicola e Claude. NON sono le regole per i
ragazzi (quelle stanno nei materiali di classe, es. `classe-1/regole-classe/`).*

> **Come è ordinato questo file (riorganizzazione v2.0):** in cima le poche cose
> da non sbagliare mai (**Regole d'oro**) e la **Checklist pre-invio**; poi tutte
> le regole raggruppate per tema, dalla più importante alla più minore; in fondo
> il changelog. I numeri storici delle regole (2.9, 2.14, …) sono **mantenuti**
> come etichette, così i rimandi restano validi.

---

## A. ⛔ REGOLE D'ORO — non violare mai

1. **Classe giusta.** Prima di generare, **incrocio il registro** e **verifico il
   primo e l'ultimo cognome** contro di esso; nel dubbio **chiedo**, non assumo.
   *(dettaglio: §2.24 e §2.7)*
2. **Lingua giusta.** Ogni classe ha la sua: **1ª** IT/AR/ZH · **2ª** IT · **3ª**
   IT (+ copia IT-bangla solo per Rafi) · **4ª** IT. Il **glossario dei termini**
   va in **tutte le lingue presenti** nella classe. *(§2.14, §2.25)*
3. **Versione.** **Bump a ogni modifica**; mai riusare un numero; nome file e
   intestazione devono coincidere. *(§2.15)*
4. **Controllo pre-invio.** Nessun file esce senza i controlli della sezione B.
5. **File per il docente = SENZA password.** Le protezioni valgono solo per i
   file destinati agli allievi. *(§2.11, §2.20)*
6. **Esempi eterogenei + termini spiegati.** Non file di grafi uguali: esempi da
   mondi diversi; ogni termine tecnico spiegato con un'analogia. *(§2.25)*

## B. ✅ CHECKLIST PRE-INVIO

**B.0 — Campione da approvare (per ogni NUOVA tipologia di documento).**
Quando iniziamo un **tipo di documento** nuovo, prima genero **un solo esempio, il
più completo di quella tipologia**, e lo mando **senza password** a Nicola da
controllare. Solo **dopo l'ok** genero tutti gli altri della stessa tipologia.

**B.1 — Controlli su OGNI file, prima di premere invia:**
1. **Classe** corretta (registro + cognomi) e scritta bene **dentro** il documento.
2. **Lingua** corretta per quella classe; se è "solo italiano" → **0 caratteri di
   altre lingue** (verifica automatica).
3. **Versione** bumpata e **coerente** tra nome file e intestazione. *(§2.15)*
4. **Nome file** secondo lo schema §2.9 (`DATA_CHI_vX.Y_OGGETTO_LINGUA`); se è un
   file vecchio fuori standard, **rinominarlo prima**. *(§2.23)*
5. Se è un file **per il docente** → **senza password**.

## C. Convenzioni di dialogo

### 1. PPP — "parcheggia, parcheggia, parcheggia"
1. **Significato:** *prendi in considerazione ma **non** dare l'output finché non
   ti dico **"avanti"***. A voce l'equivalente è "parcheggia, parcheggia, parcheggia".
2. **Nel frattempo preparo:** appena vedo `PPP` **inizio a preparare** (ragionamento,
   bozza, file), ma **non consegno** finché non arriva **"avanti"**.
2bis. **Subito e in silenzio:** il PPP va recepito subito; si rimanda solo la
   **consegna** dell'output, non il ragionamento.
3. Serve a **non far scorrere la chat**.
4. **Eccezione:** se dentro il `PPP` c'è un ordine esplicito e concreto (es. "dammi
   il PDF", "committa"), **quello lo eseguo subito**.

### 2.19 Interazioni brevi (Nicola ha poco tempo)
1. Rispondere con **poco testo**: confermare in poche righe, andare al sodo.

## D. Naming dei file

### 2.9 Schema fisso: DATA · CHI · VERSIONE · OGGETTO · (LINGUA)
1. Formato: **`AAAAMMGG_Chi_vX.Y_Descrizione_Lingua.ext`**
   - `AAAAMMGG` = **DATA** (ordina i file da sola).
   - `Chi` = **CLASSE / di chi è / area**:
     - tutta una classe → `Classe-N-PerTutti` (es. `Classe-2-PerTutti`);
     - singolo allievo → `Classe-N-Cognome-Nome`;
     - tema **generale** per tutte le classi → **`Comune`**;
     - interno **docente** → `Docente`; **Regione** (Allegato A/PFP) → `Regione`.
   - `vX.Y` = **VERSIONE** (coincide con l'intestazione).
   - `Descrizione` = **OGGETTO** (parole legate da trattino).
   - `Lingua` = `multilingua` oppure `IT`/`AR`/`ZH`/`IT-BN`; in coda, si omette se non serve.
2. L'ordine è **sempre** `DATA _ CHI _ VERSIONE _ OGGETTO _ (LINGUA)`.
3. **Materiale di classe vs personale:** se NON è personale ma di classe/generale,
   in `CHI` ci va sempre il marcatore (**`Classe-N-PerTutti`** o **`Comune`**),
   mai la cosa "nuda".
4. **Dentro lo ZIP dei libri individuali il naming si INVERTE:** i PDF interni
   iniziano da **`Cognome-Nome`**, poi oggetto, **data in fondo**
   (es. `Faruoli-Oscar_Libro-Individuale-Git_20260925.pdf`); lo **ZIP** invece
   resta con **data all'inizio** (`20260925_Classe-2_Libri-Individuali-Git_v1.0.zip`).
5. Esempi:
   - `20260924_Classe-1-Sala-Andrea_v1.0_Libro-Studente.pdf`
   - `20260924_Classe-1-PerTutti_v1.0_Standard-Configurazione-PC_IT.pdf`
   - `20260924_Comune_v1.0_Regole-Laboratorio_multilingua.pdf`
6. **Migrazione graduale**: i file esistenti si adeguano man mano.

### 2.13 Nome deterministico: dal nome si ricostruisce l'ALBERO delle cartelle
Obiettivo: dal **solo nome** di un file si capisce **dove va salvato**, così da un
mucchio di file scaricati si **ricostruisce automaticamente l'intera struttura a
cartelle** (Windows o Git).
1. Formato: `cartella__sottocartella__…__NomeFile.ext` — le cartelle del percorso
   all'inizio, separate da **`__` (doppio underscore)**.
2. Il `NomeFile` finale segue lo schema §2.9 datato; la classe è già data dal percorso.
3. **Ricostruzione:** si divide sui `__`; tutti i pezzi tranne l'ultimo sono cartelle.
   Su Git `__`→`/`, su Windows `__`→`\`.
4. Il singolo `_` resta separatore dei campi dentro il NomeFile; `__` solo per cartelle.
5. Esempi:
   - `classe-1__utenze-password__20260923_Le-Mie-Utenze-Password_multilingua_v1.0.pdf` → `classe-1/utenze-password/…`
   - `quaderni__classe-1__Sala-Andrea__20260923_Libro-Studente_v1.0.pdf` → `quaderni/classe-1/Sala-Andrea/…`
6. Strumento: `strumenti/nome-albero.py` (espandi/collassa). Utile per i file inviati "sciolti".
7. Vale da qui in poi; i file già dentro le cartelle non si rinominano.

### 2.6 Elenchi allievi ordinati per cognome
1. Ogni elenco va **ordinato per cognome, poi nome**, formato "Cognome Nome".
2. Se il cognome è incerto (nomi stranieri), lo segnalo.

## E. Lingue per classe

### 2.14 Mappa lingue (da ricordare)
0. **Ogni classe ha le SUE lingue.** Controllo questa mappa; **nel dubbio CHIEDO**:
   1. **Classe 1** → **trilingue IT · AR · ZH**.
   2. **Classe 2** → **solo italiano** (presenti allievi stranieri, ma materiali IT).
   3. **Classe 3** → **italiano** per tutti + copia **IT+bangla solo per Rafi**
      (nome file `...-Rafi_IT-BN`).
   4. **Classe 4** → **solo italiano**.
   5. Materiali **interni docente** → sempre italiano.
   *(schema completo delle classi: `SCHEMA-CLASSI-TIPOLOGIE.md`)*
1. In **Classe 1** ogni materiale per gli allievi si produce **sempre** nelle 3 lingue.
2. Formato preferito: **3 file monolingui** (`_IT`, `_AR`, `_ZH`), ognuno completo.
3. **Font PDF**: cinese **WenQuanYi Zen Hei**, arabo **Amiri** (`dir="rtl"`); PDF da HTML.
4. **Sigle e nomi di prodotto** (ATX, PCIe, GitHub, indirizzi/email) restano in
   lettere latine anche dentro arabo/cinese; i bottoni dei siti si descrivono per
   posizione+colore, non in inglese.
5. I materiali interni del docente restano in italiano.

## F. Metodo didattico

### 2.25 Esempi ETEROGENEI + spiegare SEMPRE i termini tecnici
1. **Esempi eterogenei, non ripetitivi.** Errore da non rifare: 5-15 grafi di Git
   quasi identici. Meglio **pochi esempi ma vari** da mondi diversi (app che si
   aggiorna, versioni di un videogioco, cronologia di Google Documenti, Wikipedia,
   ricetta migliorata, salvataggi di un gioco…).
2. **Ogni termine tecnico va spiegato** (branch, commit, merge, repository, push,
   pull): alla prima occorrenza, **parole semplici + analogia**, raccolti in un
   **dizionario**. Vale doppio per i non italofoni (Rafi non li conosceva).
2b. **Il glossario va in TUTTE le lingue presenti** nella classe (1ª IT/AR/ZH ·
   3ª IT+bangla · 2ª/4ª italiano + eventuali lingue dei non italofoni presenti).
3. La parte "casi d'uso" è un insieme di **situazioni diverse**, non una fila di
   grafi uguali; i grafi di Git con parsimonia e solo dopo che i termini sono chiari.

## G. Valutazioni, libri, griglia, dati riservati

### 2.8 Valutazioni commisurate + dati sensibili off-Git
1. Ogni valutazione dà **due letture**: **voto oggettivo** e **voto commisurato**
   (DVA→PEI; DSA/BES→non penalizzare forma; L2→non penalizzare l'italiano).
2. Tenerne conto **sempre**, non solo su richiesta.
3. **Dati sensibili** (certificazioni, diagnosi, situazioni, nomi di minori) =
   RISERVATI, **mai su Git**: solo scratchpad. Rif. `SITUAZIONE-ALUNNI-RISERVATO.md`.

### 2.10 Griglia di correzione (ogni volta)
Colonne per ciascun alunno: **Cognome Nome** (ordinato per cognome) · **data/ora
consegna** · **consegna** (Sì/Assente/Non consegnato, lista completa della classe) ·
**certificazione/difficoltà** · **voto oggettivo + commisurato** · **nota** breve.
7. Abbinamento file→alunno risolto da Claude (anche file "senza titolo", via
   proprietario/orario). Dati di minori solo in scratchpad.

### 2.11 Cosa consegno di default
1. A Nicola serve di norma **solo il PDF riservato** (voti + certificazioni): l'unico
   che mando in automatico.
2. Gli altri formati (Excel, PDF non sensibile, HTML) li tengo in scratchpad e li
   do **solo su richiesta**.
4. Voti in **centesimi (/100)**; presente che non consegna = **30**, assente = nessun voto.

### 2.20 Schede valutazione: documento unico versionato (RISERVATO)
1. Tutte le schede di valutazione (voti + certificazioni) in **UN unico documento
   versionato**, che cresce lezione per lezione. Vive in **scratchpad** (mai su Git)
   ma **sempre disponibile** per Nicola.
2. **Report ai ragazzi:** solo cose **sicure e dimostrabili**. Niente giudizi sul
   lessico né accuse di "troppa AI"; se c'è sospetto AI, restare **vaghi e in forma
   di domanda**.
3. **Libri dei ragazzi:** si generano **dopo** aver ricevuto consegne e valutazioni.

### 2.22 Niente dati riservati nei report degli allievi
1. I libretti consegnati al singolo allievo contengono **solo** il suo nome, il suo
   voto e la correzione del **suo** lavoro. **Mai** certificazioni, difficoltà o dati
   di altri allievi.
2. Motivo: se il file va all'indirizzo sbagliato, l'altro non deve vedere nulla di
   sensibile. I dati riservati vivono solo nella griglia del docente (2.20).

### 2.3 Materiali con le risposte: proteggere
1. **Mai** dare ai ragazzi un file con le **risposte** (chiave del docente).
2. **Due versioni separate**: studenti (senza risposte) e chiave docente (con
   risposte), nomi chiaramente diversi; sulla chiave scrivere "SOLO per te".

### 2.21 Come chiamare gli allievi (dalla prossima volta)
1. Negli output per gli allievi si usa il **nome con cui li chiama Nicola**.
2. I nomi preferiti si raccolgono in scratchpad; vale dalla prossima volta.

## H. Quando si è "in diretta in classe"

### 2.1 Prima ciò che FUNZIONA
1. Se Nicola agisce **davanti agli allievi**, priorità alla **soluzione minima che
   funziona subito**, non ai materiali belli.
2. Dare **una riga secca operativa**; i materiali vengono dopo.
3. **Non cambiare soluzione in continuazione:** scegliere una via e portarla a termine.

### 2.2 Comandi/script: copia-incolla, non file
1. Qualunque cosa da eseguire va in un **blocco di codice** (bottone copia), mai file.
2. Dare la **scorciatoia più diretta** (es. `script.new`).
3. Copie lunghe che si troncano: preferire versioni corte, far verificare l'ultima riga.

### 2.4 Il tempo della classe vale per tutti
1. Ogni minuto perso va moltiplicato per il numero di allievi.
2. Se Nicola dice "fermati": **fermarsi subito**, risposta minima, rimandare a dopo.

### 2.5 Non decidere COSA serve a Nicola
1. **Mai** dire "questo non ti serve": lo decide **solo Nicola**. Claude propone, non
   stabilisce le priorità al posto suo.

## I. Incrociare i dati

### 2.24 / 2.7 Incrociare SEMPRE i dati (VINCOLANTE)
1. Prima di chiedere o produrre, **incrocio tutte le fonti che ho** (registri/foto,
   scratchpad, messaggi precedenti). Le informazioni spesso ci sono già: **non
   chiedere** cose ricavabili dai dati.
2. Il **registro/foto** è la **fonte di verità** per nomi/classe/presenze; se qualcosa
   non torna, **ricontrollo** prima e segnalo solo un vero conflitto.
3. Abbinamenti file-anonimi→nomi (orari/screenshot/proprietario) li risolvo da solo.

## J. Workflow dei materiali

### 2.12 Conservazione integrale (verbatim)
1. Tutto ciò che Nicola detta e ogni **sbobinatura** si conserva anche **integrale
   (verbatim)**, non solo riassunta.
2. L'integrale può avere nomi di minori → **scratchpad**; la parte pulita va su Git.
   Flusso in `sbobinature/README.md`.

### 2.16 Bobina = trascrizione integrale delle chat
1. La **bobina** è il posto unico con la trascrizione **integrale** degli scambi
   Nicola↔Claude.
2. Contiene nomi di minori → **scratchpad, mai su Git**; da essa la parte pulita.

### 2.17 I tre livelli di "libro" (da non confondere)
1. **Libro dei ragazzi (quaderno personale):** cresce in ordine **CRONOLOGICO**.
   Assente → teoria+esercitazione inserite in **colore diverso**; se la rifà,
   ricompare più avanti. Nomi/lavori → scratchpad; aggiornamento a blocchi.
2. **Libro di classe** (`libro-classeN`): tutta la teoria della classe, **organico**;
   può arricchirsi con teoria da altre classi.
3. **Diario di classe** (`ARGOMENTI-SVOLTI`): solo le cose realmente fatte, in ordine
   **cronologico** (cita, non contiene la teoria).
4. **Libro totale** (`LIBRO-COMPLETO`): **non** è la somma dei 4; organizzato **per
   argomento** (una volta sola, alla massima profondità), con livelli in sequenza
   **[BASE · 1ª–2ª]** poi **[APPROFONDIMENTO · 3ª–4ª]** nello stesso capitolo.

### 2.18 Schede per lezione
1. Puntare al **più completo possibile** (teoria + esercitazione); ma può bastare 1 PDF.

## K. Formattazione

1. Tutti i documenti seguono **`REGOLE-FORMATTAZIONE.md`** (doc 00). Punti chiave:
   liste solo numerate/gerarchiche, niente emoji decorative (box colorati semantici),
   titoli numerati, MD + PDF, **tutto ciò da copiare in blocco di codice**.

## 3. Changelog

1. **v2.0 (25/09/2026)**: **riorganizzazione per importanza** — Regole d'oro e
   Checklist pre-invio in cima, regole raggruppate per tema (numeri storici
   mantenuti); precisazioni: campione senza password da approvare (B.0), marcatore
   di classe e inversione naming dentro lo zip dei libri (2.9.3-4). Aggiunta **2.25**
   (esempi eterogenei + termini spiegati + glossario nelle lingue presenti). Mappa
   lingue: 2ª e 4ª = solo italiano; 3ª = IT + bangla per Rafi.
2. **v1.7 (24/09/2026)**: 2.23 — controllare il nome file (schema 2.9) PRIMA di inviare.
3. **v1.6 (24/09/2026)**: 2.22 — nei report al singolo allievo solo nome/voto/correzione.
4. **v1.5 (24/09/2026)**: 2.21 — usare il nome con cui Nicola chiama gli allievi.
5. **v1.4 (24/09/2026)**: 2.17 — come si costruisce il libro totale (per argomento).
6. **v1.3 (24/09/2026)**: 2.17 — i tre livelli distinti (totale / classe / diario).
7. **v1.2 (24/09/2026)**: 2.20 — schede valutazione in un unico documento versionato.
8. **v1.1 (24/09/2026)**: 2.15, 2.16, 2.17, 2.18, 2.19.
9. **v1.0 (24/09/2026)**: ordine schema nomi file (2.9); aggiunta 2.14 (Classe 1 trilingue).
10. **v0.9 (23/09/2026)**: aree `Comune`/`Docente`/`Regione` (2.9).
11. **v0.8 (23/09/2026)**: 2.13 nome deterministico (percorso nel nome).
12. **v0.7 (23/09/2026)**: 2.12 conservazione integrale.
13. **v0.6 (23/09/2026)**: `Classe-N-PerTutti` per il materiale di classe.
14. **v0.5 (23/09/2026)**: nel `Chi` il file di un allievo include la classe.
15. **v0.4 (23/09/2026)**: schema nomi esteso col token `Chi`.
16. **v0.3 (23/09/2026)**: PPP subito e in silenzio; voti in centesimi; 2.11.
17. **v0.2 (21/09/2026)**: "Lezioni dagli errori" (2.1–2.5).
18. **v0.1 (21/09/2026)**: primo file; sigla PPP.
