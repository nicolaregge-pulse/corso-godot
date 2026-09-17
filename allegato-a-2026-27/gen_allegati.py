# -*- coding: utf-8 -*-
import re, os
ROOT="/home/user/corso-godot"
OUT=f"{ROOT}/allegato-a-2026-27"
os.makedirs(OUT, exist_ok=True)
mie=open(f"{ROOT}/MIE-PARTI-ALLEGATO-A.md",encoding="utf-8").read().split("\n")

# parse MIE-PARTI: {classe: [(comp_heading, [argomenti])]}
classi={}; cur=None; comp=None
for ln in mie:
    s=ln.rstrip()
    if s.startswith("## Classe "):
        m=re.match(r"## (Classe \d)", s); cur=m.group(1) if m else None
        if cur: classi.setdefault(cur,[]); comp=None
        continue
    if s.startswith("### Competenza"):
        comp=(s[4:].strip(),[]);
        if cur: classi[cur].append(comp)
        continue
    if not s or s.startswith(">") or s.startswith("*") or s.startswith("#"): continue
    if cur and comp is not None: comp[1].append(s.strip())

def comp_h(t):
    m=re.match(r"Competenza\s+(\d+)\.\s*(.*?)\s+—\s+(.*)$", t)
    if m: return f"Competenza {m.group(1)} — {m.group(2).strip()} ({m.group(3)})"
    return t

HEAD=lambda cl,note: f"""# Allegato A 2026/27 — Le mie parti (Regge) — {cl}

**Versione 0.1** — 17/09/2026
*Solo le parti del prof. Regge (competenze tecnico-professionali), pronte da
incollare negli Argomenti dell'annualita 2026/27 del PFP ufficiale. Le
Abilita e le Conoscenze restano quelle standard gia presenti nel PFP: qui ci
sono gli Argomenti, mappati per competenza (area). {note}*

---
"""

def write_class(fname, cl, comps, note):
    body=[HEAD(cl,note)]
    for (title,args) in comps:
        if not args: continue
        body.append(f"## {comp_h(title)}\n")
        for a in args:
            body.append(f"1. {a}")
        body.append("")
    open(f"{OUT}/{fname}","w",encoding="utf-8").write("\n".join(body))
    print("scritto",fname, "comp:", sum(1 for c in comps if c[1]))

# Classi 2,3,4 da MIE-PARTI
write_class("allegato-a-classe-2.md","Classe 2 (dal PFP1 Operatore, II annualita)", classi.get("Classe 2",[]),
            "Mappatura da confermare (MIE-PARTI: PFP1 -> 2a).")
write_class("allegato-a-classe-3.md","Classe 3 (dal PFP2 Operatore)", classi.get("Classe 3",[]),
            "Mappatura da confermare (MIE-PARTI: PFP2 -> 3a).")
write_class("allegato-a-classe-4.md","Classe 4 (dai PFP3/PFP4)", classi.get("Classe 4",[]),
            "Mappatura da confermare (MIE-PARTI: PFP3/PFP4 -> 4a; storico Operatore + qualifica Tecnico).")

# Classe 1: nuovo PFP (I Anno) dal programma ampliato
C1=[
 ("Competenza 8 — Utilizzare le tecnologie informatiche per la comunicazione e la ricezione di informazioni (I Anno)",[
   "Presentazione corso; Cosa faremo quest'anno; Norme comuni (regolamento strumenti informatici, servizi digitali e IA)",
   "Creazione dell'Area Logica; avvio all'uso della Suite Google per comunicare",
   "Che cos'e l'informatica; uso consapevole della tecnologia",
   "Memorie di massa e RAM; storia ed evoluzione dei calcolatori (video Jobs)",
   "Introduzione e creazione del Glossario informatico",
   "Digitalizzazione di immagini e suoni",
   "La rete: hardware e software; reti e cittadinanza digitale (LAN/WAN, protocolli, funzionamento del web, privacy, uso consapevole)",
   "Social e comunicazione sulla rete; netiquette; identita digitale",
   "Rischi in rete; malware di base (virus, phishing)",
   "Sicurezza da utente: password robuste, e-mail sospette/phishing, cookie e tracciamento, richieste di dati di pagamento (Recupero INVALSI)",
   "Comunicazione formale: Gmail, oggetto, CC/CCN, mail formale",
   "Intelligenza artificiale: cos'e, uso consapevole, Gemini e i \"Gem\" (assistenti)",
   "Ricerca in rete: motori di ricerca, ricerca avanzata, operatori booleani",
   "Mondo del lavoro: figure professionali dell'informatica; \"Bussola del lavoro\"; cenni al CV",
 ]),
 ("Competenza 13 — Approntare, monitorare e curare la manutenzione ordinaria di strumenti, utensili, attrezzature (I Anno)",[
   "Le parti fondamentali di un PC",
   "Hardware e architettura (Von Neumann, CPU, RAM e ROM, memorie di massa, periferiche di input/output, evoluzione storica)",
   "Rappresentazione delle informazioni (sistemi di numerazione binario/decimale/esadecimale, codifica ASCII e Unicode, bit e byte, unita di misura)",
   "Componenti e loro scelta (case, RAM, scheda video, socket e slot, HDD e SSD)",
   "Smontare il PC, riassemblarlo e riavviarlo; assemblaggio completo",
   "Manutenzione ordinaria e preventiva; pulizia; tuning di base",
   "Diagnosi guasti (troubleshooting) di base: metodo e fasi",
   "Informazioni di base sulle reti",
 ]),
 ("Competenza 14 — Operare in sicurezza e nel rispetto delle norme di igiene e di salvaguardia ambientale (I Anno)",[
   "Concetti di rischio e danno; prevenzione e protezione; organizzazione della prevenzione aziendale; rischio infortuni",
   "Rischi meccanici, elettrici e fisici (vibrazioni, rumore, radiazioni); microclima, illuminazione, videoterminali, ergonomia",
   "DPI; movimentazione manuale dei carichi e delle merci; segnaletica ed emergenza",
   "Rischio incendi e procedure di esodo; primo soccorso; procedure di sicurezza in base al profilo di rischio",
 ]),
 ("Competenza 15 — Installare, configurare e utilizzare supporti informatici hardware e software (I Anno)",[
   "Installazione del sistema operativo (Windows) da zero; strumenti di base; creazione delle utenze/account e prima configurazione",
   "Windows: desktop, gestione di file e cartelle",
   "Google Drive (cartelle, sottocartelle, condivisione); Google Takeout (scaricare i propri dati)",
   "Google Documenti: formattazione, stili, impostazione pagina, tabella, sommario",
   "Google Fogli: formule (SOMMA, MEDIA, MIN, MAX, SE, CONTA.SE), formattazione condizionale, grafici",
   "Google Presentazioni (modelli, immagini, video); Google Moduli (sondaggi e form)",
   "Diagrammi di flusso (flowchart)",
   "Logica e algoritmi: strutture di controllo; coding a blocchi (code.org); condizioni SE/ALLORA (introduzione)",
   "Configuratore PC: scelta dei componenti a budget e documentazione; Case, RAM, VGA; Motherboard (slot e socket); Hard Disk",
   "Cookies (tecnici, di sessione, persistenti, statistici, di profilazione); video",
   "Grafica: Canva (logo, locandina); inserimento immagini; grafici in Fogli",
   "Il Web: come funziona; introduzione; Progetto \"Il Mio Negozio Online\" (vetrina web, database, ordini via email, cenni SQL)",
 ]),
 ("Competenza 16 — Eseguire la manutenzione ordinaria e straordinaria di sistemi, reti, dispositivi e terminali (I Anno)",[
   "Componenti PC (memorie di massa e cavi); glossario di rete",
   "Reti LAN e WLAN; pacchetti; velocita 2.4/5 GHz; cavo e Speed Test",
   "Cablaggio RJ45 (standard T568B), crimpatura, piccola LAN, test e ping",
   "Apparecchi: modem, router, switch, hub, powerline, range extender, VoIP",
   "Indirizzamento: IP, MAC address, DHCP, DNS, gateway; dal dominio all'IP; pacchetti; GPS",
   "Stampanti laser e a getto d'inchiostro; scheda di ritiro PC",
 ]),
]
write_class("allegato-a-classe-1.md","Classe 1 (nuovo PFP, I annualita 2026/27)", C1,
            "La prima e un nuovo PFP: struttura del PFP1, argomenti dal programma ampliato del corso.")
print("OK")
