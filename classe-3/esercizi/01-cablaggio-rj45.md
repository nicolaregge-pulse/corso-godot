# Cablaggio RJ45 — Scheda pratica

**Versione 0.1** — 17/08/2026
*Prima scheda pratica di reti per la Classe 3. Come l'eserciziario, ha 4 livelli
di aiuto a scoperta graduale: chi ce la fa procede da solo, chi si blocca apre
solo l'aiuto che gli serve.*

---

## Esercizio 1 — Costruire un cavo di rete diretto (RJ45)

Obiettivo: costruire con le tue mani un cavo di rete Ethernet, montando i
connettori RJ45 con lo standard T568B, e verificare che funzioni collegando due
computer.

Alla fine avrai un cavo tuo, che funziona davvero: potrai usarlo per collegare i
PC del laboratorio.

<details>
<summary>🟡 Aiuto (un indizio)</summary>

1. I fili dentro il cavo sono 8, in 4 coppie intrecciate.
2. Conta che l'ordine dei colori deve essere lo stesso ai due capi (cavo "diritto").
3. Prima di inserire i fili nel connettore, vanno messi in fila e tagliati dritti tutti alla stessa lunghezza.
4. Non serve spellare i singoli fili: si infilano interi nel connettore, e' la crimpatrice a fare il contatto.

</details>

<details>
<summary>🟠 Materiale e passi</summary>

Materiale:
1. Un pezzo di cavo di rete (UTP).
2. Due connettori RJ45.
3. Una crimpatrice (lo strumento che "chiude" il connettore).
4. Una tronchesina/forbice e, se c'e', un tester per cavi.

Passi:
1. Togli circa 2-3 cm di guaina esterna, senza rovinare i fili interni.
2. Separa le 4 coppie e distendi gli 8 fili.
3. Mettili nell'ordine dello standard T568B (vedi lo schema).
4. Taglia le punte dritte, tutte alla stessa lunghezza.
5. Infila gli 8 fili nel connettore RJ45, con la linguetta rivolta in basso, controllando che ogni filo arrivi in fondo e resti nel suo ordine.
6. Inserisci il connettore nella crimpatrice e stringi bene.
7. Ripeti allo stesso modo sull'altro capo, con lo stesso ordine di colori.

![Ordine dei colori dello standard T568B, dal pin 1 al pin 8.](immagini/t568b.svg)

</details>

<details>
<summary>🔴 Soluzione completa</summary>

Ordine T568B (uguale ai due capi), dal pin 1 al pin 8:
1. bianco-arancio
2. arancio
3. bianco-verde
4. blu
5. bianco-blu
6. verde
7. bianco-marrone
8. marrone

Come verificare che funziona:
1. Se hai un tester per cavi, collega i due capi: devono accendersi in ordine i led da 1 a 8.
2. In alternativa, collega due computer con il cavo, dai a ciascuno un indirizzo IP della stessa rete (per esempio 192.168.1.10 e 192.168.1.11) e prova il comando ping da uno verso l'altro.
3. Se il ping risponde, il cavo e la connessione funzionano.

Se qualcosa non va:
1. Controlla che l'ordine dei colori sia identico ai due capi.
2. Controlla che ogni filo arrivi fino in fondo al connettore.
3. Ricrimpa se un contatto non tiene: e' normale sbagliare il primo cavo, capita a tutti.

</details>
