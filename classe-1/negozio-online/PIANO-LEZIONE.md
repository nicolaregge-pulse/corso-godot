# Piano-lezione — Il Mio Negozio Online

**Versione 1.0** — 09/08/2026
*Documento per il docente. Come portare in classe il progetto del negozio online:
tempi, scaletta, come spiegare il database dal vivo, gestione dei ritmi diversi.*

---

## In breve

I ragazzi costruiscono un **negozio online vero** (con un link da mostrare a
casa), collegato a un **database della classe** e con gli **ordini via email**.
Si fa in **circa 3 lezioni da un'ora**, e a ogni lezione ognuno porta a casa una
**vittoria mostrabile**. Nessuno resta fuori: chi va piano si ferma alla prima
tappa (negozio online) ed è già una vittoria; chi vola personalizza e aiuta i
compagni.

Il filo è sempre lo stesso: **Vinci subito · Fallo tuo · Mostralo.**

---

## Prima di iniziare — cosa prepara il prof (una volta sola)

1. **Il database condiviso su Supabase** (già fatto): tabella `prodotti` con la
   policy di **sola lettura**. Consiglio: mettici prodotti simpatici, magari a
   tema classe, così è più loro.
2. **I due valori da consegnare** ai ragazzi (li trovi nelle note del docente,
   `README.md`): l'**indirizzo** (`https://….supabase.co`) e la **chiave
   pubblica** (`sb_publishable_…`, di sola lettura). Scrivili alla lavagna o in
   un messaggio in Classroom.
3. **Il file di partenza** `modello-negozio.html`: mettilo dove i ragazzi lo
   prendono facile (link al repository, Drive o Classroom).
4. **Gli account GitHub**: verifica che ogni ragazzo ne abbia uno (o falli creare
   nella lezione zero).
5. **Un negozio "esempio" tuo già online**: da mostrare all'inizio come traguardo
   ("ecco dove arriviamo").

---

## La scaletta (3 lezioni)

### Lezione 1 — "Il mio negozio è ONLINE" (Tappa 1)
Obiettivo: ognuno ha un **link** che funziona (con prodotti di esempio).

| Tempo | Cosa |
|---|---|
| 5' | Mostri il tuo negozio-esempio: *"oggi ognuno fa il suo, con un link vero"*. |
| 30' | Insieme: crea repository → carica `index.html` → accendi GitHub Pages. |
| 15' | Ognuno apre il **suo link** e lo mostra al compagno di banco. |
| 10' | Chiusura: *"FATTO — il tuo negozio è online"*. Screenshot nel quaderno. |

> Vittoria: un link vero da mostrare. **Nessuno esce senza il suo negozio online.**

### Lezione 2 — "I prodotti veri: il database" (Tappa 2)
Obiettivo: nel negozio compaiono i **prodotti veri**, dal database della classe.

| Tempo | Cosa |
|---|---|
| 15' | **Tu spieghi il database dal vivo** (canovaccio qui sotto). |
| 25' | Distribuisci i **due valori**; i ragazzi li incollano nel loro file. |
| 10' | Il "**wow**": cambi un prodotto nel database → tutti ricaricano → cambia in **tutti** i negozi. |
| 10' | Chiusura + quaderno. |

### Lezione 3 — "Ordini via email + fallo tuo" (Tappe 3-4)
Obiettivo: gli ordini arrivano per **email**, e ognuno **personalizza** il suo.

| Tempo | Cosa |
|---|---|
| 20' | Ognuno mette la **sua email**, prova un ordine, attiva FormSubmit, riprova. |
| 20' | **Fallo tuo:** cambia nome e colori del negozio. |
| 20' | **Mostralo + prova del nove:** racconta a voce cosa fa il suo negozio; screenshot nel quaderno. |

---

## Canovaccio — spiegare il database dal vivo (10-15 min)

Al proiettore, sul **tuo** Supabase. Poche cose, concrete:

1. **"Dove stanno i prodotti?"** → apri **Table Editor** → tabella `prodotti`.
   Fai vedere: ogni **riga** è un prodotto, ogni **colonna** un'informazione
   (nome, prezzo, foto). *Analogia:* è un **magazzino** (o il registro di classe:
   righe = alunni, colonne = dati).
2. **"Come glielo chiediamo?"** → apri **SQL Editor** e scrivi dal vivo:
   ```sql
   select * from prodotti;
   ```
   Premi **Run**: tornano tutti. Poi:
   ```sql
   select * from prodotti where prezzo < 20;
   ```
   Tornano solo alcuni. Messaggio: **"SQL = fare domande al magazzino."**
3. **"Chi può cambiarli?"** → spiega la **sola lettura**: i ragazzi **guardano**,
   solo il prof **modifica**. Così nessuno rovina il lavoro degli altri.
4. **Il "wow" (fallo alla Lezione 2):** cambia un **prezzo** nel Table Editor →
   fai ricaricare un negozio a caso → è cambiato. *"Un database è vivo: cambio
   qui, cambia dappertutto."*

> Se qualcuno chiede "perché non nel file?": perché così i prodotti stanno in
> **un posto solo** e li aggiorni una volta per tutti. È il senso del database.

---

## Se lavori a gruppi (opzionale, 2-4 ragazzi)

Ruoli **a rotazione**, così tutti provano tutto:
- **Vetrina:** crea il repository e pubblica su GitHub Pages.
- **Database:** incolla i due valori e verifica i prodotti.
- **Grafica:** sceglie nome e colori.
- **Ordini:** mette l'email e prova la cassa.

Poi si cambia, così nessuno si nasconde dietro i più bravi e ognuno tocca ogni
pezzo. (Si lega bene a **Git**: ognuno lavora sul suo pezzo, poi si uniscono.)

---

## Gestire i ritmi diversi (importante per questa classe)

- **Chi va piano:** basta arrivare alla **Tappa 1** (negozio online con prodotti
  di esempio). È già una vittoria vera e mostrabile. **Nessuno resta fuori.**
- **Chi vola:** personalizza colori e testo del bottone, aggiunge prodotti (con
  te), oppure fa da **tutor** a un compagno (spiegare consolida).
- **Errore = zero vergogna:** si annulla con un clic, il bug è normale — *"capita
  a tutti i programmatori, anche ai più bravi"*.

---

## Valutazione (coerente col corso)

1. **Il negozio che funziona è il biglietto d'ingresso, non il voto.**
2. **Il voto nasce dalla prova dal vivo:** lo **spiega a voce** (cosa fa, dove
   stanno i prodotti, cosa succede all'ordine), **oppure** gli dai il suo file
   con **un piccolo errore** e lo rimette a posto lì per lì.
3. **Prova del nove:** se lo sa **raccontare con parole sue**, la competenza c'è.

---

## Checklist da tenere in aula

- [ ] PC con browser + proiettore
- [ ] I **due valori** del database (indirizzo + chiave pubblica)
- [ ] Il file `modello-negozio.html` raggiungibile dai ragazzi
- [ ] Gli **account GitHub** pronti
- [ ] Il tuo **negozio-esempio** già online da mostrare
