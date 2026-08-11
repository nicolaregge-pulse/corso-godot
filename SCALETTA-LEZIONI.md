# Scaletta delle prime lezioni

Piano di partenza per la Fase 1, quella degli esercizi separati. Serve al prof
per avere la rotta pronta: cosa si spiega, in che ordine, con quale esercizio.

Non è una gabbia. Con questi ragazzi il tempo è elastico: una "lezione" qui può
valere una o due ore di classe. Si va al loro passo. La regola sopra ogni cosa
resta il motore Vinci subito, Fallo tuo, Mostralo: ogni lezione deve chiudersi
con una piccola vittoria concreta e mostrabile.

Ogni esercizio è nell'eserciziario coi quattro livelli di aiuto, e nel
manuale trovi il capitolo che lo costruisce passo passo con le foto.

---

## Lezione 0 — Benvenuti in Godot, il colpo d'occhio

Obiettivo: far vedere che con Godot si fanno cose fighe, prima ancora di scrivere
una riga. Togliere la paura, accendere la voglia.

In classe:
- Aprite Godot portabile, senza installare niente.
- Fate girare un gioco già pronto, per esempio Affonda la Bonomi o Acchiappa le
  stelle. Li fai giocare due minuti.
- Il ponte da Lazarus, detto a voce, senza tecnicismi: in Lazarus c'era la Form,
  qui c'è la Scena; i componenti diventano i nodi; l'evento del click diventa un
  segnale. Stessa idea, nome nuovo.

La vittoria da mostrare: hanno visto un gioco vero girare, fatto con lo stesso
strumento che useranno loro.

---

## Lezione 1 — Il bottone che saluta

Materiale: Esercizio 1.

Obiettivo: costruire da zero una schermata con un bottone e una scritta che
cambia al click.

Concetto nuovo, piccolo: nodo, scena, proprietà, segnale.

Ponte da Lazarus, diretto:
- Il bottone è il nodo Button, come il tuo TButton.
- La scritta è il nodo Label; la sua proprietà text è la vecchia Caption.
- Il click è il segnale pressed, come il tuo Button1Click.

Fallo tuo: ognuno sceglie la frase del saluto e il colore della scritta.

La vittoria da mostrare: premo il bottone e compare il mio saluto.

---

## Lezione 2 — Il quadrato che si muove

Materiale: Esercizio 2.

Obiettivo: muovere un quadrato con le frecce.

Concetto nuovo chiave, da introdurre bene: il game loop, cioè `_process(delta)`,
che gira da solo circa 60 volte al secondo. La frase da lasciargli: Lazarus
reagisce, Godot pulsa. In Lazarus il codice partiva solo quando succedeva
qualcosa; qui c'è un battito continuo che possiamo usare per muovere le cose.

Fallo tuo: colore, dimensione e velocità del quadrato.

La vittoria da mostrare: muovo il mio quadrato sullo schermo con le frecce.

---

## Lezione 3 — Prendi la moneta

Materiale: Esercizio 3.

Obiettivo: un primo gioco vero: un cestino che si muove, una moneta che cade, un
punteggio che sale.

Concetti nuovi, piccoli: una variabile che tiene il punteggio, il controllo se
due cose si toccano, il far ricomparire la moneta in alto.

Fallo tuo: colori, velocità, e cosa cade, una moneta, una stella, una faccina.

La vittoria da mostrare: gioco e vedo il punteggio salire quando prendo.

---

## Lezione 4 — Acchiappa le stelle

Materiale: Esercizio 4.

Obiettivo: trasformare il gioco della moneta in un gioco che si può perdere.

Concetto nuovo: le vite e il game over. Il gioco ora ha uno stato, sta giocando
oppure è finito, e si può ricominciare premendo INVIO.

Fallo tuo: quante vite, l'aspetto della navetta e delle stelle, la scritta di
fine partita.

La vittoria da mostrare: un gioco completo, con punteggio, vite, game over e
ripartenza. Da far provare al compagno di banco.

---

## Lezione 5 — La prima consegna

Materiale: `consegne/INVITO-ALLA-CLASSE.md`.

Obiettivo: mettere online il proprio lavoro. È qui che entra Git, nella versione
più semplice.

Concetto nuovo: la mia copia del corso, il fork, e il commit come salvataggio.
Niente branch, niente Pull Request: quelli arrivano in Fase 2, coi gruppi.

In classe: il primo giro guidato tutti insieme alla lavagna. Ognuno si fa il
fork, copia il modello, compila la scheda con parole sue, carica i file.

La vittoria da mostrare: la mia consegna è online, con un link che posso mandare.

---

## Lezione 6 — Personalizza e mostra

Obiettivo: consolidare e divertirsi. Chi è avanti personalizza a fondo un gioco
o apre un Progetto BOSS; chi è indietro recupera con calma un esercizio.

Idea: una piccola gara amichevole di personalizzazioni, si vota il più bello.
L'obiettivo non è il voto, è il gusto di mostrare una cosa propria.

La vittoria da mostrare: ognuno ha almeno un gioco suo, personalizzato, di cui è
fiero.

---

## Dopo la Fase 1

Quando hanno preso confidenza, si passa alla Fase 2: il progetto di gruppo che
cresce, con branch, Pull Request e release. Lì si insegna a lavorare in team, coi
ruoli divisi, come in un vero gruppo di sviluppo.
