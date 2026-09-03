# Troubleshooting Pratico — Guasti da Creare e Diagnosticare (Classe 3)

**Versione 0.1** — 03/09/2026
*Kit per il docente (prof. Panaccione) per la parte di diagnosi e riparazione
guasti della Classe 3. Due parti: una TEORICA a crocette (riconoscere il guasto
dalla descrizione) e una PRATICA sui PC fisici (il docente crea un guasto
definito, l'allievo lo diagnostica e lo risolve). Si aggancia alle prove di
qualifica regionali (buste hardware/diagnosi). Tutti i guasti proposti sono
sicuri e reversibili: solo cavi e sedi dei componenti, niente che possa
danneggiare. Metodo del corso: si prova senza paura, sbagliare la diagnosi e
normale, ogni passo si annota a mano sul quaderno.*

---

## 1. A cosa serve e come si usa

1. Obiettivo: portare l'allievo a **ragionare come un tecnico** — dal sintomo alla causa alla soluzione — non a imparare a memoria.
2. Due modalita, complementari:
   1. **Teorica a crocette** (capitolo 5): si legge la descrizione di un problema e si sceglie la soluzione giusta tra alcune. Utile in aula, veloce, buona per il ripasso e le buste d'esame.
   2. **Pratica sui PC fisici** (capitolo 4): il docente provoca un guasto reale a PC spento; l'allievo, con la scheda di diagnosi, capisce cosa non va e lo ripara.
3. Ritmo consigliato: prima un guasto **facilissimo** (vittoria subito), poi si sale di difficolta. Ogni allievo, alla fine, deve poter **raccontare** cosa ha trovato e come l'ha risolto (e la prova che ha capito davvero).
4. Carta e penna sempre: la **scheda di diagnosi** (capitolo 3) si compila a mano e finisce nel quaderno personale.

> [GIALLO] Motore del corso: il guasto e messo apposta dal docente. Sbagliare la prima ipotesi non e un errore dell'allievo, e parte del gioco: si prova, si verifica, si riprova. Zero vergogna.

## 2. Sicurezza prima di tutto (VINCOLANTE)

Regole da spiegare e far rispettare **prima** di toccare qualunque PC.

1. Si lavora **sempre a PC spento e scollegato dalla presa di corrente**. Prima di aprire o toccare l'interno: spegnere, staccare la spina, e premere il pulsante di accensione una volta (scarica l'energia residua).
2. **Scarica l'elettricita statica**: prima di toccare i componenti, toccare una parte metallica non verniciata del case. Meglio ancora un braccialetto antistatico. La statica danneggia i componenti in modo invisibile.
3. **Non forzare mai** un componente o un connettore: se non entra, e nel verso sbagliato o nella sede sbagliata. Si inserisce con delicatezza fino allo scatto.
4. **Non aprire mai l'alimentatore** e non toccarne l'interno: contiene tensioni pericolose anche da spento. Sull'alimentatore si toccano solo i cavi e l'interruttore esterno.
5. Non provocare **cortocircuiti**: niente attrezzi metallici lasciati dentro il case, niente viti vaganti sulla scheda madre.
6. Un componente/cavo alla volta: si crea **un solo guasto per prova**, cosi la diagnosi resta pulita.
7. A fine attivita: si rimonta tutto correttamente, si verifica che il PC riparta, e si lascia la postazione in ordine (si lega alle Regole del Laboratorio).

> [ROSSO] Vietato: aprire l'alimentatore; lavorare a PC acceso o con la spina attaccata; forzare i componenti; toccare la scheda video/RAM sui contatti dorati. Questi non sono guasti da esercizio: sono rischi per le persone o per l'hardware.

## 3. Il metodo di diagnosi (la scheda dell'allievo)

La scheda che l'allievo compila a mano per ogni guasto. Insegna il **metodo**, sempre lo stesso.

1. **Osserva i sintomi** all'accensione, senza aprire niente:
   1. Le ventole girano? Ci sono spie accese?
   2. Si sentono segnali acustici (beep)?
   3. C'e immagine sullo schermo? Compaiono scritte o messaggi d'errore?
2. **Formula un'ipotesi**: dove sara il problema? (alimentazione, memoria, video, disco, avvio...). Scrivi l'ipotesi PRIMA di aprire.
3. **Verifica una cosa alla volta**, partendo dalla piu semplice ed esterna (spine, interruttori, cavi del monitor) e poi dentro (sedi dei componenti, connettori sulla scheda madre).
4. **Applica la soluzione** (ricollega, reinserisci a fondo, ecc.).
5. **Prova**: il PC si accende? Parte il sistema operativo?
6. **Scrivi l'esito**: qual era il guasto, come l'hai capito, come l'hai risolto. Questa riga e la piu importante.

> [BLU] Schema del sintomo (utile da disegnare a mano):
> non si accende nulla -> alimentazione; si accende ma niente video -> RAM / video / alimentazione CPU; parte ma "manca il disco" -> disco o avvio; immagine assente -> monitor o cavo video.

## 4. Catalogo dei guasti fisici (per il docente)

Per ogni guasto: cosa fare (a PC spento e scollegato), il sintomo atteso, la causa (la diagnosi corretta) e la soluzione. Difficolta: F = facile, M = media, D = difficile.

### 4.1 Alimentazione

| Guasto da creare | Sintomo atteso | Causa (diagnosi) | Soluzione | Diff. |
|---|---|---|---|---|
| Mettere l'interruttore dell'alimentatore su "O" (dietro il case) | PC completamente morto: nessuna ventola, nessuna spia | Alimentatore spento dall'interruttore | Rimettere l'interruttore su "I" | F |
| Staccare il cavo di corrente dalla presa (o dall'alimentatore) | PC completamente morto | Manca l'alimentazione dalla rete | Ricollegare il cavo | F |
| Allentare il connettore 24 pin (ATX) sulla scheda madre | Non si accende, o parte e si spegne subito | La scheda madre non riceve alimentazione stabile | Reinserire il 24 pin fino allo scatto | M |
| Staccare il connettore alimentazione CPU (EPS 4/8 pin, in alto vicino alla CPU) | Le ventole girano ma nessun video, nessun avvio | La CPU non e alimentata | Ricollegare il connettore CPU | D |

### 4.2 Memoria RAM

| Guasto da creare | Sintomo atteso | Causa (diagnosi) | Soluzione | Diff. |
|---|---|---|---|---|
| Inserire un modulo RAM non a fondo (levette non scattate) | Non parte il video; spesso beep o spie di errore | Contatto della RAM assente/parziale | Reinserire la RAM premendo fino allo scatto delle levette | M |
| Togliere tutta la RAM | Non si accende il video; segnali acustici ripetuti | Manca la memoria | Rimettere i moduli nelle sedi corrette | F/M |
| Spostare l'unico modulo in uno slot diverso (o due moduli negli slot sbagliati) | Funziona ma non in "dual channel" (o non riconosce tutta la RAM) | Sedi non ottimali per il doppio canale | Rimettere nelle sedi indicate dal manuale della scheda madre | D |

### 4.3 Video e scheda grafica

| Guasto da creare | Sintomo atteso | Causa (diagnosi) | Soluzione | Diff. |
|---|---|---|---|---|
| Staccare il cavo del monitor dalla scheda video | Schermo "No signal" | Manca il segnale video | Ricollegare il cavo del monitor | F |
| Collegare il monitor all'uscita della scheda madre invece che alla scheda video dedicata | Nessuna immagine (o immagine solo a volte) | Uscita video sbagliata | Spostare il cavo sull'uscita della scheda video | M |
| Inserire la scheda video non a fondo nello slot PCIe | Nessun segnale video; a volte spie/beep | Contatto PCIe assente | Reinserire la scheda fino allo scatto del fermo | M |
| Lasciare il monitor spento o su ingresso (HDMI/VGA) sbagliato | Schermo nero/"No signal" pur con PC acceso | Il problema e nel monitor, non nel PC | Accendere il monitor / scegliere l'ingresso giusto | F |

### 4.4 Dischi e avvio

| Guasto da creare | Sintomo atteso | Causa (diagnosi) | Soluzione | Diff. |
|---|---|---|---|---|
| Staccare il cavo dati SATA del disco | All'avvio: "No bootable device / inserire un disco di avvio" | Il disco non e collegato ai dati | Ricollegare il cavo SATA dati | M |
| Staccare il cavo di alimentazione del disco | Il disco non viene rilevato | Il disco non e alimentato | Ricollegare l'alimentazione del disco | M |
| Cambiare nel BIOS l'ordine di avvio (prima una USB vuota) | Il PC non trova il sistema operativo | Ordine di avvio sbagliato | Rimettere il disco come primo nell'ordine di avvio | M |

### 4.5 Pannello frontale, raffreddamento, rete

| Guasto da creare | Sintomo atteso | Causa (diagnosi) | Soluzione | Diff. |
|---|---|---|---|---|
| Staccare il cavetto del pulsante di accensione (Power SW) dal pannello frontale | Premendo il tasto non succede nulla (ma il PC e "vivo") | Il pulsante non e collegato alla scheda madre | Ricollegare il cavetto Power SW ai pin giusti | D |
| Scollegare la ventola della CPU dal connettore CPU_FAN | Si accende e poi si spegne, o avviso "CPU fan error" | La scheda protegge la CPU dal surriscaldamento | Ricollegare la ventola al connettore CPU_FAN | M |
| Staccare il cavo di rete (ethernet) | Nessuna connessione a internet | Cavo di rete scollegato | Ricollegare il cavo di rete | F |

## 5. La parte teorica a crocette (banca domande)

Ogni domanda: una descrizione del problema e alcune risposte; una sola giusta. La risposta corretta e indicata tra parentesi quadre per il docente (va tolta nella versione per gli allievi).

1. Premo il pulsante di accensione e non succede assolutamente nulla: nessuna ventola, nessuna spia. Da cosa conviene partire?
   1. Reinstallare il sistema operativo.
   2. Controllare la spina, l'interruttore dell'alimentatore e i cavi di corrente.
   3. Cambiare la scheda video.
   4. Sostituire il disco. [Risposta: 2]
2. Il PC si accende (le ventole girano) ma lo schermo resta nero e non parte niente. Quale ipotesi e piu probabile?
   1. Il cavo di rete e staccato.
   2. Il disco e pieno.
   3. RAM mal inserita, oppure alimentazione della CPU o scheda video. 
   4. Il monitor e troppo vecchio. [Risposta: 3]
3. All'avvio compare il messaggio "No bootable device". Cosa controllo per primo?
   1. La ventola della CPU.
   2. I cavi (dati e alimentazione) del disco e l'ordine di avvio nel BIOS.
   3. La scheda audio.
   4. La tastiera. [Risposta: 2]
4. Lo schermo dice "No signal" ma il PC sembra acceso. Prima mossa?
   1. Aprire il case e togliere la RAM.
   2. Controllare che il monitor sia acceso, sull'ingresso giusto, e il cavo collegato all'uscita video giusta.
   3. Formattare il disco.
   4. Cambiare l'alimentatore. [Risposta: 2]
5. Sento dei beep ripetuti all'accensione e non c'e immagine. A cosa fanno pensare tipicamente?
   1. A un problema di RAM (o video).
   2. A internet lento.
   3. A un file mancante nel sistema operativo.
   4. Al mouse scollegato. [Risposta: 1]
6. Il PC si accende e dopo pochi secondi si spegne da solo, oppure segnala "CPU fan error". Causa piu probabile?
   1. Il disco e scollegato.
   2. La ventola della CPU non gira / non e collegata (protezione dal surriscaldamento).
   3. La scheda di rete e rotta.
   4. Manca il cavo del monitor. [Risposta: 2]
7. Metodo generale: qual e l'ordine giusto per diagnosticare?
   1. Cambiare pezzi a caso finche funziona.
   2. Osservare i sintomi, fare un'ipotesi, verificare una cosa alla volta dalla piu semplice, poi risolvere.
   3. Reinstallare subito il sistema operativo.
   4. Chiamare l'assistenza senza guardare. [Risposta: 2]
8. Prima di aprire un PC per ripararlo, cosa faccio SEMPRE?
   1. Lo lascio acceso per fare prima.
   2. Lo spengo, stacco la spina e scarico la statica toccando il metallo del case.
   3. Apro l'alimentatore per controllarlo.
   4. Bagno le mani per pulirle. [Risposta: 2]

## 6. Come valutare (griglia semplice)

1. **Sicurezza**: ha lavorato a PC spento e scollegato, senza forzare? (si/no, prima di tutto).
2. **Metodo**: ha osservato i sintomi e fatto un'ipotesi prima di aprire?
3. **Diagnosi**: ha individuato la causa giusta (anche dopo qualche tentativo)?
4. **Soluzione**: ha riparato e il PC riparte?
5. **Racconto**: sa spiegare a parole sue cosa era successo e come l'ha risolto? (la prova del nove).

> [GIALLO] Non conta "indovinare subito": conta il metodo e il saper raccontare. Un allievo che sbaglia due ipotesi ma ragiona bene e le verifica, ha capito piu di uno che azzecca a caso.

## 7. Collegamenti

1. **Prove di qualifica regionali**: le buste su hardware, sistema operativo e diagnosi (3a/4a) verificano proprio queste competenze. Questo kit e allenamento diretto.
2. **Sicurezza sul lavoro**: il capitolo 2 si lega al modulo trasversale di sicurezza (lavorare in modo sicuro, DPI, rischi elettrici).
3. **Metodo del corso**: vittoria subito (primo guasto facilissimo), si prova senza paura, si mostra e si racconta, carta e penna a ogni prova.
4. **HTML5/CSS**: la parte teorica a crocette puo diventare una pagina web che si autocorregge (aggancio col corso HTML/CSS di Panaccione).
