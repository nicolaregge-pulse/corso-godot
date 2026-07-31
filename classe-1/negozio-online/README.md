# Negozio online — vetrina (GitHub Pages) + database (Supabase)

Il negozio **tutto online**: la vetrina sta su **GitHub Pages**, i prodotti in un
**database vero** su **Supabase**. Funziona da casa, sul telefono, anche con i PC
di scuola spenti.

**Funziona subito in "modalità demo"** (prodotti finti): apri `index.html` e lo
vedi girare. Per farlo diventare **vero**, segui i tre pezzi qui sotto.

> File in questa cartella:
> - `index.html` — la vetrina (già pronta).
> - `prodotti.sql` — il database dei prodotti, da incollare in Supabase.
> - `README.md` — questa guida.

---

## Pezzo 1 — Creare il database su Supabase

1. `[BROWSER]` vai su **supabase.com** → in alto a destra **Start your project** →
   accedi (usa **l'account del docente**: sono minorenni).
2. Bottone verde **New project**. Dai un nome (es. `negozio`), scegli una password
   qualsiasi per il database (annotala), poi **Create new project**. Aspetta ~1 minuto.
3. Nel menu a sinistra apri **SQL Editor** → bottone **New query**.
4. Apri il file **`prodotti.sql`**, copia **tutto** il testo, incollalo nella
   lavagna e premi **Run** (in basso a destra). Deve dire "Success".
5. Sempre nel menu a sinistra apri **Table Editor**: vedi la tabella **prodotti**
   con dentro i prodotti di esempio. 🎉 Il database vive.

---

## Pezzo 2 — Prendere i due valori (le "chiavi" del database)

Al negozio servono **due** valori di Supabase:

1. Nel menu a sinistra, in basso, **Project Settings** (l'ingranaggio) → voce **API**.
2. Copia questi due (col bottone "copia"):
   - **Project URL** → è l'indirizzo del tuo database.
   - **anon public** (sotto "Project API keys") → è la chiave **pubblica**: si può
     mettere nella pagina senza problemi (permette solo di **leggere** i prodotti).

---

## Pezzo 3 — Incollare i valori nella vetrina

1. Apri **`index.html`** (in GitHub, icona **matita** per modificarlo).
2. Cerca le due righe con `<-- CAMBIA QUI` e incolla i valori tra le virgolette:

```
const SUPABASE_URL = "qui-il-Project-URL";
const SUPABASE_KEY = "qui-la-chiave-anon-public";
```

3. Salva (**Commit changes**). Da ora il negozio legge i **prodotti veri** dal
   database: il riquadro giallo "modalità demo" **sparisce**.

> Prova del nove: aggiungi un prodotto nel **Table Editor** di Supabase, ricarica
> il negozio… e il prodotto nuovo **compare da solo**. È un negozio vero.

---

## Pezzo 4 — Pubblicare la vetrina online (GitHub Pages)

Così ottieni il **link da mostrare a casa**.

1. Metti il file **`index.html`** nella **radice** del tuo repository su GitHub
   (il livello più alto, non dentro una sottocartella).
2. `[BROWSER — GitHub]` nel repository, in alto, **Settings** → menu a sinistra
   **Pages**.
3. Alla voce **Source** scegli **Deploy from a branch**, poi il ramo **main** e la
   cartella **/ (root)** → **Save**.
4. Aspetta un minuto e **ricarica**: in alto compare il tuo indirizzo, tipo
   `https://iltuonome.github.io/...`. Quello è il **link del tuo negozio**: aprilo
   sul telefono e fallo vedere a casa. ✅

---

### Nota onesta sui pagamenti
Con i minorenni **non** si attivano incassi veri (serve un conto aziendale di un
adulto). Questo è un negozio **demo funzionante**: si sfoglia, si mette nel
carrello, si arriva alla cassa — tutto tranne l'incasso reale. Per imparare e per
mostrare, è perfetto.
