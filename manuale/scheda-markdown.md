# Scheda — Scrivere in Markdown ✍️
*La tua dispensa, fatta con due segnetti.*

**Versione 0.1** — 26/07/2026
*Fonte versionata. Da questo file si genera la scheda-PDF da consegnare.*

---

## Cos'è il Markdown (in una frase)

**Markdown** (si dice *"marc-daun"*) è un modo per scrivere **testo normale** e
aggiungere qualche **segnetto** che dice *come deve apparire* (questo è un
titolo, questa parola è in grassetto, questo è un elenco…).

> 💡 **Il ponte con quello che conosci:** in Word premi il bottone **grassetto**;
> qui il bottone non c'è, il grassetto lo **scrivi tu** mettendo due asterischi
> attorno alla parola. Tutto qui.

I segnetti li scrivi tu, ma nel risultato finale **non si vedono**: servono solo
a dare la forma al testo.

---

## La tabella dei segnetti (i "caratteri con significato")

| Vuoi ottenere… | Scrivi così |
|---|---|
| Un **titolo** grande | `# Il mio titolo` |
| Un titolo più piccolo | `## Sottotitolo` · `### ancora più piccolo` (più `#` = più piccolo) |
| **Grassetto** | `**parola**` (due asterischi prima e dopo) |
| *Corsivo* | `*parola*` (un asterisco prima e dopo) |
| Un punto elenco | `- prima cosa` (trattino + **spazio**) |
| Un elenco numerato | `1. prima cosa` |
| Un nome tecnico / codice **in riga** | `` `_process` `` (un apice basso `` ` `` prima e dopo) |
| Un'**immagine** (tuo screenshot) | `![il mio gioco](immagini/es1.png)` |
| Una **nota/riquadro** | `> Attenzione: ricordati di salvare!` |

> ℹ️ L'apice basso `` ` `` (in inglese *backtick*) su tastiera italiana si fa
> con **`Alt Gr` + `'`** (il tasto dell'apostrofo, vicino allo `0`).

---

## Un blocco di codice (quando incolli tutto un pezzo di codice)

Metti **tre apici bassi** prima e **tre** dopo. Così Godot/GDScript viene
mostrato bello incolonnato:

````
```gdscript
func _ready():
    print("Ciao!")
```
````

---

## Le 4 regole d'oro (le uniche da ricordare)

1. **Riga vuota tra un paragrafo e l'altro.** Se non la metti, le frasi si
   attaccano tutte insieme.
2. **Uno spazio dopo `#` e dopo `-`.** `#Titolo` non funziona, `# Titolo` sì.
3. **I segnetti non si vedranno:** servono solo a dire "questo è un titolo",
   "questo è grassetto". Non spaventarti se nel testo grezzo sembrano strani.
4. **Bloccato? Fatti aiutare bene dall'AI.** Scrivi quello che vuoi dire con
   **parole tue**, poi chiedi: *"mettimi questo in Markdown"*. Poi **guarda come
   l'ha fatto** — così impari il segnetto per la prossima volta. (Ricorda il
   patto: l'AI ti aiuta a *formattare*, il pensiero resta tuo.)

---

## Come metto un mio screenshot 📸

1. Fai lo screenshot del **tuo** gioco (in Windows: `Win + Shift + S`).
2. Salvalo/caricalo nella cartella **`immagini/`** con il nome che trovi già
   scritto nel modello (es. `es1.png`).
3. Nella pagina la riga è **già pronta**: `![il mio gioco](immagini/es1.png)`.
   Non devi scrivere altro: l'immagine comparirà da sola.

> 🎉 **Prova del nove:** se guardi la tua pagina e vedi il titolo grande, il
> grassetto e il tuo screenshot al posto giusto… **ce l'hai fatta!** Sei
> ufficialmente capace di scrivere in Markdown.

---

## Changelog della scheda

| Versione | Data | Cosa è cambiato |
|---|---|---|
| 0.1 | 26/07/2026 | Prima stesura: cos'è il Markdown, tabella dei segnetti, blocco di codice, 4 regole d'oro, come inserire uno screenshot. |
