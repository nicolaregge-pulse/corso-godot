# Le Condizioni — SE… ALLORA… (IF / THEN / ELSE) e IFTTT (Classe 2)

**Versione 0.1** — 09/09/2026
*La "scatola" per l'argomento delle condizioni (la struttura di selezione): il
computer che decide. Prima il concetto in modo visivo e concreto con IFTTT ("se
questo, allora quello"), poi le stesse condizioni scritte in Lazarus
(if/then/else). Documento di lavoro: parte da qui e cresce. Metodo del corso:
prima si vince facile, poi si personalizza, poi si mostra; e ogni condizione si
disegna prima a mano sul quaderno (uno schemino "se... allora...").*

---

## 1. A cosa serve e come si usa

1. Obiettivo: capire che un programma non fa solo "una cosa dopo l'altra", ma sa **decidere**: *se una condizione e vera, allora fa una cosa; altrimenti ne fa un'altra*. E la **struttura di selezione**.
2. Percorso in tre passi:
   1. **Il concetto** (capitolo 3): "se… allora…" nella vita di tutti i giorni.
   2. **IFTTT** (capitolo 4): lo si tocca con mano su un sito, senza scrivere codice.
   3. **Lazarus** (capitolo 5): la stessa idea diventa codice vero (`if/then/else`).
3. Aggancio a cio che gia sanno: in Lazarus conoscono il bottone (**TButton**), la casella di testo (**TEdit**) e la scritta (**Caption**). Le condizioni si costruiscono sopra queste cose.
4. Carta e penna: prima di scrivere, si disegna lo **schemino della decisione** a mano (una domanda, due frecce: "vero" e "falso").

> [GIALLO] Motore del corso: il primo esempio deve dare un risultato subito ("se il numero e maggiore di 10, scrivi Hai vinto"). Sbagliare la condizione e normale: si prova, si guarda cosa succede, si corregge.

## 2. La parola nuova (glossario)

1. **Condizione**: una domanda a cui si risponde solo con "vero" o "falso" (es. "l'eta e maggiore o uguale a 18?").
2. **Selezione (if/then/else)**: la struttura che, in base alla condizione, sceglie cosa fare.
3. **IFTTT**: si legge "if this then that" (in inglese "se questo, allora quello"); e un sito per creare piccole automazioni.

## 3. Il concetto: "se… allora…" (prima a parole)

1. Nella vita reale decidiamo continuamente con delle condizioni:
   1. **Se** piove **allora** prendo l'ombrello, **altrimenti** esco senza.
   2. **Se** il semaforo e verde **allora** passo, **altrimenti** mi fermo.
2. Struttura sempre uguale: **SE** (condizione) **ALLORA** (cosa faccio se e vera) **ALTRIMENTI** (cosa faccio se e falsa). L'"altrimenti" a volte non serve.
3. Esercizio a mano (carta e penna): scrivi tre condizioni della tua giornata nella forma "se… allora… altrimenti…". Poi disegna una di queste come schemino con due frecce.

## 4. IFTTT — toccare con mano il "se… allora…"

1. **Cos'e**: un sito che crea **automazioni** con la logica "se succede questo, allora fai quello". Non si scrive codice: si scelgono i pezzi da un elenco.
2. **Dove**: si apre dal browser (niente da installare):
```
ifttt.com
```
3. **Le parole di IFTTT**: la parte "se" si chiama **trigger** (l'innesco), la parte "allora" si chiama **action** (l'azione). Un'automazione fatta cosi si chiama **applet**.
4. **Esempi di applet** (per far capire l'idea):
   1. **Se** arriva una certa email **allora** mandami una notifica.
   2. **Se** pubblico una foto **allora** salvala anche in una cartella.
   3. **Se** domani e prevista pioggia **allora** avvisami la sera prima.
5. **In aula**: si guarda insieme un applet gia pronto e si riconoscono le due parti (il "se" e l'"allora"). Se possibile, se ne crea uno semplice.

> [BLU] Nota pratica sull'account e i limiti: IFTTT chiede un account e oggi il piano gratuito permette **pochi applet**. Per la scuola basta cosi: serve a **vedere** la logica "se… allora…", non a costruire automazioni complesse. La guida click-by-click per creare un applet la facciamo insieme davanti allo schermo.

> [GIALLO] Perche partire da qui: IFTTT rende la decisione **visibile e concreta** prima ancora di scrivere una riga di codice. Cosi quando arriva Lazarus, l'idea e gia chiara.

## 5. Le condizioni in Lazarus (if / then / else)

1. In Lazarus (Object Pascal) la stessa idea si scrive con `if ... then ... else`:

```pascal
if punteggio > 10 then
  Label1.Caption := 'Hai vinto!'
else
  Label1.Caption := 'Riprova';
```

2. Si legge cosi: **SE** `punteggio` e maggiore di 10 **ALLORA** scrivi "Hai vinto!", **ALTRIMENTI** scrivi "Riprova".
3. I confronti che servono quasi sempre:
   1. `=` uguale, `<>` diverso.
   2. `>` maggiore, `<` minore.
   3. `>=` maggiore o uguale, `<=` minore o uguale.
4. Leggere un numero da una casella di testo (**TEdit**) e controllarlo:

```pascal
var eta: integer;
begin
  eta := StrToInt(Edit1.Text);   // prende il testo scritto e lo trasforma in numero
  if eta >= 18 then
    Label1.Caption := 'Maggiorenne'
  else
    Label1.Caption := 'Minorenne';
end;
```

> [GIALLO] Errore tipico (zero vergogna, capita a tutti): mettere il punto e virgola prima di `else`. In Pascal, la riga PRIMA di `else` non vuole il `;`. Se compare un errore su `else`, e quasi sempre quello.

## 6. Le stesse condizioni con Google e con i social

### Con Google Fogli — la funzione SE
1. Anche i Fogli di Google (e Excel) usano le condizioni, con la funzione **SE**: `=SE(condizione; cosa scrivo se e vera; cosa scrivo se e falsa)`.
2. Esempio (registro dei voti): in una cella scrivo
```
=SE(A2>=6; "Promosso"; "Rimandato")
```
   Se il voto nella cella A2 e almeno 6, scrive "Promosso", altrimenti "Rimandato". E lo stesso if/then/else, ma dentro un foglio di calcolo.
3. Esercizio: crea un foglio con una colonna "Voto" e una colonna "Esito" che si riempie da sola con la funzione SE; trascina la formula in giu e cambia la soglia per vedere cosa succede.
4. Passo in piu: in **Google Moduli** si fanno le **sezioni condizionali** (se rispondi in un certo modo, ti porta a una sezione diversa): e ancora "se… allora…".

### Con i social — la logica "se… allora…" ovunque
1. **Algoritmo del feed**: i social decidono cosa mostrarti con delle condizioni ("se guardi tanti video di sport, allora te ne mostro altri di sport"). Non e magia: sono regole "se… allora…".
2. **Moderazione**: "se un contenuto viola le regole, allora viene rimosso / l'account viene sospeso" (si lega al lavoro su ban e bot).
3. **Automazioni con IFTTT**: "se pubblico una foto, allora salvala anche in una cartella"; "se qualcuno mi cita, allora avvisami".
4. Esercizio (a parole, sul quaderno): scrivi tre regole "se… allora…" che secondo te usa un social (una per il feed, una per le notifiche, una per la moderazione). Poi ci si confronta in classe.

> [GIALLO] Filo conduttore: la stessa idea "se… allora…" ritorna dappertutto — in IFTTT, nei Fogli di Google, nei social e nel codice Lazarus. Riconoscerla e meta del lavoro.

## 7. Esercizio a 4 livelli — "Maggiorenne o no?"

Un piccolo programma: scrivo un'eta, premo un bottone, e mi dice se sono maggiorenne.

1. **Livello 1 — la sfida (cosa deve fare):** una finestra con una casella dove scrivere l'eta, un bottone "Controlla" e una scritta che diventa "Maggiorenne" oppure "Minorenne".
2. **Livello 2 — l'aiuto (l'indizio):** usa una condizione `if eta >= 18 then ... else ...`. L'eta la leggi dalla casella con `StrToInt(Edit1.Text)`. Il risultato lo scrivi in `Label1.Caption`.
3. **Livello 3 — la scena (i componenti):** metti nella form un **TEdit** (`Edit1`), un **TButton** (`Button1`, Caption "Controlla") e un **TLabel** (`Label1`). Il codice va nell'evento **click** del bottone (doppio clic sul bottone).
4. **Livello 4 — il codice completo:**

```pascal
procedure TForm1.Button1Click(Sender: TObject);
var eta: integer;
begin
  eta := StrToInt(Edit1.Text);
  if eta >= 18 then
    Label1.Caption := 'Maggiorenne'
  else
    Label1.Caption := 'Minorenne';
end;
```

5. **Fallo tuo:** cambia il messaggio ("Puoi entrare!" / "Ancora un po'…"), il colore della scritta, o la soglia. **Mostralo:** fai provare un compagno.

## 8. Altre idee di esercizio (da riempire piu avanti)

1. **Promosso o rimandato**: se il voto e >= 6 allora "Promosso", altrimenti "Rimandato".
2. **Numero pari o dispari**: usa il resto della divisione per 2 (`if numero mod 2 = 0 then ...`).
3. **Password giusta**: se il testo scritto e uguale a una parola segreta allora "Accesso consentito", altrimenti "Negato".
4. **Il piu grande tra due numeri**: leggi due numeri e di' qual e il maggiore.

## 9. Collegamenti

1. **Area programmazione, logica e algoritmi**: le condizioni sono una delle tre strutture di base (sequenza, **selezione**, iterazione).
2. **Verso Godot**: la stessa logica `if` si usa nei giochi (se il giocatore tocca la stella, allora punto +1).
3. **Mondo del lavoro / automazione**: IFTTT introduce l'idea di automatizzare compiti (si lega a Industria 4.0).
4. **Metodo del corso**: prima concreto (IFTTT) poi codice (Lazarus); vittoria subito, personalizzazione, si mostra; schemino della condizione disegnato a mano.
