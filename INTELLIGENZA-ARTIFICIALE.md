# Intelligenza Artificiale — Gem e Agenti Autonomi

**Versione 0.1** — 09/09/2026
*La "scatola" dell'Intelligenza Artificiale (AI): parte con due concetti moderni
e affascinanti — il Gem (un assistente personalizzato) e l'Agente AI (un sistema
autonomo). L'AI oggi non serve solo a "chiacchierare": aiuta a studiare meglio,
a organizzare il tempo e, con gli agenti, a compiere azioni al posto nostro.
Documento trasversale (utile in piu anni), scritto per lo strumento che usiamo a
scuola, Gemini (gratuito). Metodo del corso: l'AI aiuta a CAPIRE, non a saltare
il pensiero; ogni schema si disegna prima a mano sul quaderno.*

---

## 1. A cosa serve e come si usa

1. Obiettivo: capire la differenza tra due modi di usare l'AI — uno che **risponde** (il Gem) e uno che **agisce** (l'Agente) — e quando conviene l'uno o l'altro.
2. Lo strumento che usiamo a scuola e **Gemini** (gratuito). In Gemini gli assistenti personalizzati si chiamano proprio **"Gems"**.
3. Filo del metodo: prima si prova con un esempio concreto e "figo" (crei il tuo assistente), poi lo si personalizza e lo si mostra. L'errore non fa danno: si corregge il testo delle istruzioni e si riprova.

> [GIALLO] Regola d'oro sull'uso dell'AI (vale sempre): l'AI serve a CAPIRE meglio, non a copiare o a saltare il ragionamento. La prova del nove resta sempre la stessa: se sai **raccontare a parole tue** cosa hai fatto e perche, allora hai capito davvero.

## 2. Cos'e un Gem (assistente personalizzato)

1. Un **Gem** (termine usato da Google/Gemini; in altri assistenti si chiama "GPT personalizzato") e come un **attore a cui hai dato un copione preciso**: un'AI a cui hai spiegato **chi deve essere** e **come deve comportarsi**.
2. Esempio: prendi un normale assistente e gli dici *"Da oggi sei il mio insegnante di storia antica. Parlami come se fossimo nell'Antica Roma e alla fine di ogni spiegazione fammi un quiz."* Hai appena creato un Gem.
3. Caratteristiche principali:
   1. **Ruolo definito**: risponde sempre stando nel personaggio o nelle regole che gli hai dato.
   2. **Conoscenza mirata**: puoi caricare dei documenti (i tuoi appunti, un libro in PDF) e fargli usare **solo** quelle informazioni.
   3. **Interazione passiva**: risponde solo quando tu gli scrivi qualcosa (un "prompt", cioe un comando testuale). Da solo non fa nulla finche non glielo chiedi.

## 3. Cos'e un Agente AI (sistema autonomo)

1. Se il Gem e un attore con un copione, l'**Agente AI** e un **robottino virtuale con mani e strumenti**, capace di **prendere decisioni**. Non si limita a scriverti un testo: compie **azioni** per raggiungere l'obiettivo che gli hai dato.
2. Esempio: dici *"Organizzami una ricerca su Marte, crea una presentazione con i punti chiave e mandamela via email."* Un normale Gem ti scriverebbe solo il testo. Un Agente AI, invece, naviga su internet, estrae i dati, apre un programma per le slide, crea il file e te lo **spedisce davvero** via email.
3. I "superpoteri" di un Agente AI:
   1. **Il cervello**: usa l'AI (come Gemini) per ragionare, pianificare i passaggi e capire gli errori.
   2. **Gli strumenti (tools)**: puo usare programmi veri — cercare su internet, usare la calcolatrice, scrivere codice, leggere il calendario, inviare messaggi.
   3. **Autonomia**: capisce da solo quali passaggi fare. Se una ricerca non da risultati, se ne accorge e riprova con parole diverse, senza che tu glielo dica.

## 4. Il confronto: Gem contro Agente AI

| Caratteristica | Gem (assistente personalizzato) | Agente AI (sistema autonomo) |
|---|---|---|
| Cosa fa principalmente | Genera testo, spiega concetti, riassume documenti seguendo istruzioni fisse | Pianifica azioni, usa strumenti digitali e completa compiti lunghi |
| Come lavora | In un solo passaggio: tu chiedi, lui risponde | A cicli: pianifica, usa uno strumento, verifica, procede |
| Rapporto col mondo esterno | Chiuso nella chat: sa solo cio che tu gli dici o carichi | Connesso al mondo: naviga sul web, usa app, modifica file |
| Esempio per lo studio | "Interrogami sui dinosauri con domande a risposta multipla" | "Cerca le 5 notizie scientifiche di oggi, traducile e mettile in un documento" |

### Lo stesso concetto, nomi diversi (nei vari assistenti)

Ogni azienda usa un nome diverso per la stessa idea. Utile saperlo per non confondersi.

| Idea | Google / Gemini | OpenAI / ChatGPT | Anthropic / Claude |
|---|---|---|---|
| Assistente personalizzato | Gems | GPT personalizzati (GPTs) | Projects |
| Agente autonomo | funzioni e agenti in Gemini/Workspace | agenti / Assistants | Claude Code, Agent SDK |

> [GIALLO] Curiosita concreta: l'agente che ha aiutato a preparare i documenti di questo corso e proprio un Agente AI, si chiama Claude Code, e usa strumenti (file, Git, ricerca sul web) in autonomia. A scuola noi useremo Gemini (gratuito) e i suoi Gems.

## 5. Come si costruiscono (uno sguardo dietro le quinte)

1. Bella notizia: oggi **non serve essere super-programmatori** per creare questi sistemi.
2. **Per creare un Gem**: si scrive un **"prompt di sistema"**, cioe una descrizione molto chiara di come deve comportarsi. Esempio da copiare e adattare:

```
Sei un tutor simpatico. Spiega la matematica usando esempi legati ai videogiochi.
Non dare mai la soluzione finale: guida lo studente a capirla, un passo alla volta.
```

3. **Per creare un Agente AI**: si usano dei software (chiamati **framework** o piattaforme **no-code**) dove, come incastrando mattoncini, si collega l'"intelligenza" (il modello) con gli "strumenti" (il permesso di cercare sul web, leggere le email, ecc.). L'agente capisce da solo quale strumento usare in base a cio che gli chiedi.

## 6. Quando usare l'uno o l'altro (conclusione)

1. Serve un **compagno di studio**, un correttore di testi o un personaggio con cui allenarti a parlare in un'altra lingua: il **Gem** e perfetto, facile e veloce da creare.
2. Serve un assistente che faccia il lavoro "noioso" (copiare e incollare dati, scaricare file, organizzare appuntamenti, ricerche lunghe): allora e il momento dell'**Agente AI**.

> [GIALLO] L'idea da portare a casa: il futuro non e solo "parlare" con i computer, ma **collaborare** con loro. Il Gem risponde; l'Agente agisce. Sapere che esistono tutti e due, e capirne la differenza, e gia una competenza.

## 7. Attivita pratiche (crea il tuo assistente)

1. **Vinci subito**: in Gemini, crea un Gem tutor con un prompt di sistema di due righe (vedi capitolo 5) e provalo con una domanda.
2. **Fallo tuo**: personalizza il personaggio (un tutor di storia, un allenatore di inglese, un aiuto per i compiti) e le regole (per esempio "fai sempre un quiz alla fine").
3. **Mostralo**: fai provare il tuo Gem a un compagno e raccontagli come l'hai istruito.
4. **Carta e penna**: prima di costruirlo, disegna a mano uno schemino con due colonne — cosa fa un Gem, cosa fa un Agente — e un esempio per ciascuno.
5. Attivita di ragionamento (sul quaderno): per tre compiti a scelta ("ripassa i verbi", "prenota un campo da calcio", "riassumi un capitolo"), scrivi se conviene un Gem o un Agente e perche.

## 8. Uso responsabile dell'AI

1. **Capire, non copiare**: l'AI e un aiuto per imparare, non un modo per saltare il lavoro. Vale la prova del nove: saperlo spiegare a parole proprie.
2. **Controllare sempre**: l'AI puo sbagliare o inventare (allucinazioni). Quello che dice va verificato, soprattutto date, numeri e fonti.
3. **Privacy e dati**: non inserire dati personali, di compagni o di famiglia negli assistenti. Si lega alla cittadinanza digitale.

## 9. Collegamenti

1. **Area Intelligenza artificiale**: e la base pratica per usare l'AI durante tutto il corso (in tutti gli anni), con lo strumento gratuito Gemini.
2. **Mondo del lavoro / automazione**: gli agenti si legano all'idea di automatizzare compiti (Industria 4.0) e alle figure professionali dell'informatica.
3. **Condizioni (se... allora...)**: un agente ragiona per passi e decisioni; e lo stesso "se... allora..." visto nel documento delle condizioni.
4. **Metodo del corso**: prova subito, personalizza, mostra; l'AI aiuta a capire; ogni schema prima a mano.
