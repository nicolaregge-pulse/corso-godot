# 01 Glossario

Versione 1.0 — 16/08/2026

Termini e sigle del corso, spiegati in parole semplici. Alla prima volta che un
documento usa una sigla, la scrive per esteso; qui trovi la spiegazione completa.

## 1. Godot e la programmazione

| Termine | Spiegazione |
|---|---|
| Godot | Il motore di gioco (game engine) che usiamo per costruire i giochi. È portabile: un solo file, senza installazione. |
| GDScript | Il linguaggio di programmazione di Godot. Assomiglia molto a Python: si va a capo e si indenta, senza punto e virgola. |
| Nodo (Node) | Il mattoncino base di Godot. Ne esistono di tanti tipi. Come un pezzo di LEGO. |
| Scena (Scene) | Un albero di nodi salvato in un file con estensione tscn. Un livello, un menu, un personaggio. Come una costruzione di LEGO. |
| Script | Il codice GDScript attaccato a un nodo, che gli dà un comportamento. |
| Segnale (Signal) | Un annuncio che un nodo manda quando succede qualcosa, per esempio il click di un bottone. |
| Game loop | Il battito continuo del gioco: la funzione `_process(delta)` gira da sola circa 60 volte al secondo. |
| Proprietà | Una caratteristica di un nodo, per esempio il testo di una Label o il colore di un rettangolo. |
| Ispettore | Il pannello di Godot dove si cambiano le proprietà del nodo selezionato. |
| Esportazione (export) | Creare la versione del gioco che gira nel browser (la versione web). |

## 2. Tipi di nodo più usati

| Termine | Spiegazione |
|---|---|
| Node2D | Un contenitore per il 2D: dentro ci si mettono gli altri nodi del gioco. |
| Sprite2D | Un nodo che mostra un'immagine. |
| Label | Un nodo che mostra del testo. |
| Button | Un bottone da premere. |
| LineEdit | Una casella dove scrivere del testo. |
| ColorRect | Un rettangolo colorato. |
| AudioStreamPlayer | Il nodo che suona un effetto sonoro. |

## 3. Il ponte da Lazarus

| Termine | Spiegazione |
|---|---|
| Lazarus | L'ambiente che i ragazzi già conoscono, con Free Pascal. Da lì partiamo per spiegare Godot. |
| Form | In Lazarus la finestra del programma. In Godot diventa la Scena. |
| Componente | In Lazarus il pezzo pronto, per esempio TButton o TEdit. In Godot diventa il Nodo. |
| Caption | In Lazarus il testo mostrato da un componente. In Godot è la proprietà del testo, per esempio il text di una Label. |
| Gestore evento | In Lazarus la procedura del click, per esempio Button1Click. In Godot è un segnale collegato a una funzione. |

## 4. Git, GitHub e la pubblicazione

| Termine | Spiegazione |
|---|---|
| Git | Il sistema di versionamento: tiene la storia di tutte le modifiche. |
| GitHub | Il sito dove teniamo online il corso e i giochi. |
| Repository (repo) | La cartella del progetto tenuta su Git e GitHub. |
| Commit | Un salvataggio, con un messaggio che dice cosa è cambiato. |
| Branch (ramo) | Una linea di lavoro separata, per non disturbare il lavoro degli altri. |
| PR (Pull Request: richiesta di unione) | La proposta di unire un ramo nel lavoro principale. |
| Merge | L'unione di due lavori. |
| Fork | La propria copia personale di un repository. |
| Release | Una versione congelata e pubblicata, stabile per i ragazzi, per esempio v1.0. |
| GitHub Pages | Il servizio di GitHub che pubblica i giochi sul web, dalla cartella docs. |

## 5. La classifica online dei giochi

| Termine | Spiegazione |
|---|---|
| Firebase Realtime Database | Il database online, sui server di Google, dove finiscono i punteggi della classifica condivisa. |
| REST (REpresentational State Transfer) | Il modo con cui i giochi, dal browser, leggono e scrivono i punteggi nel database via internet. |
| Cache | La memoria del browser che a volte tiene la versione vecchia di una pagina. Per questo i link dei giochi sono fatti per aggiornarsi da soli. |

## 6. I documenti del corso

| Termine | Spiegazione |
|---|---|
| Markdown (MD) | Il modo semplice di scrivere i documenti, con pochi segni. È il sorgente da cui si genera il PDF. |
| PDF (Portable Document Format: formato del documento portabile) | Il formato del documento stampabile, generato dall'MD. |
| Fase 1 | La prima parte del corso: esercizi separati, con un commit per salvare. |
| Fase 2 | La seconda parte: un progetto di gruppo che cresce, con branch, Pull Request e release. |

## Changelog

| Versione | Data | Cosa è cambiato |
|---|---|---|
| 1.0 | 16/08/2026 | Prima stesura del glossario del corso. |
