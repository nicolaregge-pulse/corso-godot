# Regole di Formattazione dei Documenti

**Versione 1.3** — 16/08/2026
*Standard unico di formattazione. Vale per TUTTI i documenti del corso, presenti e
futuri. Adattato al corso: la fonte di verita e decisa da Nicola (nessun ruolo di
soggetti esterni).*

---

## 1. Formati e consegna
1. Ogni documento esiste sempre in due forme: MD (sorgente) e PDF (generato).
2. Consegna doppia: un PDF combinato (la "super-guida", stampa unica) e uno zip con i singoli numerati.
3. Il combinato si genera con un solo comando; ogni nuovo documento entra automaticamente (auto-append), oltre a quelli elencati nel MANIFEST (elenco ordinato dei documenti).

## 2. Titoli
1. Numero d'ordine nel titolo e nel nome del file (00, 01, 02, 02b, ...).
2. Nella numerazione niente trattino: "02 Panoramica", non "02 - Panoramica".
3. Titoli mai orfani: un titolo sta sulla stessa pagina dell'inizio del suo contenuto o della sua tabella, mai in fondo con il contenuto nella pagina dopo.

## 3. Indice e navigazione
1. INDICE: la guida di lettura (elenco dei documenti con una riga di descrizione).
2. La super-guida ha due indici:
   1. un Sommario stampato in testa (documento, poi numero di pagina);
   2. i segnalibri PDF cliccabili nella barra laterale.
3. Entrambi si rigenerano da soli a ogni build.

## 4. Liste
1. Liste solo numerate e gerarchiche (1, 1.1, 1.1.2). Niente elenchi puntati.

## 5. Caratteri e simboli decorativi
1. Font unico: DejaVu. La numerazione delle sezioni e automatica.
2. Pochi o nessun simbolo decorativo (emoji) nei documenti. Il generatore li converte in testo (per esempio [CRITICO], [OK], [ATTENZIONE]) o li rimuove: usarli come decorazione sporca il PDF.
3. Per evidenziare si usano i box colorati semantici della legenda (punto 8), non i simboli decorativi.

## 6. Sigle e acronimi
1. Ogni sigla con la forma esplicita tra parentesi alla prima occorrenza: "VPS (Virtual Private Server: server privato virtuale)".
2. I termini ricorrenti stanno nel GLOSSARIO (documento 01).

## 7. Punteggiatura
1. Numerazione senza trattino (vedi 2.2).
2. Termine piu spiegazione: due punti ("Git: sistema di versionamento").
3. Inciso a meta frase: virgole se leggero; parentesi se accessorio; trattino lungo solo per uno stacco forte voluto.
4. Notazione numerica italiana (virgola decimale, punto per le migliaia); date DD/MM/YYYY nel testo, YYYY-MM-DD nei dati e nel database.

## 8. Box colorati (legenda canonica)
1. Rosso, DISALLINEAMENTO: qualcosa che stride con la realta o con la fonte di verita (errore noto da correggere).
2. Blu, DA CONFERMARE o IN ATTESA: direzione verso cui si converge ma non ancora ufficiale (di norma una decisione di Nicola non ancora confermata); quando arriva la conferma, sparisce.
3. Giallo, NOTA: semplice nota esplicativa, non segnala problemi.

Esempi (come appaiono nel PDF):

> [ROSSO] Questo documento dice X, ma il documento 00 dice Y: va corretto.

> [BLU] Direzione probabile in attesa di conferma di Nicola.

> [GIALLO] Promemoria utile, senza alcun problema da risolvere.

Nel sorgente si scrivono come una citazione che inizia con l'etichetta tra
parentesi quadre: `> [ROSSO] ...`, `> [BLU] ...`, `> [GIALLO] ...`.

## 9. Versioning
1. Una versione stampata e congelata: da li non si tocca piu.
2. Correzioni e aggiunte vanno nella versione successiva, registrate nel CHANGELOG_Vn; ogni versione stampata ha un ERRATA_Vn in coda al combinato.
3. Ogni documento porta la sua versione (un documento nuovo parte da v1.0); la super-guida ha la versione della raccolta.

## 10. Fonte di verita
1. Il documento 00 (la fonte di verita del corso, decisa da Nicola) e la stella polare: se un documento lo contraddice, vince il documento 00 (e si apre un box rosso).
2. I documenti gia decisi non si riscrivono: si recepiscono.

## 11. Regola per la comunicazione all'utente (chat e guide)
1. REGOLA 0 (assoluta): tutto cio che l'utente deve copiare (comandi, URL, email, valori) va in un blocco di codice (col bottone "copia"), mai in linea ne in citazione.

---

## Note di adozione (specifiche del corso)
1. Questo standard e vincolante per ogni nuovo documento del corso.
2. I documenti gia esistenti si migrano allo standard in modo graduale (vedi il piano di migrazione concordato), non tutti in una volta, per non introdurre errori.
3. Le parti che nello standard originale citavano soggetti esterni sono adattate: per questo progetto la fonte di verita e Nicola.
