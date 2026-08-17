# 03 Scaletta delle prime lezioni

Versione 1.0 — 16/08/2026

Piano di partenza per la Fase 1, quella degli esercizi separati. Serve al prof
per avere la rotta pronta: cosa si spiega, in che ordine, con quale esercizio.

Non è una gabbia. Con questi ragazzi il tempo è elastico: una lezione qui può
valere una o due ore di classe. Si va al loro passo. La regola sopra ogni cosa
resta il motore Vinci subito, Fallo tuo, Mostralo: ogni lezione deve chiudersi
con una piccola vittoria concreta e mostrabile.

Ogni esercizio è nell'eserciziario coi quattro livelli di aiuto, e nel manuale
trovi il capitolo che lo costruisce passo passo con le foto.

## 1. Lezione 0, benvenuti in Godot, il colpo d'occhio

1. Obiettivo: far vedere che con Godot si fanno cose fighe, prima ancora di
   scrivere una riga. Togliere la paura, accendere la voglia.
2. In classe:
   1. Aprite Godot portabile, senza installare niente.
   2. Fate girare un gioco già pronto, per esempio Affonda la Bonomi o Acchiappa
      le stelle. Li fai giocare due minuti.
   3. Il ponte da Lazarus, detto a voce, senza tecnicismi: in Lazarus c'era la
      Form, qui c'è la Scena; i componenti diventano i nodi; l'evento del click
      diventa un segnale. Stessa idea, nome nuovo.
3. La vittoria da mostrare: hanno visto un gioco vero girare, fatto con lo stesso
   strumento che useranno loro.

## 2. Lezione 1, il bottone che saluta

1. Materiale: Esercizio 1.
2. Obiettivo: costruire da zero una schermata con un bottone e una scritta che
   cambia al click.
3. Concetto nuovo, piccolo: nodo, scena, proprietà, segnale.
4. Ponte da Lazarus, diretto:
   1. Il bottone è il nodo Button, come il tuo TButton.
   2. La scritta è il nodo Label; la sua proprietà text è la vecchia Caption.
   3. Il click è il segnale pressed, come il tuo Button1Click.
5. Fallo tuo: ognuno sceglie la frase del saluto e il colore della scritta.
6. La vittoria da mostrare: premo il bottone e compare il mio saluto.

## 3. Lezione 2, il quadrato che si muove

1. Materiale: Esercizio 2.
2. Obiettivo: muovere un quadrato con le frecce.
3. Concetto nuovo chiave, da introdurre bene: il game loop, cioè
   `_process(delta)`, che gira da solo circa 60 volte al secondo. La frase da
   lasciargli: Lazarus reagisce, Godot pulsa. In Lazarus il codice partiva solo
   quando succedeva qualcosa; qui c'è un battito continuo che possiamo usare per
   muovere le cose.
4. Fallo tuo: colore, dimensione e velocità del quadrato.
5. La vittoria da mostrare: muovo il mio quadrato sullo schermo con le frecce.

## 4. Lezione 3, prendi la moneta

1. Materiale: Esercizio 3.
2. Obiettivo: un primo gioco vero: un cestino che si muove, una moneta che cade,
   un punteggio che sale.
3. Concetti nuovi, piccoli: una variabile che tiene il punteggio, il controllo se
   due cose si toccano, il far ricomparire la moneta in alto.
4. Fallo tuo: colori, velocità, e cosa cade, una moneta, una stella, una faccina.
5. La vittoria da mostrare: gioco e vedo il punteggio salire quando prendo.

## 5. Lezione 4, acchiappa le stelle

1. Materiale: Esercizio 4.
2. Obiettivo: trasformare il gioco della moneta in un gioco che si può perdere.
3. Concetto nuovo: le vite e il game over. Il gioco ora ha uno stato, sta
   giocando oppure è finito, e si può ricominciare premendo INVIO.
4. Fallo tuo: quante vite, l'aspetto della navetta e delle stelle, la scritta di
   fine partita.
5. La vittoria da mostrare: un gioco completo, con punteggio, vite, game over e
   ripartenza. Da far provare al compagno di banco.

## 6. Lezione 5, la prima consegna

1. Materiale: `consegne/INVITO-ALLA-CLASSE.md`.
2. Obiettivo: mettere online il proprio lavoro. È qui che entra Git, nella
   versione più semplice.
3. Concetto nuovo: la mia copia del corso, il fork, e il commit come
   salvataggio. Niente branch, niente Pull Request: quelli arrivano in Fase 2,
   coi gruppi.
4. In classe: il primo giro guidato tutti insieme alla lavagna. Ognuno si fa il
   fork, copia il modello, compila la scheda con parole sue, carica i file.
5. La vittoria da mostrare: la mia consegna è online, con un link che posso
   mandare.

## 7. Lezione 6, personalizza e mostra

1. Obiettivo: consolidare e divertirsi. Chi è avanti personalizza a fondo un
   gioco o apre un progetto boss; chi è indietro recupera con calma un esercizio.
2. Idea: una piccola gara amichevole di personalizzazioni, si vota il più bello.
   L'obiettivo non è il voto, è il gusto di mostrare una cosa propria.
3. La vittoria da mostrare: ognuno ha almeno un gioco suo, personalizzato, di cui
   è fiero.

## 8. Dopo la Fase 1

1. Quando hanno preso confidenza, si passa alla Fase 2: il progetto di gruppo che
   cresce, con branch, Pull Request e release. Lì si insegna a lavorare in team,
   coi ruoli divisi, come in un vero gruppo di sviluppo.
