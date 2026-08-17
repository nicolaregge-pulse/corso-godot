# Le Reti di Computer — Teoria

**Versione 0.1** — 17/08/2026
*Teoria delle reti per la Classe 3, spiegata semplice e con esempi di tutti i
giorni. Prepara al laboratorio: cablaggio, piccole reti e Cisco Packet Tracer.
Documento di lavoro, cresce insieme al corso.*

---

## 1. Cos'e una rete
1. Una rete collega piu dispositivi e li fa comunicare e condividere cose (Internet, file, stampanti).
2. Immagine utile: e come una rete stradale che collega tante case; i dati sono le auto che viaggiano da una casa all'altra.

## 2. Gli apparecchi di rete in casa
1. Modem (Modulator-Demodulator: modulatore-demodulatore): collega casa a Internet e traduce il segnale della linea (telefonica o fibra) in dati che il computer capisce.
2. Router (instradatore): smista i dati tra la rete di casa e Internet e decide dove mandare ogni pacchetto. Di solito assegna anche gli indirizzi e fa da Wi-Fi.
3. Modem-router: i due apparecchi in un'unica scatola, quella che di solito da l'operatore.
4. Access Point (punto di accesso): crea la rete senza fili (Wi-Fi). Nel router di casa e gia integrato.
5. Repeater o Range Extender (ripetitore): ripete e allunga il segnale Wi-Fi dove arriva debole. Ripete cio che riceve.
6. Powerline: usa l'impianto elettrico di casa per portare la rete da una stanza all'altra, con due scatoline infilate nelle prese.
7. Switch (commutatore): collega piu dispositivi via cavo dentro la stessa rete, mandando i dati solo a chi servono.
8. Hub (concentratore): come lo switch ma "senza cervello": ripete a tutti. Oggi quasi non si usa piu.

> [GIALLO] Differenza chiave: il ROUTER collega reti diverse (casa verso Internet); lo SWITCH collega dispositivi dentro la stessa rete.

## 3. I cavi di rete
1. Il cavo Ethernet ha un connettore RJ45 e dentro 8 fili raggruppati in 4 coppie intrecciate.
2. Le coppie sono intrecciate apposta: cosi si disturbano di meno e il segnale e piu pulito.
3. Le categorie (per esempio Cat 5e, Cat 6): piu alta e la categoria, piu veloce puo andare il cavo.
4. Lo standard T568B stabilisce l'ordine dei colori quando si monta il connettore: lo useremo in laboratorio.
5. Cenno: la fibra ottica porta i dati con la luce; e velocissima e adatta alle lunghe distanze.

## 4. Hub, switch e routing
1. Hub: ripete il segnale a tutte le porte; risultato, traffico inutile e "collisioni".
2. Switch: impara quale dispositivo e attaccato a ogni porta e manda i dati solo alla porta giusta.
3. Routing (instradamento): il router sceglie la strada per far arrivare un pacchetto a una rete diversa. Instradare vuol dire proprio "scegliere il percorso".

## 5. Gli indirizzi in rete
1. Indirizzo IP (Internet Protocol): l'indirizzo di un dispositivo, come il numero civico di una casa.
2. Maschera di sottorete: dice quale parte dell'indirizzo indica la "via" (la rete) e quale il "civico" (il singolo dispositivo).
3. Gateway (passaggio): la porta verso l'esterno, di solito il router.
4. DHCP (Dynamic Host Configuration Protocol): assegna gli indirizzi IP in automatico, senza scriverli a mano.
5. Cenno: il MAC address e l'indirizzo "di fabbrica" della scheda di rete, unico per ogni scheda.

## 6. Il modello ISO/OSI (i 7 livelli)
1. ISO e l'organizzazione che ha definito il modello; OSI (Open Systems Interconnection: interconnessione di sistemi aperti) e il nome del modello. Per questo si dice "modello ISO/OSI".
2. E un modo per dividere la comunicazione in 7 piani, ognuno con un compito. Dal basso verso l'alto:
   1. Fisico: i segnali che viaggiano sul cavo o nell'aria.
   2. Collegamento dati: lo scambio tra due apparati vicini (qui lavorano MAC e switch).
   3. Rete: l'indirizzamento e la scelta del percorso (qui lavorano IP e router).
   4. Trasporto: la consegna, affidabile o veloce (qui lavorano TCP e UDP).
   5. Sessione: apre e chiude le "conversazioni" tra due programmi.
   6. Presentazione: il formato e la codifica dei dati.
   7. Applicazione: i programmi che usiamo (pagine web, posta).
3. A cosa serve: se qualcosa non funziona, aiuta a capire "a che piano" cercare il guasto.

## 7. Il modello TCP/IP (i 4 livelli)
1. E il modello pratico con cui funziona Internet davvero.
2. Ha 4 livelli: Accesso alla rete, Internet (IP), Trasporto (TCP o UDP), Applicazione.
3. E una versione piu snella del modello ISO/OSI: fa le stesse cose, con meno piani.

## 8. Come viaggiano i pacchetti
1. Un dato grande viene spezzato in tanti pacchetti piccoli.
2. Ogni pacchetto porta un'intestazione con mittente e destinatario (gli indirizzi IP), come una busta con l'indirizzo scritto sopra.
3. I router leggono l'indirizzo e instradano ogni pacchetto verso la destinazione, anche per strade diverse.
4. All'arrivo i pacchetti vengono rimessi in ordine per ricostruire il dato di partenza.

> [GIALLO] Immagine utile: spedire un libro pagina per pagina, in tante buste separate; arrivano e poi si rimonta il libro nell'ordine giusto.

## 9. Due modi di spedire i dati: TCP e UDP
1. TCP (Transmission Control Protocol): la spedizione "con ricevuta di ritorno".
   1. Prima si stabilisce la connessione tra i due dispositivi.
   2. Ogni pacchetto viene confermato; se uno si perde, viene rispedito.
   3. E affidabile, ma con un po' piu di lavoro. Si usa per pagine web, posta, invio di file.
2. UDP (User Datagram Protocol): la spedizione "veloce, senza ricevuta".
   1. Non conferma niente: se un pacchetto si perde, pazienza.
   2. E velocissimo. Si usa per video in diretta, giochi online, chiamate vocali.

> [GIALLO] La scelta dipende dal bisogno: meglio sicuro (TCP) oppure meglio veloce (UDP).

## 10. Dalla teoria alla pratica
1. In laboratorio costruiremo cavi veri e piccole reti reali.
2. In Cisco Packet Tracer (simulatore di reti) progetteremo una rete e proveremo l'invio dei pacchetti.
3. La modalita "simulazione" di Packet Tracer mostra il pacchetto che viaggia da un apparato all'altro: cosi la teoria di questo documento si vede in movimento.
