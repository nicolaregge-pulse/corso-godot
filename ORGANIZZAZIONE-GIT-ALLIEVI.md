# Organizzazione Git per gli Allievi

**Versione 0.4** — 02/09/2026
*Come organizziamo Git per la classe: un unico "progetto comune" (l'organizzazione
della scuola) dentro cui ogni allievo ha il PROPRIO repository privato, che solo
lui puo toccare e che il docente vede tutti. Strumento scelto: GitHub Classroom.
Questo documento fissa la struttura e il senso; la guida click-by-click per
impostarlo la prepariamo insieme quando sei davanti allo schermo.*

---

> [GIALLO] AGGIORNAMENTO (02/09/2026): GitHub Classroom e stato RITIRATO il 28/08/2026. Al suo posto usiamo Classroom 50 (classroom50.org): strumento gratuito e open-source, partner ufficiale di GitHub (Fifty Foundation), che funziona TUTTO da browser (niente installazioni). Non ha un proprio server ne database: crea e conserva tutto DENTRO la nostra organizzazione GitHub (repository, team, permessi). Vantaggio chiave: nessun lock-in — se un giorno lo strumento sparisse, i dati restano in GitHub e il metodo "a mano" descritto in questo documento resta valido come ripiego. La struttura a tre livelli, l'area comune e i tre requisiti qui sotto NON cambiano: Classroom 50 li realizza in automatico. Dove sotto si legge "GitHub Classroom", intendi "Classroom 50".

## 1. A cosa serve e perche (il senso)
1. Ogni allievo ha uno spazio suo, sicuro: nessun altro puo guardarlo o romperlo. E il suo "libro" personale che cresce (quaderno + esercizi + progetti).
2. E come lavorano i team veri: imparano fin da subito un'abitudine spendibile nel mondo del lavoro.
3. Protegge dal confronto e dalla vergogna: nessuno vede gli errori degli altri. Se sbaglio un esercizio, gli altri restano intatti (zero conseguenze, zero vergogna).
4. Il docente resta il regista: vede tutti i repository, puo aiutare e valutare, senza che gli allievi si pestino i piedi tra loro.

> [GIALLO] Perche conta doppio per noi: dare a ognuno uno spazio dignitoso e protetto, dove provarci non fa male, e il cuore del metodo del corso ("Vinci subito, Fallo tuo, Mostralo").

### I tre requisiti vincolanti (chiesti da Nicola)
1. Ogni allievo entra **solo** nel proprio repository: nessun allievo puo vedere o toccare quello di un altro.
2. Il docente puo entrare in **tutti** i repository degli allievi.
3. C'e una **parte comune** (il materiale per tutti) dove gli allievi possono **solo prelevare** (sola lettura): non possono modificarla. Solo il docente ci scrive.

## 2. La struttura (tre livelli + area comune)
1. Livello 1 — l'Organizzazione GitHub della classe: e il "progetto comune", l'ombrello che contiene tutto. La possiede il docente.
2. Livello 2 — un repository privato per ogni allievo, dentro l'organizzazione. Ogni allievo e collaboratore solo del suo: vede e modifica soltanto quello. Il docente, come proprietario, li vede tutti.
3. Livello 3 — il contenuto del repo personale: il quaderno dello studente, la cartella degli esercizi, i progetti. E il libro loro, che cresce a ogni lezione.
4. Area comune — un repository a parte (es. `materiale-comune`) con il materiale per tutti: il docente ci scrive, gli allievi lo vedono in **sola lettura** (prelevano ma non modificano). Realizza il requisito 3.

## 3. Perche GitHub Classroom
1. E lo strumento pensato apposta per la scuola, gratuito, tutto da browser (niente installazioni: coerente col vincolo delle postazioni scolastiche).
2. Si prepara un unico repo modello (con quaderno ed esercizi gia pronti) e Classroom crea in automatico un repository privato per ogni allievo, partendo da quel modello.
3. Cosi si evita di creare i repo a mano uno per uno, e l'isolamento tra allievi e garantito dallo strumento.
4. Il docente ha un cruscotto da cui vede il lavoro di tutti in un colpo d'occhio.

## 4. Il repository modello (template): cosa contiene
1. Una cartella per il quaderno dello studente (dal modello gia in `manuale/quaderno-studente-TEMPLATE.md`), pronta da riempire.
2. Una cartella `esercizi/` con una sottocartella per esercizio, ognuna con la sua scheda a 4 livelli.
3. Un file di benvenuto (README) che spiega, con parole semplici, cosa fare al primo accesso.
4. Man mano che il corso avanza, il modello si arricchisce; i nuovi esercizi diventano nuove sottocartelle.

## 5. Ruoli e permessi: chi vede cosa
1. Docente: proprietario dell'organizzazione. Vede e puo entrare in tutti i repository degli allievi; corregge e valuta.
2. Allievo: collaboratore solo del proprio repository. Non vede quelli dei compagni.
3. Repository: privati. Nessun lavoro e pubblico se non lo decidiamo noi.
4. Materiale comune: repository a parte con gli allievi in **sola lettura** (permesso "Read", assegnato tramite un team "Allievi"). Prelevano (pull) ma non possono modificare (niente push); solo il docente lo aggiorna.

## 6. Come si lega alle due fasi del corso
1. Fase 1 (esercizi separati): ogni allievo lavora nel suo repository e salva con un commit. Se sbaglia un esercizio, gli altri restano intatti. Git semplice, un salvataggio alla volta.
2. Fase 2 (progetto di gruppo): si aggiunge un repository condiviso a parte, dove il gruppo lavora con branch e Pull Request. Qui imparano a integrare il lavoro degli altri, come in un vero team.
3. I due mondi convivono: lo spazio personale resta sempre di ognuno; il progetto di gruppo e uno spazio in piu, comune al gruppo.

## 7. Come si imposta (a grandi linee, una tantum)
*Questi sono i passaggi generali che fa il docente, una sola volta. La guida
precisa click-by-click, con le coordinate esatte a schermo, la facciamo insieme
quando sei davanti al computer.*
1. Creare l'organizzazione della classe su GitHub (l'ombrello comune).
2. Attivare i benefici GitHub Education per la scuola (danno gratis il livello adatto alle classi).
3. Su classroom.github.com creare una "classroom" e collegarla all'organizzazione.
4. Preparare il repository modello (quaderno + esercizi) e impostarlo come template.
5. Creare un "assignment" (compito) da quel modello, con visibilita privata e un repository per ogni allievo.
6. Condividere con la classe il link d'invito: ogni allievo, cliccando, ottiene in automatico il suo repository personale.

> [BLU] Da confermare insieme al momento dell'attivazione: il nome dell'organizzazione, il nome dell'assignment e l'elenco degli allievi (la lista della classe). Sotto trovi dei nomi di esempio, gia pronti da adattare.

## 8. Nomi di esempio (da adattare)
Nome dell'organizzazione della classe (esempio):
```
informatica-piamarta
```

Nome dell'assignment del quaderno personale (esempio):
```
quaderno-e-esercizi
```

Con questi, il repository di un allievo si chiamera in automatico in modo simile a:
```
quaderno-e-esercizi-nomeallievo
```

## 9. Cosa serve prima di partire
1. Un account GitHub per il docente (gia presente).
2. Un account GitHub per ogni allievo (si creano in classe, dal browser, in una lezione dedicata gia prevista tra le guide del corso).
3. L'attivazione di GitHub Education per la scuola (una tantum).

## 10. Privacy e dignita (perche lo facciamo cosi)
1. Repository privati: il lavoro di ognuno e protetto; niente vetrina pubblica degli errori.
2. Nessun confronto forzato: ognuno cresce nel suo spazio, al suo ritmo.
3. Il quaderno personale diventa, a fine anno, un libro loro di cui essere fieri: la prova concreta del "ce l'ho fatto io".

## 11. Punti ancora aperti
1. Nome degli assignment: da decidere insieme.
2. Elenco della classe (roster) da caricare in Classroom 50.
3. Momento dell'anno in cui attivare i repository personali (probabilmente dopo la lezione in cui gli allievi si creano l'account GitHub).
4. Quando passare alla Fase 2 (progetto di gruppo con branch e Pull Request): quando la classe ha preso confidenza con il commit nel proprio repo.

## 12. Stato dell'attivazione (aggiornato 02/09/2026)
1. FATTO: creata l'organizzazione `informatica-piamarta` (proprietario: account personale nicolaregge-pulse; il nome era da decidere, ora e deciso).
2. FATTO: inviata la richiesta di verifica docente su GitHub Education (prova: lettera d'incarico). In attesa di approvazione (di solito qualche giorno).
3. VINCOLO EMERSO: Classroom 50 funziona solo con organizzazioni sul piano **GitHub Team** (a pagamento). Per i **docenti verificati**, pero, l'upgrade a GitHub Team e **gratuito** tramite GitHub Education. Quindi il passaggio Education non e un optional: e la chiave che sblocca Classroom 50.
4. PROSSIMI PASSI, in ordine: (a) attendere l'email di approvazione Education; (b) fare l'upgrade gratuito dell'organizzazione a GitHub Team; (c) su Classroom 50 configurare l'organizzazione e creare le classi/assignment; (d) creare i repository degli allievi quando avranno l'account GitHub.
5. RIPIEGO: se si dovesse partire prima dell'approvazione, il metodo manuale (un repository privato per allievo + un gruppo "Allievi" in sola lettura sul materiale comune) funziona anche sul piano Free, senza Classroom 50.
6. NOTA su Contecavour32: l'email della scuola (`nicola.regge@piamarta.it`) e agganciata a un secondo account GitHub, `Contecavour32`. Per questo l'Education e stata richiesta sull'account principale nicolaregge-pulse usando il documento, non l'email.
