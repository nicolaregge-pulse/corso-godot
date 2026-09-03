# Corso Base di HTML5 e CSS (Classe 3)

**Versione 0.1** — 03/09/2026
*Corso base, tutto pratico, per iniziare a costruire pagine web da zero (prof.
Panaccione, Classe 3). E la base che porta al "sito professionale". Ogni passo
da un risultato visibile subito: si scrive un pezzetto, si guarda nel browser,
si personalizza. Alla fine la pagina si pubblica online con GitHub Pages (leva
"Mostralo"). Strumenti a costo zero e senza installazioni. Carta e penna: gli
schemi della struttura della pagina si disegnano prima a mano.*

---

## 1. A cosa serve e come si usa

1. Obiettivo: costruire **pagine web vere**, capendo la differenza tra la **struttura** (HTML: i mattoni) e l'**aspetto** (CSS: colori e stile).
2. Regola d'oro del ritmo: **scrivi poco, guarda subito**. Ogni piccolo blocco di codice si prova nel browser prima di andare avanti. Il risultato a schermo e la ricompensa.
3. Ognuno **personalizza** la sua pagina (nome, colori, foto, argomento preferito): la pagina e sua, non un esercizio uguale per tutti.
4. Alla fine ogni allievo ha una **pagina online**, con un indirizzo web da mostrare. E la prova concreta del "ce l'ho fatto io".

> [GIALLO] Metodo del corso: prima la vittoria facile (una pagina che dice "Ciao"), poi si aggiunge un pezzo alla volta. Un errore nel codice non rompe niente: si corregge e si riprova. Zero vergogna.

## 2. Cosa serve (senza installare niente)

1. **Per scrivere il codice**: va bene il **Blocco note** (gia presente su ogni PC). Meglio ancora l'editor nel browser di GitHub (`github.dev`, si apre premendo il tasto punto dentro un repository): scrivi e salvi li, senza installare.
2. **Per vedere il risultato**: si salva il file con estensione `.html` e si fa **doppio clic**: si apre nel browser. Ogni volta che si cambia il codice, si salva e si ricarica la pagina (tasto F5).
3. **Per pubblicare online**: **GitHub Pages** (capitolo 7), gratis, dal repository. Cosi la pagina va su internet a un vero indirizzo.

> [BLU] A scuola non serve installare programmi: Blocco note + browser bastano per tutto il corso base. GitHub (repository e Pages) e lo stesso strumento che usiamo per il resto del corso.

## 3. La prima vittoria: una pagina in 10 minuti

1. Aprire il Blocco note, scrivere questo, e salvarlo con nome `index.html` (attenzione: non `index.html.txt`).

```html
<!doctype html>
<html lang="it">
  <head>
    <meta charset="utf-8">
    <title>La mia pagina</title>
  </head>
  <body>
    <h1>Ciao, sono Marco!</h1>
    <p>Questa e la mia prima pagina web.</p>
  </body>
</html>
```

2. Fare doppio clic su `index.html`: si apre nel browser e si legge il titolo grande e la frase. **Prima vittoria fatta.**
3. Personalizzare: cambiare il nome e la frase. Salvare, ricaricare (F5). E gia "sua".

## 4. HTML5 — la struttura (i mattoni)

1. Ogni pagina ha uno scheletro fisso: `<!doctype html>`, poi `<html>` che contiene `<head>` (informazioni, non si vede) e `<body>` (cio che si vede).
2. I "mattoni" piu usati dentro il `body`:
   1. Titoli: da `<h1>` (il piu grande) a `<h6>` (il piu piccolo).
   2. Paragrafo di testo: `<p>...</p>`.
   3. Immagine: `<img src="foto.jpg" alt="descrizione">`.
   4. Collegamento (link): `<a href="https://...">testo del link</a>`.
   5. Elenco: `<ul><li>voce</li><li>voce</li></ul>`.
3. Sezioni per organizzare la pagina (HTML5): `<header>` (intestazione), `<main>` (contenuto principale), `<footer>` (piede pagina).
4. Esempio da provare (aggiungerlo dentro il `body`):

```html
<header>
  <h1>Il mio gioco preferito</h1>
</header>
<main>
  <p>Si chiama <a href="https://esempio.it">Nome del gioco</a>.</p>
  <img src="gioco.jpg" alt="immagine del gioco">
  <ul>
    <li>Perche mi piace</li>
    <li>Come si gioca</li>
  </ul>
</main>
<footer>
  <p>Pagina fatta da Marco.</p>
</footer>
```

> [GIALLO] Regola pratica: l'HTML dice COSA c'e (un titolo, un paragrafo, un'immagine). Non si occupa dei colori: quelli sono compito del CSS (capitolo 5).

## 5. CSS — l'aspetto (colori, caratteri, spazi)

1. Il CSS decide **come si vede** la pagina. Per iniziare, si scrive dentro il `<head>`, in un blocco `<style>`.
2. Si sceglie un elemento (selettore) e gli si danno delle proprieta. Esempio da mettere nel `<head>`:

```html
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
    color: #222222;
  }
  h1 {
    color: #1f6feb;
    text-align: center;
  }
  p {
    font-size: 18px;
  }
</style>
```

3. Le proprieta di base piu utili:
   1. `color`: colore del testo.
   2. `background-color`: colore dello sfondo.
   3. `font-family`: il carattere.
   4. `font-size`: la grandezza del testo.
   5. `text-align`: allineamento (`left`, `center`, `right`).
   6. `padding` e `margin`: lo spazio dentro e fuori da un elemento.
4. Dare uno stile solo ad alcuni elementi con le **classi**: nell'HTML si scrive `<p class="importante">...`, nel CSS `.importante { color: red; }`.

> [BLU] Passo avanti (facoltativo): quando la pagina cresce, il CSS si sposta in un file a parte `stile.css` e si collega nel `<head>` con `<link rel="stylesheet" href="stile.css">`. Stesso risultato, piu ordine.

## 6. Una pagina che si vede bene anche sul telefono

1. Aggiungere nel `<head>` questa riga: dice al telefono di adattare la pagina allo schermo.

```html
<meta name="viewport" content="width=device-width, initial-scale=1">
```

2. Far si che le immagini non escano dallo schermo: nel CSS

```html
<style>
  img { max-width: 100%; height: auto; }
</style>
```

3. Provare la pagina restringendo la finestra del browser: il testo e le immagini si adattano. Questa e la base del "responsive".

## 7. Pubblicare online con GitHub Pages (Mostralo)

1. Si mette il file `index.html` in un **repository** su GitHub (lo stesso strumento del corso).
2. Nelle impostazioni del repository si attiva **Pages** (si sceglie il ramo e la cartella da pubblicare). Dopo qualche minuto la pagina e online a un indirizzo tipo `https://nome-utente.github.io/nome-repo`.
3. Da quel momento ogni salvataggio (commit) aggiorna la pagina online: si mostra al compagno, sul telefono, a casa.

> [GIALLO] Nota pratica sulla pubblicazione: per pubblicare da un repository privato serve il piano GitHub Team (che l'organizzazione della scuola avra con la verifica docente); in alternativa si usa un repository pubblico dedicato alle pagine web (contiene solo l'HTML, nessun dato personale). La guida click-by-click per attivare Pages si fa insieme, davanti allo schermo.

## 8. Idee di progetto (Fallo tuo)

1. **La mia pagina**: chi sono, cosa mi piace, una foto, qualche link.
2. **Pagina su una passione** (un gioco, uno sport, una band): titolo, testo, immagini, elenco.
3. **Mini-sito a 3 pagine** con un menu di link tra loro (home, argomento, contatti): primo passo verso il sito professionale.
4. **Quiz troubleshooting**: una pagina che presenta le domande a crocette e mostra se la risposta e giusta (aggancio col kit di troubleshooting).

## 9. Collegamenti

1. **Verso il sito professionale**: questo corso base e la rampa di lancio per il sito professionale della Classe 3.
2. **Negozio online (Classe 1)**: li HTML, CSS e JavaScript sono gia usati; e una base pronta da cui prendere esempi.
3. **Git e GitHub**: il web si sposa con il versionamento (salvo, pubblico, aggiorno) e con la leva "Mostralo".
4. **Metodo del corso**: vittoria subito, personalizzazione, risultato mostrabile, carta e penna per lo schema della pagina.
