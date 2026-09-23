# Struttura registri e gestione classi (1-4 INF)

**Versione 0.1** — 23/09/2026
*Documento per il docente. Definisce la STRUTTURA LOGICA con cui gestiamo le
quattro classi di Informatica (Prima, Seconda, Terza, Quarta): liste allievi,
registro voti, assenze e gestione dell'Allegato A. Qui c'e solo la struttura
(senza nomi): i dati reali con i nomi dei minori vivono FUORI dal repository.*

---

## 0. Regola di privacy (vincolante)

1. **Nomi di minori, certificazioni, difficolta, note disciplinari e assenze =
   RISERVATI: MAI su Git/GitHub.** Vivono solo nell'area privata del docente
   (i file `CLASSE-N-...-RISERVATO.xlsx`).
2. In questo repository sta **solo la struttura** (questo documento) e i **modelli
   vuoti**, senza alcun nome.

## 1. Un quaderno Excel per classe

Per ogni classe c'e **un file Excel** (`CLASSE-1-Prima`, `CLASSE-2-Seconda`,
`CLASSE-3-Terza`, `CLASSE-4-Quarta`), con **quattro fogli**:

1. **Allievi** — l'anagrafica della classe: N, Cognome e nome, Certificazione
   (DVA/DSA/BES), Difficolta / L2, Ruolo (Rallentatore, Guardiano di Carta e
   Penna, Responsabile del Laboratorio), Note. Le celle arancio segnalano una
   certificazione, le azzurre una difficolta segnalata.
2. **Registro voti** — la matrice allievi x verifiche. **Voti in centesimi
   (/100)**, con due letture per verifica: **O = voto oggettivo** e **C = voto
   commisurato** alle difficolta. Colori: verde >= 70, giallo 50-69, rosso < 50.
   Convenzione: **A** = assente, **NC** = presente ma non consegna (vale 30).
3. **Assenze** — la griglia allievi x date: **P** presente, **A** assente, **R**
   ritardo, **U** uscita; l'ultima colonna conta le assenze in automatico.
4. **Allegato A** — la traccia dello **svolto per competenza** (il "giallo/verde"):
   Competenza, Argomento previsto, Stato, Data svolto, Note. Alimenta il
   documento ufficiale per la Regione (vedi sez. 3).

## 2. Regole operative gia decise (richiamo)

1. **Firma ore entro le 14:05** (i registri si inviano alle 14:05; le ore non
   firmate si perdono dal monte ore). Si firma in aula il programma previsto,
   si corregge dopo.
2. **Due valutazioni sempre**: oggettiva + commisurata (DSA/BES -> PDP, non
   penalizzare la forma; L2 -> non penalizzare la lingua italiana).
3. **Domande al volo** (prova del nove): 70 = OK / 50 = KO; si annotano nel
   registro voti come voto rapido.
4. **Elenchi sempre per cognome** (formato "Cognome Nome").

## 3. Gestione dell'Allegato A (PFP) — flusso

1. **Sorgente**: le parti di Regge sono in `MIE-PARTI-ALLEGATO-A.md`; da li gli
   script generano `allegato-a-2026-27/allegato-a-classe-N.md` (testo per
   competenza) e `allegato-a-stato/` (stato giallo/verde in PDF).
2. **Preventivo**: a inizio anno si evidenzia in **giallo** tutto cio che si
   intende fare (da `PROGRAMMA-PREVENTIVO-2026-27.md`).
3. **Durante l'anno**: nel foglio "Allegato A" di ogni classe si aggiorna lo
   **Stato** lezione per lezione — voce fatta -> si toglie il giallo (Stato =
   fatto), voce non fatta -> si cancella. In parallelo si aggiorna il registro
   attivita `ARGOMENTI-SVOLTI-2026-27.md`.
4. **Fine anno**: resta scritto solo il **programma svolto**, ordinato per
   competenza e annualita, pronto da incollare nel docx ufficiale della Regione
   (`programmi-ufficiali/`). La classe 4 usa anche la rubrica di qualifica.
5. **Input che serve dal docente**: l'**esportazione Excel del registro
   elettronico** di ogni classe (fonte del "cosa e stato svolto"), piu le
   conferme sulla corrispondenza classe <-> annualita.

## 4. Corrispondenza file (dove sta cosa)

1. **In repository (Git), senza nomi**: questo documento; i modelli vuoti; i
   documenti dell'Allegato A (`MIE-PARTI`, `allegato-a-*`, `PROGRAMMA-PREVENTIVO`,
   `ARGOMENTI-SVOLTI-2026-27`).
2. **Fuori dal repository (area privata del docente), con i nomi**: i quattro
   file `CLASSE-N-...-RISERVATO.xlsx` (Allievi, Registro voti, Assenze, Allegato A).

## 5. Changelog

1. **v0.1 (23/09/2026)**: prima versione. Struttura a un Excel per classe con i
   quattro fogli (Allievi, Registro voti, Assenze, Allegato A); regola di privacy;
   flusso di gestione dell'Allegato A.
