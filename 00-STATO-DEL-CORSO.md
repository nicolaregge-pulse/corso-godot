# 00 Stato del Corso

**Versione 2.1** — 18/08/2026
*Fonte di verita del corso (stella polare). Se un altro documento contraddice
questo, vince questo. Decisa da Nicola.*

---

## 1. Missione
1. Corso di informatica pluriennale (classi 1-4) di istituto professionale, indirizzo Operatore Informatico; taglio pratico e tecnico.
2. Studenti spesso in situazione di svantaggio: si lavora con dignita e qualita, per aprire sbocchi lavorativi migliori. Qui non sono scarti: si da loro una cosa fatta bene.
3. Motore del coinvolgimento: "Vinci subito, Fallo tuo, Mostralo". L'errore non fa vergogna; si celebra ogni piccola vittoria.
4. La prova del nove: se lo sanno spiegare a voce con parole loro, la competenza c'e davvero.

## 2. Decisioni confermate (vincolanti)
1. Ogni documento esiste in due forme: MD (sorgente versionata) e PDF (consegnabile), con il numero di versione nel nome del file.
2. Tutti i documenti seguono lo standard unico di formattazione (vedi Regole di Formattazione): liste numerate, niente emoji, box colorati, tutto cio da copiare in blocchi di codice.
3. Con gli studenti tutto e visuale (browser e GitHub Desktop): mai la riga di comando. A scuola niente installazioni: si predilige browser e software portable.
4. Carta e penna in OGNI lezione (tassativo): appunti e schemi a mano, sempre; se un allievo non li ha, il docente glieli fornisce e segna una nota. Confluiscono nel quaderno personale.
5. Git a due fasi: Fase 1 (in 1a) esercizi separati con un commit ciascuno nel proprio repository; Fase 2 (3a-4a) progetto di gruppo che evolve con ramo, Pull Request e release.
6. Repository degli allievi: un'organizzazione GitHub della classe con un repository PRIVATO per ogni allievo, creati con GitHub Classroom (ognuno vede solo il suo; il docente vede tutti).
7. Ogni studente costruisce il PROPRIO libro di testo/quaderno, che cresce a ogni lezione, con l'aiuto dell'AI (aiuta a capire, non a saltare il pensiero).
8. Per questo progetto la fonte di verita e Nicola: nessun ruolo di soggetti esterni (Guido non c'entra: riguarda un'altra cosa, non il corso).

## 3. Impianto pluriennale (Mappa, Griglia, Piano ore, Programmi)
1. Mappa degli Argomenti: le macro-aree del corso, con indicazione di "di chi e" ciascuna area (alcune sono di altri docenti).
2. Griglia degli Argomenti (completa, 12 capitoli): ogni argomento ha le spunte 1a/2a/3a/4a e una colonna "Comp." con l'area di competenza dell'Allegato A che tocca.
3. Piano delle Ore di Lezione: l'albero macro-area -> sotto-argomento -> singola ora, guida giorno per giorno.
4. Programmi dei quattro anni: allineati alla Griglia; Classe 1 la piu sviluppata, Classi 2-3-4 avviate.
5. Corso Godot dedicato (manuale + eserciziario): e un documento ORGANICO, quasi un libro di testo, che Nicola usa e fa crescere man mano che gli studenti lavorano su Godot; puo spalmarsi su 2-3 anni. Per questo se ne tiene lo storico delle versioni (come per un libro che cresce). Il suo dettaglio e stato portato negli argomenti della Griglia (capitolo 8), tutti con X? perche gli anni sono ancora da fissare.

## 4. Allegato A e consegna alla Regione (workflow)
1. L'Allegato A NON e una "Bibbia" fissa: e il programma effettivamente svolto per una classe specifica (la storia reale degli argomenti). Cambia ogni anno e si modifica quando si fanno cose nuove o le si sposta di anno.
2. Ogni Allegato A e identificato da CLASSE e ANNO scolastico. I programmi svolti che generiamo stanno in `programma-svolto/<anno>/<classe>/` con nome `allegato-a_<classe>_<anno>`.
3. Fonte del "cosa e stato svolto": l'esportazione del registro (Excel) per classe. Claude legge le voci e le colloca nella competenza e annualita giuste (la colonna "Comp." della Griglia fa da ponte).
4. A fine anno si genera il programma svolto per area di competenza e per annualita, pronto da consegnare alla Regione.

## 5. Progetti pratici
1. "Il Mio Negozio Online" (e-commerce): vetrina su GitHub Pages, database su Supabase, ordini via FormSubmit. Progetto pilota completato e testato; cresce dalla 2a alla 4a.
2. Giochi con Godot: dai semplici al "progetto boss" (anno da decidere).
3. Cablaggio RJ45 e reti; in 4a il progetto forte: la rete di una scuola in Cisco Packet Tracer (VLAN, simulazione).

## 6. Punti aperti (da decidere/confermare con Nicola)
1. Godot: in quali anni collocarlo (probabile 3a-4a, la 2a da valutare) e come integrarlo col corso dedicato.
2. Strumento SQL senza installazione: proposta SQLite (browser sqliteonline.com + DB Browser portable), da confermare.
3. Strumento AI: verificare che tutto si faccia con Gemini gratuito (gli studenti non hanno Claude sull'account scolastico).
4. Cablaggio in 4a: da valutare.
5. Affinare la colonna competenze della Griglia dove serve.

## 7. Ruolo di questo documento
1. E la stella polare: in caso di contraddizione, vince questo, e nel documento in errore si apre un box rosso di disallineamento.
2. Si aggiorna quando cambiano le decisioni; le versioni gia stampate restano congelate.
3. Ogni volta che si produce o aggiorna un documento, si rigenera il libro complessivo e si alza la sua versione: tutto resta versionato e "tutto dentro".
