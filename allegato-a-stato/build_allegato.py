# -*- coding: utf-8 -*-
import re, html
ROOT="/home/user/corso-godot"
mie=open(f"{ROOT}/MIE-PARTI-ALLEGATO-A.md",encoding="utf-8").read().split("\n")

# --- parse MIE-PARTI per classi 2,3,4 ---
classi={}  # nome classe -> list of (comp_heading, [argomenti])
cur_class=None; cur_comp=None
for ln in mie:
    s=ln.rstrip()
    if s.startswith("## Classe "):
        # chiave: "Classe N"
        m=re.match(r"## (Classe \d)", s)
        cur_class=m.group(1) if m else s[3:]
        classi.setdefault(cur_class, [])
        cur_comp=None
        continue
    if s.startswith("### Competenza"):
        title=s[4:].strip()
        cur_comp=(title, [])
        if cur_class: classi[cur_class].append(cur_comp)
        continue
    if not s or s.startswith(">") or s.startswith("*") or s.startswith("#"):
        continue
    if cur_class and cur_comp is not None:
        cur_comp[1].append(s.strip())

def comp_short(t):
    # "Competenza 8. Utilizzare... — I Anno" -> "Competenza 8 — <anno>"
    m=re.match(r"Competenza\s+(\d+)\.\s*(.*?)\s+—\s+(.*)$", t)
    if m:
        num,desc,anno=m.group(1),m.group(2),m.group(3)
        desc=desc.strip()
        return f"Competenza {num} — {desc} ({anno})"
    return t

def esc(x): return html.escape(x)

def rows_da_fare(args):
    out=[]
    for a in args:
        out.append(f'<tr class="d"><td class="st">DA FARE</td><td>{esc(a)}</td></tr>')
    return "\n".join(out)

def class_block(nome, comps):
    parts=[f'<h2>{esc(nome)} (2026/27)</h2>']
    for (title,args) in comps:
        if not args: continue
        parts.append(f'<h3>{esc(comp_short(title))}</h3>')
        parts.append('<table>'+rows_da_fare(args)+'</table>')
    return "\n".join(parts)

blocks_234="\n".join(class_block(n, classi[n]) for n in ("Classe 2","Classe 3","Classe 4") if n in classi)

CSS=r"""
  @page { size: A4; margin: 11mm; }
  *{box-sizing:border-box;}
  body{font-family:"Liberation Sans",sans-serif;color:#161616;margin:0;font-size:8.7pt;line-height:1.28;}
  h1{font-size:14.5pt;text-align:center;margin:0 0 2px;}
  .subt{text-align:center;font-size:8.8pt;color:#3a6ea5;margin:0 0 8px;}
  h2{font-size:11.5pt;color:#16324a;background:#eef2f7;border-left:5px solid #3a6ea5;padding:3px 8px;margin:13px 0 4px;}
  h3{font-size:9.5pt;color:#274b73;margin:8px 0 3px;}
  .legend{font-size:8.4pt;margin:0 0 7px;}
  .chip{display:inline-block;padding:1px 8px;border-radius:10px;margin-right:8px;font-weight:bold;}
  .chip.f{background:#e7f5e9;color:#1e5a22;border:1px solid #2e7d33;}
  .chip.d{background:#fbf3c9;color:#7a5c00;border:1px solid #d9b400;}
  table{border-collapse:collapse;width:100%;margin:2px 0 5px;}
  td{border:1px solid #cbc4b6;padding:2px 8px;vertical-align:top;}
  td.st{width:66px;text-align:center;font-weight:bold;font-size:7.6pt;white-space:nowrap;}
  tr.f td{background:#eef8f0;}
  tr.f td.st{background:#d6efd9;color:#1e5a22;}
  tr.d td{background:#fdf8e3;}
  tr.d td.st{background:#fbf0b8;color:#7a5c00;}
  .box{border-left:4px solid #3a6ea5;background:#eaf1f8;padding:6px 10px;border-radius:4px;margin:7px 0;font-size:8.3pt;color:#274b73;}
"""

CLASSE1 = r"""
  <h2>Classe 1 (prima) — a.f. 2026/2027</h2>

  <h3>Competenza 8 — Tecnologie informatiche per la comunicazione e la ricezione di informazioni</h3>
  <table>
    <tr class="f"><td class="st">FATTO</td><td>Presentazione corso &middot; Cosa faremo quest'anno &middot; Norme comuni (regolamento strumenti, servizi digitali e IA)</td></tr>
    <tr class="f"><td class="st">FATTO</td><td>Creazione Area Logica &middot; avvio uso della Suite Google per comunicare</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Che cos'&egrave; l'informatica; uso consapevole della tecnologia</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Memorie di massa e RAM &middot; storia ed evoluzione dei calcolatori (video Jobs)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Introduzione e creazione del Glossario informatico</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Digitalizzazione di immagini e suoni</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>La rete: hardware e software &middot; reti e cittadinanza digitale (LAN/WAN, protocolli, web, privacy, uso consapevole)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Social e comunicazione sulla rete &middot; netiquette &middot; identit&agrave; digitale</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Rischi in rete &middot; malware di base (virus, phishing)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Sicurezza da utente: password robuste, e-mail sospette/phishing, cookie e tracciamento, dati di pagamento (Recupero INVALSI)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Comunicazione formale: Gmail, oggetto, CC/CCN, mail formale</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Intelligenza artificiale: cos'&egrave;, uso consapevole, Gemini e i "Gem" (assistenti)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Ricerca in rete: motori di ricerca, ricerca avanzata, operatori booleani</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Mondo del lavoro: figure professionali dell'informatica &middot; "Bussola del lavoro" &middot; cenni al CV</td></tr>
  </table>

  <h3>Competenza 13 — Manutenzione ordinaria di strumenti, utensili, attrezzature</h3>
  <table>
    <tr class="d"><td class="st">DA FARE</td><td>Le parti fondamentali di un PC</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Hardware e architettura (Von Neumann, CPU, RAM/ROM, memorie di massa, I/O, evoluzione)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Rappresentazione delle informazioni (binario/decimale/esadecimale, ASCII/Unicode, bit e byte, unit&agrave; di misura)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Componenti e loro scelta (case, RAM, scheda video, socket/slot, HDD/SSD)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td><b>Smontare il PC, riassemblarlo e riavviarlo</b> &middot; assemblaggio completo</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Manutenzione ordinaria e preventiva &middot; pulizia &middot; tuning di base</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Diagnosi guasti (troubleshooting) di base: metodo e fasi</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Informazioni di base sulle reti</td></tr>
  </table>

  <h3>Competenza 15 — Installare, configurare e utilizzare supporti hardware e software</h3>
  <table>
    <tr class="f"><td class="st">FATTO</td><td>Windows (accesso e uso di base) &middot; Strumenti Google (avvio) &middot; Accesso a Classroom &middot; Document e Classroom (esercizio "Io e la mia famiglia" + consegna)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td><b>Installazione del sistema operativo (Windows) da zero</b> &middot; strumenti di base &middot; <b>creazione delle utenze/account</b> e prima configurazione</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Windows: desktop, gestione file e cartelle</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Google Drive (cartelle, condivisione) &middot; Google Takeout (scaricare i propri dati)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Google Documenti: formattazione, stili, impostazione pagina, tabella, sommario</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Google Fogli: formule (SOMMA, MEDIA, MIN, MAX, SE, CONTA.SE), formattazione condizionale, grafici</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Google Presentazioni (modelli, immagini, video) &middot; Google Moduli (sondaggi/form)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Diagrammi di flusso (flowchart)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Logica e algoritmi: strutture di controllo &middot; coding a blocchi (code.org) &middot; condizioni SE/ALLORA (intro)</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Configuratore PC: scelta componenti a budget, documentazione &middot; Case, RAM, VGA &middot; Motherboard (slot/socket) &middot; Hard Disk</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Cookies (tecnici, di sessione, persistenti, statistici, di profilazione) &middot; video</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Grafica: Canva (logo, locandina) &middot; inserimento immagini &middot; grafici in Fogli</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Il Web: come funziona &middot; introduzione &middot; Progetto "Il Mio Negozio Online" (vetrina web, database, ordini via email, cenni SQL)</td></tr>
  </table>

  <h3>Competenza 16 — Manutenzione ordinaria e straordinaria di sistemi, reti, dispositivi e terminali</h3>
  <table>
    <tr class="d"><td class="st">DA FARE</td><td>Componenti PC (memoria di massa e cavi) &middot; glossario di rete</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Reti LAN/WLAN &middot; pacchetti &middot; velocit&agrave; 2.4/5 GHz &middot; cavo e Speed Test</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Cablaggio RJ45 (standard T568B), crimpatura, piccola LAN, test e ping</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Apparecchi: modem, router, switch, hub, powerline, range extender, VoIP</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Indirizzamento: IP, MAC address, DHCP, DNS, gateway &middot; dal dominio all'IP &middot; pacchetti, GPS</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Stampanti laser e getto d'inchiostro &middot; scheda di ritiro PC</td></tr>
  </table>

  <h3>Competenza 14 — Operare in sicurezza (igiene e salvaguardia ambientale)</h3>
  <div class="box">Modulo trasversale di Sicurezza sul lavoro: tutte le voci DA FARE, distribuite nell'anno.</div>
  <table>
    <tr class="d"><td class="st">DA FARE</td><td>Concetti di rischio e danno &middot; prevenzione e protezione &middot; organizzazione della prevenzione aziendale &middot; rischio infortuni</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Rischi meccanici, elettrici, fisici (vibrazioni, rumore, radiazioni) &middot; microclima, illuminazione, videoterminali, ergonomia</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>DPI &middot; movimentazione manuale di carichi e merci &middot; segnaletica ed emergenza</td></tr>
    <tr class="d"><td class="st">DA FARE</td><td>Rischio incendi e procedure di esodo &middot; primo soccorso &middot; procedure per profilo di rischio</td></tr>
  </table>
"""

doc=f"""<!DOCTYPE html>
<html lang="it"><head><meta charset="utf-8"/><style>{CSS}</style></head><body>
  <h1>Allegato A — Stato del programma (fatto / da fare)</h1>
  <div class="subt">a.f. 2026/2027 &middot; prof. Nicola Regge &middot; Versione 0.3</div>
  <div class="legend"><span class="chip f">FATTO</span> parte gi&agrave; svolta &nbsp;&nbsp; <span class="chip d">DA FARE</span> parte non ancora svolta (in giallo)</div>
  <div class="box"><b>Programma dichiarato ampio:</b> elenchiamo tutto ci&ograve; che potremmo fare; il non svolto resta in giallo. La <b>Classe 1</b> &egrave; costruita sul programma del I anno con i materiali del corso. Le <b>Classi 2, 3, 4</b> riprendono le parti reali dell'Allegato A (MIE-PARTI): ora tutte DA FARE, si marca il fatto man mano.</div>
  <div class="box"><b>Nota mappatura:</b> la corrispondenza classe&harr;anno per 2/3/4 segue MIE-PARTI (PFP1&rarr;2a, PFP2&rarr;3a, PFP3/PFP4&rarr;4a) ed &egrave; <b>da confermare</b>. In prima e seconda &egrave; presente la parte di <b>assemblaggio PC</b> (smontare/riassemblare) e <b>installazione del sistema operativo con creazione delle utenze</b>.</div>
  {CLASSE1}
  {blocks_234}
  <div class="box"><b>Prossimi passi:</b> confermare le marcature FATTO e la mappatura; ogni parte svolta passa da giallo a verde e la data si registra in ARGOMENTI-SVOLTI-2026-27.</div>
</body></html>"""

open(f"{ROOT}/allegato-a-stato/allegato-a-stato.html","w",encoding="utf-8").write(doc)
print("classi trovate:", {k:len(v) for k,v in classi.items()})
print("scritto allegato-a-stato.html", len(doc),"byte")
