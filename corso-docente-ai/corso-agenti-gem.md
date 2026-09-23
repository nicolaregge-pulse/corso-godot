# Corso per il docente — Agenti e GEM (usare l'AI come un professionista)

**Versione 1.0** — 23/09/2026
*Corso pratico per Nicola: capire e usare l'AI in tre livelli (chat → GEM →
agente), imparare a creare un GEM in Gemini e a "simulare un professionista"
(segretaria, correttore, programmatore…) con l'AI. Documento interno del docente
(area Docente), in italiano. Metodo: prova subito, personalizza, mostra; l'AI
aiuta a capire, non a saltare il pensiero; ogni schema prima a mano sul quaderno.
Si affianca a `INTELLIGENZA-ARTIFICIALE.md` (la versione per i ragazzi).*

---

## 00 Come funziona questo corso

1. È pensato per **te**, non per i ragazzi: qui puoi andare un po' più a fondo,
   perché poi sarai tu a portarlo in classe in forma semplice.
2. Strumento: **Gemini** (gratuito, l'unico disponibile a scuola). Gli assistenti
   personalizzati di Gemini si chiamano **Gem**.
3. Si procede a **piccoli passi con una vittoria concreta** ad ogni capitolo. Alla
   fine di ogni capitolo c'è un "prova subito".
4. **Carta e penna**: prima di creare un Gem, buttane giù a mano le 4 righe che lo
   descrivono (chi è, cosa fa, cosa non fa, con quali materiali).
5. **Regola d'oro (vincolante):** nei sistemi AI **non si inseriscono mai dati di
   minori** (nomi, voti, certificazioni, foto). Lo vediamo nel capitolo 06.

## 01 I tre livelli dell'AI (la scala da tenere in testa)

1. **Livello 1 — la chat semplice.** Apri Gemini e chiedi qualcosa: risponde una
   volta, senza memoria di "chi deve essere". Utile per domande al volo.
2. **Livello 2 — il GEM (assistente su misura).** È una chat a cui hai dato un
   **ruolo fisso**, delle **istruzioni** e, se vuoi, dei **documenti**. Risponde
   sempre "stando nel personaggio". È il livello che useremo di più.
3. **Livello 3 — l'agente (autonomo, con strumenti).** Non solo risponde: **agisce**
   (naviga, apre file, manda email) a cicli, finché non ha finito il compito.
4. Immagine mentale: il GEM è **un attore con un copione**; l'agente è **un
   assistente con le mani e gli strumenti** che fa il lavoro al posto tuo.

> Prova subito: apri `gemini.google.com`, fai una domanda normale (livello 1) e
> nota che, chiusa la chat, "dimentica" il ruolo. Questo è ciò che il GEM risolve.

## 02 Il GEM in pratica — le 4 leve

Un GEM si governa con **quattro leve**. Più sono chiare, meglio lavora.

1. **Ruolo / persona** — *chi è*: "Sei la segretaria del corso di informatica…".
2. **Istruzioni** — *come si comporta e cosa fa*: passi, tono, cosa deve produrre.
3. **Cosa NON fare** — i paletti: "Non inventare dati; se non sai, chiedi".
4. **Conoscenza** — i **file** che gli dai (le tue schede, un PDF): userà quelli.

Regola pratica: scrivi le istruzioni come le diresti a **una persona nuova al suo
primo giorno di lavoro**. Chiara, concreta, con un esempio.

### 02.1 Creare un GEM in Gemini (passo-passo)

1. `[BROWSER]` vai su `gemini.google.com` ed entra con l'**account scuola**.
2. Nel **menù a sinistra**, cerca la voce **"Gem"** (o "Esplora Gem" / "Gestione
   Gem"): è la sezione degli assistenti personalizzati.
3. In alto premi **"Nuovo Gem"** (bottone con il segno "+").
4. Nel campo **Nome** scrivi come si chiama (es. *Segretaria del corso*).
5. Nel campo **Istruzioni** incolla il testo del ruolo (vedi le ricette al cap. 04).
6. Se vuoi, in **"Conoscenza"** carica dei file (PDF/Documenti) da fargli usare.
7. Premi **"Salva"** (o "Aggiorna"). Il Gem ora compare nell'elenco a sinistra.
8. Cliccalo e **provalo** scrivendogli una richiesta.

> Nota: i nomi esatti dei bottoni possono cambiare (Google aggiorna spesso
> l'interfaccia) e a volte sono in inglese. Regola: cerca per **posizione**
> (menù a sinistra, bottone "+") più che per il testo esatto.

> Prova subito: crea un Gem "Tutor" con due righe di istruzioni e provalo.

## 03 "Simulare un professionista" (il cuore del corso)

1. Simulare un professionista con l'AI significa **darle un mestiere**: chi è, come
   lavora un bravo professionista di quel tipo, cosa produce e cosa non fa.
2. Per farlo bene servono **quattro ingredienti** (le stesse 4 leve del cap. 02):
   1. **Il ruolo**: "Sei un/una [mestiere] con 10 anni di esperienza".
   2. **Il metodo di lavoro**: i passi che segue un bravo professionista.
   3. **Gli standard e i paletti**: cosa cura, cosa non fa mai.
   4. **I materiali**: le regole/knowledge che deve seguire (i tuoi documenti).
3. Più il mestiere è **ben descritto**, più la simulazione è utile. "Fai la
   segretaria" dà poco; "Sei la segretaria del corso: scrivi email brevi e cortesi,
   riassumi in punti, non inventi date" dà molto.
4. **Limite onesto:** l'AI simula il *modo di ragionare e scrivere* del
   professionista, non la sua responsabilità. Le decisioni e la verifica restano tue.

## 04 Ricettario — GEM pronti per il tuo lavoro

Copia il testo nel campo **Istruzioni** del Gem (cap. 02.1) e adattalo. Ogni
ricetta è un professionista simulato.

### 04.1 GEM "Segretaria del corso"

```
Sei la segretaria del corso di informatica. Scrivi email e avvisi brevi, chiari e
cortesi. Quando ti do appunti disordinati, li trasformi in un elenco ordinato di
punti e in una bozza pronta da inviare. Fai sempre: 1) un titolo chiaro, 2) i punti
principali, 3) i prossimi passi con le scadenze. Non inventare date o nomi: se
mancano, lasciali tra parentesi quadre come [DA COMPLETARE]. Tono professionale e
gentile.
```

### 04.2 GEM "Progettista di esercizi trilingui"

```
Sei un progettista didattico esperto di studenti che non parlano bene l'italiano.
Quando ti chiedo un esercizio, lo scrivi "a prova di errore": istruzioni semplici,
un passo alla volta, spiegando anche a cosa servono gli strumenti. Lo fornisci in
tre lingue affiancate: italiano, arabo, cinese semplificato. Eviti il gergo; ogni
termine tecnico lo spieghi. Alla fine aggiungi una parte "fallo tuo" in cui lo
studente sceglie qualcosa di suo.
```

### 04.3 GEM "Tutor di programmazione (Godot / GDScript e Lazarus)"

```
Sei un tutor di programmazione paziente per principianti. Quando aiuti con del
codice (GDScript di Godot o Object Pascal di Lazarus), non dai subito la soluzione:
spieghi a parole semplici cosa fa il codice e guidi un passo alla volta. Usi esempi
legati ai giochi. Se c'è un errore, lo spieghi con calma ("succede a tutti") e
mostri come correggerlo. Alla fine chiedi allo studente di spiegarti a parole sue
cosa ha capito.
```

### 04.4 GEM "Correttore didattico (SENZA dati reali)"

```
Sei un correttore didattico. Ti incollo un testo ANONIMO (nessun nome). Dai due
letture: 1) un voto oggettivo sulla qualità del lavoro, 2) suggerimenti per
migliorare. Non penalizzi gli errori di lingua italiana se il concetto è corretto
(molti studenti sono di madrelingua non italiana): conta il contenuto compreso.
Sii incoraggiante: indica prima ciò che va bene, poi cosa migliorare.
```

> [ROSSO] Importante: al correttore incolli **solo testi anonimi**. Nomi, voti e
> dati degli allievi NON entrano mai nell'AI (vedi cap. 06).

### 04.5 GEM "Assistente Allegato A"

```
Sei un assistente per la programmazione didattica di un istituto professionale.
Ti do un elenco di argomenti svolti; tu mi aiuti a scriverli in modo formale e per
competenza, nell'ordine di un programma svolto (Allegato A / PFP). Chiedi tu i
dettagli che mancano (classe, competenza, data). Non inventi: se un dato manca lo
segnali. Output in italiano, sobrio.
```

## 05 Gli agenti (livello 3) — cosa puoi già fare oggi

1. Un **agente** ha un obiettivo, degli **strumenti** e lavora **a cicli**:
   pianifica → usa uno strumento → controlla il risultato → prosegue, finché ha
   finito. Se sbaglia, se ne accorge e riprova.
2. Oggi, con strumenti gratuiti, hai già "assaggi" di agente:
   1. **Gemini dentro Google Workspace**: può agire su Gmail, Documenti, Drive
      (riassumere una mail lunga, scrivere una bozza, creare un documento).
   2. **NotebookLM**: gli dai i tuoi materiali (i .md del corso) e diventa un
      "agente di studio" che risponde citando le fonti — utile per i ragazzi.
3. Gli agenti più potenti (che navigano, scrivono file, usano Git) di solito sono
   a pagamento o per sviluppatori. **Curiosità:** i documenti di questo corso sono
   preparati proprio con un agente di questo tipo (Claude Code), che usa file, Git
   e ricerca in autonomia.
4. **Quando conviene un agente** invece di un Gem: quando il compito è **fare** una
   sequenza di azioni noiose (scaricare, riordinare, impaginare, inviare), non solo
   scrivere un testo.

> Prova subito: in Gmail/Documenti, chiedi a Gemini di riassumere una mail lunga o
> di scrivere una bozza: è il primo passo verso "l'AI che agisce".

## 06 Regole d'oro e privacy (VINCOLANTE)

1. **Mai dati di minori nell'AI.** Nomi, voti, certificazioni, assenze, foto degli
   allievi non si incollano in Gemini/Gem. Se serve far correggere un testo,
   rendilo **anonimo** prima. (Coerente con `REGOLAMENTO-STRUMENTI-DIGITALI-IA.md`.)
2. **Verifica sempre.** L'AI può **inventare** (allucinazioni): date, numeri, nomi
   di funzioni, fonti vanno controllati. Fidati del concetto, verifica i dettagli.
3. **Capire, non delegare il pensiero.** L'AI prepara e velocizza; la decisione e
   la responsabilità restano tue. Vale la prova del nove: saperlo spiegare a parole tue.
4. **Un Gem è riusabile**: scritto bene una volta, lo usi tutto l'anno e lo
   correggi quando serve (come un documento versionato).

## 07 Il tuo piano in tre passi (per imparare davvero)

1. **Oggi (10 minuti):** crea **un** Gem dalle ricette (consiglio: "Segretaria del
   corso") e usalo per una cosa vera (una mail, un avviso).
2. **Questa settimana:** usa quel Gem ogni volta che ti serve; quando qualcosa non
   va, **correggi le istruzioni** e riprova. Così capisci come "si guida" un Gem.
3. **Poi:** crea un **secondo** Gem di tipo diverso (es. "Progettista di esercizi")
   e nota la differenza tra un professionista e l'altro.
4. **Prova del nove (anche per te):** sai spiegare a un collega, in un minuto, la
   differenza tra un Gem e un agente e quando usare l'uno o l'altro? Se sì, l'hai capito.

## 08 Glossario rapido

1. **Gem**: assistente AI personalizzato in Gemini (ruolo + istruzioni + conoscenza).
2. **Prompt di sistema / istruzioni**: il testo che dice al Gem chi è e come lavora.
3. **Persona / ruolo**: il "mestiere" che fai simulare all'AI.
4. **Conoscenza (knowledge)**: i file che dai al Gem perché usi solo quelli.
5. **Strumenti (tools)**: le azioni che un agente può compiere (web, file, email).
6. **Agente**: AI che agisce a cicli usando strumenti, con autonomia.
7. **Allucinazione**: quando l'AI inventa qualcosa che sembra vero ma non lo è.
8. **Contesto**: ciò che l'AI "ha davanti" in quel momento (la chat + i file dati).

## 09 Collegamenti

1. `INTELLIGENZA-ARTIFICIALE.md` — la versione **per i ragazzi** (Gem vs Agente),
   da usare in classe in forma semplice.
2. `REGOLAMENTO-STRUMENTI-DIGITALI-IA.md` — le regole d'uso dell'AI (privacy, uso
   responsabile) che allievi e famiglie firmano.
3. `GUIDA-NOTEBOOKLM-CLASSROOM.md` — NotebookLM come agente di studio per i ragazzi.
4. Metodo del corso: prova subito · fallo tuo · mostralo; l'AI aiuta a capire.

## 10 Changelog

1. **v1.0 (23/09/2026)**: prima versione del corso per il docente su Agenti e GEM
   (tre livelli; le 4 leve del Gem; creare un Gem passo-passo; "simulare un
   professionista"; ricettario di 5 Gem pronti; cenni sugli agenti; regole/privacy;
   piano in tre passi; glossario).
