#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Genera l'HTML impaginato del libro di testo (manuale.md) con copertina,
immagini incorporate e stile "libro". L'HTML prodotto viene poi convertito
in PDF con Chromium (vedi genera_pdf.js).

Uso:
    python3 genera_pdf.py

Produce: _build/manuale.html  (self-contained, immagini in base64)
"""

import base64
import html
import json
import mimetypes
import re
import sys
from pathlib import Path

import markdown

# ---------------------------------------------------------------------------
# Percorsi
# ---------------------------------------------------------------------------
BUILD_DIR = Path(__file__).resolve().parent
MANUALE_DIR = BUILD_DIR.parent
IMG_DIR = MANUALE_DIR / "immagini"
# Cartella del documento in lavorazione: le immagini 'immagini/...' si cercano
# PRIMA qui (accanto al .md), così ogni documento tiene le sue immagini nella
# propria sottocartella. main() la imposta al genitore del sorgente.
DOC_DIR = MANUALE_DIR

# ---------------------------------------------------------------------------
# Documenti che sappiamo impaginare. Si sceglie da riga di comando:
#   python3 genera_pdf.py manuale      (default)
#   python3 genera_pdf.py eserciziario
# ---------------------------------------------------------------------------
COVER_SUBTITLE = "Corso di Informatica — Classe 1"
COVER_AUTHOR = "Corso a cura del prof. Nicola Regge"

# I documenti del corso Classe 1. 'src' è relativo alla cartella classe-1/.
# Il PDF viene salvato ACCANTO al suo file .md, con la versione nel nome.
DOCS = {
    "corso-informatica": {"src": "../CORSO-INFORMATICA.md",      "title": "Corso Informatica"},
    "stato-corso":  {"src": "../00-STATO-DEL-CORSO.md",         "title": "Stato del Corso"},
    "glossario":    {"src": "../01-GLOSSARIO.md",                "title": "Glossario"},
    "regole-formattazione": {"src": "../REGOLE-FORMATTAZIONE.md", "title": "Regole di Formattazione"},
    "struttura":    {"src": "../STRUTTURA-REPOSITORY.md",         "title": "Struttura del Repository"},
    "mappa-argomenti": {"src": "../MAPPA-ARGOMENTI.md",           "title": "Mappa degli Argomenti — Macro-aree"},
    "griglia-argomenti": {"src": "../GRIGLIA-ARGOMENTI.md",       "title": "Griglia degli Argomenti — scelta per anno"},
    "piano-ore":    {"src": "../PIANO-ORE-LEZIONE.md",            "title": "Piano delle Ore di Lezione — guida giorno per giorno"},
    "git-allievi":  {"src": "../ORGANIZZAZIONE-GIT-ALLIEVI.md",   "title": "Organizzazione Git per gli Allievi"},
    "regole-lab":   {"src": "../REGOLE-LABORATORIO.md",           "title": "Regole del Laboratorio di Informatica"},
    "programmi-ufficiali": {"src": "../programmi-ufficiali/README.md", "title": "Programmi Ufficiali (Allegato A) — nota"},
    "ruoli-classe": {"src": "../RUOLI-CLASSE.md",                     "title": "Ruoli della Classe"},
    "promemoria":   {"src": "../PROMEMORIA-NICOLA.md",                "title": "Promemoria — Cose da Fare (Nicola)"},
    "argomenti-svolti": {"src": "../ARGOMENTI-SVOLTI.md",             "title": "Argomenti Svolti (anno precedente 2025/26)"},
    "mie-parti":    {"src": "../MIE-PARTI-ALLEGATO-A.md",             "title": "Le Mie Parti nell'Allegato A"},
    "preventivo":   {"src": "../PROGRAMMA-PREVENTIVO-2026-27.md",     "title": "Programma Preventivo 2026/27 (per competenza)"},
    "guida-negozio": {"src": "negozio-online/GUIDA-RAGAZZI.md", "title": "Il Mio Negozio Online"},
    "piano-lezione": {"src": "negozio-online/PIANO-LEZIONE.md", "title": "Piano-lezione: Il Mio Negozio Online"},
    "materiale":     {"src": "MATERIALE-PRONTO.md",             "title": "Materiale del Corso — Classe 1"},
    "programma":     {"src": "programma.md",                    "title": "Programma del Corso"},
    "programma-2":   {"src": "../classe-2/programma.md",        "title": "Programma del Corso — Classe 2"},
    "programma-3":   {"src": "../classe-3/programma.md",        "title": "Programma del Corso — Classe 3"},
    "reti-teoria":   {"src": "../classe-3/reti-teoria.md",      "title": "Le Reti di Computer — Teoria"},
    "cablaggio-rj45": {"src": "../classe-3/esercizi/01-cablaggio-rj45.md", "title": "Cablaggio RJ45 — Scheda pratica"},
    "programma-4":   {"src": "../classe-4/programma.md",        "title": "Programma del Corso — Classe 4"},
    "bussola":       {"src": "bussola-mondo-del-lavoro.md",     "title": "La Bussola del Lavoro"},
    "da-far-fare":   {"src": "da-far-fare-assolutamente.md",    "title": "Da Far Fare Assolutamente"},
    "configuratore": {"src": "scheda-configuratore-pc.md",      "title": "Scheda Configuratore PC"},
}


def data_uri(path: Path) -> str:
    """Ritorna un data: URI base64 per incorporare un'immagine nell'HTML."""
    mime, _ = mimetypes.guess_type(str(path))
    mime = mime or "application/octet-stream"
    b64 = base64.b64encode(path.read_bytes()).decode("ascii")
    return f"data:{mime};base64,{b64}"


def read_version_and_date(md_text: str):
    """Estrae 'Versione X' e la data dalla riga tipo '**Versione 0.1** — 26/07/2026'."""
    version = ""
    date = ""
    m = re.search(r"\*\*Versione\s+([^\*]+)\*\*\s*[—-]\s*([0-9/]+)", md_text)
    if m:
        version = m.group(1).strip()
        date = m.group(2).strip()
    return version, date


# ---------------------------------------------------------------------------
# Evidenziatore GDScript minimale (senza dipendenze esterne)
# ---------------------------------------------------------------------------
GD_KEYWORDS = {
    "func", "var", "const", "if", "elif", "else", "for", "while", "return",
    "and", "or", "not", "in", "is", "as", "pass", "break", "continue",
    "class", "extends", "signal", "enum", "match", "true", "false", "null",
    "self", "await", "yield", "export", "onready", "static", "void",
    # JavaScript
    "let", "function", "async", "import", "new", "try", "catch", "throw",
    "typeof", "of", "do", "switch", "case", "default",
    # SQL
    "select", "insert", "into", "update", "delete", "from", "where",
    "create", "table", "alter", "policy", "values", "primary", "key",
    "using", "on", "generated", "always", "identity", "text", "numeric",
    "bigint", "row", "level", "security", "enable", "references",
}


# Un token alla volta: commento, stringa, numero, identificatore, oppure "altro".
# Scansione unica → nessun rischio di ri-elaborare l'HTML già inserito.
_GD_TOKEN = re.compile(r"""
      (?P<com>\#[^\n]*)                 # commento fino a fine riga
    | (?P<str>"(?:\\.|[^"\\])*"         # stringa con doppi apici
             |'(?:\\.|[^'\\])*')        # stringa con apici singoli
    | (?P<num>\b\d+\.?\d*\b)            # numero
    | (?P<name>[A-Za-z_]\w*)            # identificatore / parola chiave
    | (?P<other>[\s\S])                # qualsiasi altro carattere (newline incluso)
""", re.VERBOSE)


def highlight_gdscript(code: str) -> str:
    """Colora commenti, stringhe, numeri e parole chiave GDScript in HTML.

    Tokenizzazione a passo singolo: ogni pezzo di testo viene classificato,
    poi escapato e (se serve) avvolto in uno <span>. Così non si rischia mai
    di ri-processare i tag HTML inseriti (es. l'attributo class).
    """
    out = []
    for m in _GD_TOKEN.finditer(code):
        kind = m.lastgroup
        text = m.group()
        esc = html.escape(text)
        if kind == "com":
            out.append(f'<span class="com">{esc}</span>')
        elif kind == "str":
            out.append(f'<span class="str">{esc}</span>')
        elif kind == "num":
            out.append(f'<span class="num">{esc}</span>')
        elif kind == "name" and text in GD_KEYWORDS:
            out.append(f'<span class="kw">{esc}</span>')
        else:
            out.append(esc)
    return "".join(out)


# ---------------------------------------------------------------------------
# Conversione Markdown -> HTML del corpo
# ---------------------------------------------------------------------------
_LIST_ITEM = re.compile(r"^\s*([-*+]|\d+\.)\s+\S")


def normalize_lists(md_text: str) -> str:
    """Inserisce una riga vuota prima di un elenco che segue subito del testo.

    Nel sorgente alcuni elenchi seguono direttamente una riga di testo (GitHub
    li rende comunque come lista, python-markdown no). Qui li normalizziamo,
    ignorando i blocchi di codice ``` ``` per non toccare il codice.
    """
    lines = md_text.split("\n")
    out = []
    in_fence = False
    for line in lines:
        stripped = line.lstrip()
        if stripped.startswith("```"):
            in_fence = not in_fence
            out.append(line)
            continue
        if not in_fence and _LIST_ITEM.match(line):
            prev = out[-1] if out else ""
            if prev.strip() and not _LIST_ITEM.match(prev):
                out.append("")  # riga vuota che "apre" l'elenco
        out.append(line)
    return "\n".join(out)


def build_body_html(md_text: str) -> str:
    # Rimuove il blocco di testa (titolo + versione + nota fonte) perché
    # va nella copertina, non nel corpo.
    body_md = md_text

    # Toglie la prima riga H1 e le righe di intestazione fino al primo '---'
    lines = body_md.split("\n")
    # trova il primo separatore orizzontale '---' su riga propria
    start = 0
    for i, ln in enumerate(lines):
        if ln.strip() == "---":
            start = i + 1
            break
    body_md = "\n".join(lines[start:]).strip()
    body_md = normalize_lists(body_md)
    body_md = prepare_details(body_md)

    # Niente 'sane_lists': nel sorgente alcuni elenchi seguono subito una riga
    # di testo (senza riga vuota); il parser tollerante li rende come vere liste.
    # 'md_in_html' fa convertire il Markdown DENTRO i blocchi <details> (i livelli
    # di aiuto dell'eserciziario).
    md = markdown.Markdown(
        extensions=["extra", "smarty", "toc", "md_in_html"],
    )
    body_html = md.convert(body_md)

    # Incorpora le immagini come data URI
    def img_repl(m):
        alt = m.group("alt")
        src = m.group("src")
        if src.startswith("data:"):
            # già incorporata (evita ri-elaborazione al secondo passaggio)
            return m.group(0)
        # cerca l'immagine, in ordine: accanto al documento, poi sotto manuale/,
        # infine nella cartella immagini per nome.
        p = None
        for cand in ((DOC_DIR / src), (MANUALE_DIR / src), (IMG_DIR / Path(src).name)):
            cand = cand.resolve()
            if cand.exists():
                p = cand
                break
        if p is not None and p.exists():
            uri = data_uri(p)
            # 'alt' arriva già HTML-escapato da markdown (es. &quot;): prima lo
            # decodifico, poi lo ri-escapo una volta sola, così nella didascalia
            # le virgolette si vedono giuste (niente doppio-escape).
            alt_txt = html.unescape(alt) if alt else ""
            cap = html.escape(alt_txt)
            return (f'<figure class="fig">'
                    f'<img src="{uri}" alt="{cap}"/>'
                    + (f'<figcaption>{cap}</figcaption>' if cap else "")
                    + '</figure>')
        # Immagine non ancora presente: mostro un riquadro-segnaposto con la
        # descrizione e il NOME FILE da usare (così si vede dove va lo screenshot
        # e come chiamarlo). Appena il file arriva, il riquadro diventa la foto.
        fname = html.escape(Path(src).name)
        alt_txt = html.unescape(alt) if alt else ""
        cap = html.escape(alt_txt)
        return (f'<figure class="fig"><div class="ph">'
                f'<div class="ph-tag">📷 Qui va uno screenshot</div>'
                + (f'<div class="ph-desc">{cap}</div>' if cap else "")
                + f'<div class="ph-file">salva la foto come: <code>{fname}</code></div>'
                + '</div></figure>')

    body_html = re.sub(
        r'<img\s+alt="(?P<alt>[^"]*)"\s+src="(?P<src>[^"]+)"\s*/?>',
        img_repl, body_html,
    )
    # variante ordine attributi
    body_html = re.sub(
        r'<img\s+src="(?P<src>[^"]+)"\s+alt="(?P<alt>[^"]*)"\s*/?>',
        img_repl, body_html,
    )

    # Evidenzia i blocchi di codice gdscript
    def code_repl(m):
        code = m.group(1)
        # decodifica entità HTML prodotte da markdown
        code = (code.replace("&amp;", "&").replace("&lt;", "<")
                    .replace("&gt;", ">").replace("&quot;", '"')
                    .replace("&#39;", "'"))
        return f'<pre class="code"><code>{highlight_gdscript(code)}</code></pre>'

    body_html = re.sub(
        r'<pre><code[^>]*>(.*?)</code></pre>',
        code_repl, body_html, flags=re.DOTALL,
    )

    body_html = style_details(body_html)
    body_html = transform_chapter_openers(body_html)

    # Standard di formattazione (doc 00): box colorati semantici + niente emoji
    # + liste sempre numerate e gerarchiche (niente elenchi puntati).
    body_html = transform_boxes(body_html)
    body_html = lists_to_numbered(body_html)
    body_html = strip_emoji(body_html)

    # Toglie la lineetta orizzontale (---) subito prima di un'apertura di
    # capitolo: da sola può scivolare su una pagina nuova e lasciarla vuota.
    body_html = re.sub(r'<hr\s*/?>\s*(?=<div class="chapter")', "", body_html)

    body_html = typographic_fixes(body_html)
    return body_html


# ---------------------------------------------------------------------------
# Standard di formattazione (doc 00)
# ---------------------------------------------------------------------------
# Box colorati semantici: un blockquote che inizia con [ROSSO]/[BLU]/[GIALLO]
# diventa il box della legenda (rosso=disallineamento, blu=da confermare,
# giallo=nota). Sintassi nel sorgente:
#     > [ROSSO] testo del box...
_BOX_TAGS = {
    "ROSSO":  ("box-rosso",  "Disallineamento"),
    "BLU":    ("box-blu",    "Da confermare"),
    "GIALLO": ("box-giallo", "Nota"),
}


def lists_to_numbered(html_str: str) -> str:
    """Converte gli elenchi puntati (<ul>) in numerati (<ol>): lo standard
    (doc 00) vieta i puntati. La numerazione gerarchica (1, 1.1, 1.1.2) la fa
    il CSS con i counter. I blocchi di codice <pre> restano intatti."""
    blocks = []
    def _stash(m):
        blocks.append(m.group(0))
        return f"\x00PRE{len(blocks) - 1}\x00"
    html_str = re.sub(r"<pre.*?</pre>", _stash, html_str, flags=re.DOTALL)

    html_str = re.sub(r"<ul\b[^>]*>", "<ol>", html_str)
    html_str = html_str.replace("</ul>", "</ol>")

    def _restore(m):
        return blocks[int(m.group(1))]
    return re.sub(r"\x00PRE(\d+)\x00", _restore, html_str)


def transform_boxes(html_str: str) -> str:
    def render(cur):
        cls, label, paras = cur
        return (f'<div class="box {cls}"><span class="box-tag">{label}</span>'
                + "".join(paras) + "</div>")

    def repl(m):
        inner = m.group("inner")
        paras = re.findall(r"<p>.*?</p>", inner, re.DOTALL) or [inner]
        out, cur, any_tag = [], None, False
        for p in paras:
            bm = re.match(r'\s*<p>\s*\[(ROSSO|BLU|GIALLO)\]\s*', p, re.IGNORECASE)
            if bm:
                any_tag = True
                if cur:
                    out.append(render(cur))
                cls, label = _BOX_TAGS[bm.group(1).upper()]
                cur = (cls, label, ["<p>" + p[bm.end():]])
            elif cur:
                cur[2].append(p)
            else:
                out.append(p)
        if cur:
            out.append(render(cur))
        return "".join(out) if any_tag else m.group(0)

    return re.sub(r"<blockquote>(?P<inner>.*?)</blockquote>", repl, html_str, flags=re.DOTALL)


# Emoji: quelle "semantiche" diventano un'etichetta testuale; tutte le altre
# (decorative) si tolgono. I blocchi di codice <pre> restano intatti.
_EMOJI_SEMANTIC = {
    "✅": "[OK]", "☑️": "[OK]", "✔️": "[OK]", "✔": "[OK]",
    "⚠️": "[ATTENZIONE]", "⚠": "[ATTENZIONE]", "❗": "[ATTENZIONE]", "❕": "[ATTENZIONE]",
    "❌": "[CRITICO]", "⛔": "[CRITICO]", "🔴": "[CRITICO]", "🚫": "[CRITICO]",
    "ℹ️": "[NOTA]", "ℹ": "[NOTA]",
}
_EMOJI_RE = re.compile(
    "[\U0001F000-\U0001FAFF\U00002600-\U000027BF\U0001F1E6-\U0001F1FF"
    "\U00002190-\U000021FF\U00002B00-\U00002BFF\U00002300-\U000023FF"
    "\U0000FE00-\U0000FE0F\U0000200D\U000020E3\U00002B50\U00002139]+",
    flags=re.UNICODE,
)


def strip_emoji(html_str: str) -> str:
    blocks = []
    def _stash(m):
        blocks.append(m.group(0))
        return f"\x00PRE{len(blocks) - 1}\x00"
    html_str = re.sub(r"<pre.*?</pre>", _stash, html_str, flags=re.DOTALL)

    for em, tag in _EMOJI_SEMANTIC.items():
        html_str = html_str.replace(em, tag)
    html_str = _EMOJI_RE.sub("", html_str)
    # ripulisce eventuali doppi spazi lasciati dalla rimozione
    html_str = re.sub(r"[ \t]{2,}", " ", html_str)

    def _restore(m):
        return blocks[int(m.group(1))]
    return re.sub(r"\x00PRE(\d+)\x00", _restore, html_str)


def typographic_fixes(html_str: str) -> str:
    """Piccoli aggiustamenti tipografici (niente parole "orfane" a fine riga):

    - le frasi tra virgolette (“ ”, « ») non si spezzano più a fine riga;
    - l'ultima parola di un paragrafo/elenco resta attaccata alla precedente,
      così non rimane una parola da sola su una riga.
    I blocchi di codice <pre> restano intatti.
    """
    NB = " "  # spazio insecabile

    # 1) protegge i blocchi di codice
    blocks = []
    def _stash(m):
        blocks.append(m.group(0))
        return f"\x00PRE{len(blocks) - 1}\x00"
    html_str = re.sub(r"<pre.*?</pre>", _stash, html_str, flags=re.DOTALL)

    # 2) niente spezzatura dentro le virgolette
    def _nowrap(m):
        return m.group(0).replace(" ", NB)
    html_str = re.sub(r"“[^”]*”", _nowrap, html_str)
    html_str = re.sub(r"«[^»]*»", _nowrap, html_str)

    # 3) l'ultima parola non resta orfana (unita alla penultima)
    html_str = re.sub(
        r"(\S) (\S+)(\s*</(?:p|li)>)",
        lambda m: f"{m.group(1)}{NB}{m.group(2)}{m.group(3)}",
        html_str,
    )

    # 4) ripristina i blocchi di codice
    def _restore(m):
        return blocks[int(m.group(1))]
    return re.sub(r"\x00PRE(\d+)\x00", _restore, html_str)


def prepare_details(md_text: str) -> str:
    """Prepara i blocchi <details>/<summary> dell'eserciziario (i 4 livelli).

    - li apre nel PDF (attributo `open`);
    - aggiunge `markdown="1"` così il Markdown dentro (liste, codice) viene
      convertito da 'md_in_html'.
    """
    md_text = re.sub(r"<details\s*>", '<details open markdown="1">', md_text)
    md_text = re.sub(r"<summary\s*>", '<summary markdown="1">', md_text)
    return md_text


def style_details(html_str: str) -> str:
    """Dà un colore a ogni livello di aiuto in base al pallino nel titolo.

    🟡 Aiuto = giallo · 🟠 La scena = arancio · 🔴 Codice = rosso.
    """
    def repl(m):
        summ = m.group("summ")
        cls = "lv1"
        if "🟡" in summ:
            cls = "lv2"
        elif "🟠" in summ:
            cls = "lv3"
        elif "🔴" in summ:
            cls = "lv4"
        return f'<details open class="livello {cls}"><summary>{summ}</summary>'

    return re.sub(
        r"<details[^>]*>\s*<summary[^>]*>(?P<summ>.*?)</summary>",
        repl, html_str, flags=re.DOTALL,
    )


def transform_chapter_openers(html_str: str) -> str:
    """Trasforma ogni <h2> in un'apertura di capitolo in stile libro.

    "Capitolo 0 — Cos'è Godot"  ->  occhiello "Capitolo 0" (centrato, piccolo)
    + titolo grande centrato. Gli <h2> senza "Capitolo N" diventano un titolo
    centrato senza occhiello (es. "Changelog del manuale").
    """
    def repl(m):
        attrs = m.group("attrs") or ""
        inner = m.group("inner").strip()
        # Se subito dopo il titolo c'è un paragrafo tutto in corsivo, lo tiriamo
        # dentro l'apertura come SOTTOTITOLO (centrato, più piccolo). Così basta
        # scrivere *testo* sotto il titolo, senza parentesi.
        sub = m.group("sub")
        sub_html = ""
        if sub:
            subm = re.match(r"\s*<p><em>(?P<t>.*?)</em></p>\s*$", sub, flags=re.DOTALL)
            if subm:
                sub_html = f'<div class="csub">{subm.group("t").strip()}</div>'
        # separa "Capitolo N" / "Esercizio N" / "Scheda N" da " — resto del titolo"
        mm = re.match(r"^((?:Capitolo|Scheda|Esercizio)\s+[^\s—–-]+)\s+[—–-]\s+(.+)$", inner)
        if mm:
            # Vero capitolo (manuale/eserciziario): apertura centrata, pagina nuova.
            kicker = mm.group(1)
            title = mm.group(2)
            return (
                '<div class="chapter">'
                f'<div class="kicker">{kicker}</div>'
                f'<h2{attrs} class="ctitle">{title}</h2>'
                f'{sub_html}'
                "</div>"
            )
        # Sezione normale (standard doc 00): titolo a sinistra, scorre nel testo
        # senza iniziare una pagina nuova (meno spazi bianchi).
        sub_out = sub if sub else ""
        return f'<h2{attrs} class="sec">{inner}</h2>{sub_out}'

    return re.sub(
        r"<h2(?P<attrs>[^>]*)>(?P<inner>.*?)</h2>(?P<sub>\s*<p><em>.*?</em></p>)?",
        repl, html_str, flags=re.DOTALL,
    )


CSS = r"""
:root {
  --godot-blue: #3a6ea5;
  --godot-blue-dark: #2b3f57;
  --ink: #201b16;
  --muted: #6a6259;
  --line: #d9d0c2;
  --code-bg: #f5f2ec;
  --tip-bg: #f6f1e6;
  --tip-border: #b8933f;
  --serif: "DejaVu Serif", Georgia, "Liberation Serif", serif;   /* standard doc 00: font unico DejaVu */
}

* { box-sizing: border-box; }

html { font-size: 11.7pt; }

body {
  margin: 0;
  color: var(--ink);
  font-family: var(--serif);
  line-height: 1.62;
  text-align: justify;
  hyphens: auto;
  -webkit-hyphens: auto;
  -webkit-print-color-adjust: exact;
  print-color-adjust: exact;
}

/* ---------- COPERTINA ---------- */
.cover {
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  page-break-after: always;
  background: linear-gradient(170deg, #ffffff 0%, #f3ede1 100%);
}
.cover img.logo {
  width: 190px;
  height: auto;
  margin-bottom: 30px;
}
.cover .title {
  font-family: var(--serif);
  font-size: 50pt;
  font-weight: 700;
  color: var(--ink);
  line-height: 1.05;
  margin: 0;
}
.cover .rule-cover {
  width: 90px;
  height: 2px;
  background: var(--godot-blue);
  margin: 20px 0 18px;
}
.cover .subtitle {
  font-size: 22pt;
  font-weight: 400;
  font-style: italic;
  color: var(--godot-blue);
  margin: 0;
}
.cover .emoji { font-size: 22pt; font-style: normal; }
.cover .meta {
  margin-top: 46px;
  padding: 10px 24px;
  border: 1px solid var(--godot-blue);
  color: var(--godot-blue-dark);
  font-size: 12.5pt;
  letter-spacing: 0.5px;
  background: #fff;
}
.cover .author {
  margin-top: 24px;
  color: var(--muted);
  font-size: 12pt;
  font-style: italic;
}

/* ---------- CONTENUTO ---------- */
main { padding: 0; }

/* ---------- APERTURA DI CAPITOLO (stile libro) ---------- */
.chapter {
  page-break-before: always;
  text-align: center;
  margin: 0 0 30px;
  padding-top: 6mm;
}
main > .chapter:first-child { page-break-before: avoid; }
.chapter .kicker {
  font-family: var(--serif);
  text-transform: uppercase;
  letter-spacing: 4px;
  font-size: 11pt;
  font-weight: 700;
  color: var(--godot-blue);
  margin-bottom: 12px;
}
h2.ctitle {
  font-family: var(--serif);
  font-size: 27pt;
  font-weight: 700;
  line-height: 1.18;
  color: var(--ink);
  margin: 0 auto;
  max-width: 88%;
  page-break-after: avoid;
}
.chapter .csub {
  font-family: var(--serif);
  font-style: italic;
  font-size: 12.5pt;
  color: var(--muted);
  margin: 10px auto 0;
  max-width: 82%;
  line-height: 1.4;
}
.chapter .csub code { font-style: normal; }
.chapter::after {
  content: "";
  display: block;
  width: 64px;
  height: 3px;
  background: var(--godot-blue);
  margin: 16px auto 0;
}

/* Sezione normale (##) nello standard doc 00: a sinistra, scorre nel testo */
h2.sec {
  font-family: var(--serif);
  font-size: 16.5pt;
  font-weight: 700;
  color: var(--godot-blue-dark);
  text-align: left;
  margin: 24px 0 8px;
  padding-bottom: 3px;
  border-bottom: 2px solid var(--godot-blue);
  page-break-after: avoid;
}

/* sottotitoli di sezione dentro il capitolo */
h3 {
  font-family: var(--serif);
  font-size: 15.5pt;
  font-weight: 700;
  font-style: italic;
  color: var(--godot-blue-dark);
  text-align: left;
  margin: 26px 0 8px;
  page-break-after: avoid;
}
h4 {
  font-size: 12.5pt;
  text-align: left;
  margin: 18px 0 6px;
  page-break-after: avoid;
}

p { margin: 0 0 11px; }

a { color: var(--godot-blue); text-decoration: none; }

strong { color: #16324a; }

code {
  font-family: "SFMono-Regular", "Consolas", "Liberation Mono", Menlo, monospace;
  font-size: 0.85em;
  background: var(--code-bg);
  padding: 1px 5px;
  border-radius: 3px;
  border: 1px solid var(--line);
}

/* Codice: NERO SU BIANCO (fondo chiaro) — pensato per la STAMPA: niente
   blocchi scuri che sprecano toner. Colori di sintassi scuri, ben leggibili. */
pre.code {
  background: #faf8f3;
  color: #1c1712;
  padding: 14px 16px;
  border-radius: 6px;
  white-space: pre-wrap;       /* manda a capo le righe lunghe: niente testo tagliato */
  overflow-wrap: anywhere;
  font-size: 9pt;
  line-height: 1.5;
  text-align: left;
  margin: 14px 0 16px;
  border: 1px solid var(--line);
}
pre.code code {
  background: none;
  border: none;
  padding: 0;
  color: inherit;
  font-size: inherit;
}
pre.code .kw  { color: #9a3b0c; font-weight: 700; }
pre.code .str { color: #276b2a; }
pre.code .num { color: #6a34a8; }
pre.code .com { color: #8a7f6f; font-style: italic; }

/* ---------- TABELLE ---------- */
table {
  border-collapse: collapse;
  width: 100%;
  margin: 14px 0 20px;
  font-size: 10pt;
  text-align: left;
  page-break-inside: avoid;
}
th, td {
  border: 1px solid var(--line);
  padding: 7px 11px;
  text-align: left;
  vertical-align: top;
}
th {
  background: var(--godot-blue);
  color: #fff;
  font-weight: 700;
}
tr:nth-child(even) td { background: #f7f4ee; }

/* ---------- CITAZIONI / SUGGERIMENTI ---------- */
blockquote {
  margin: 16px 0;
  padding: 12px 18px;
  background: var(--tip-bg);
  border-left: 4px solid var(--tip-border);
  color: #3a342b;
  font-style: italic;
  text-align: left;
  page-break-inside: avoid;
}
blockquote p { margin: 0; }
blockquote p + p { margin-top: 8px; }

/* ---------- BOX COLORATI SEMANTICI (standard doc 00, punto 8) ---------- */
.box {
  margin: 16px 0;
  padding: 12px 16px;
  border-left: 5px solid;
  border-radius: 4px;
  text-align: left;
  page-break-inside: avoid;
}
.box p { margin: 0; }
.box p + p { margin-top: 8px; }
.box .box-tag {
  display: block;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 1px;
  font-size: 9pt;
  margin-bottom: 5px;
}
.box-rosso  { background: #fdecea; border-color: #c0392b; }
.box-rosso  .box-tag { color: #a4271b; }
.box-blu    { background: #eaf1f8; border-color: #3a6ea5; }
.box-blu    .box-tag { color: #274b73; }
.box-giallo { background: #fbf3e2; border-color: #b8933f; }
.box-giallo .box-tag { color: #8a6d1f; }

/* ---------- IMMAGINI ---------- */
figure.fig {
  margin: 20px 0;
  text-align: center;
  page-break-inside: avoid;
}
figure.fig img {
  max-width: 100%;
  height: auto;
  border: 1px solid var(--line);
  box-shadow: 0 3px 12px rgba(0,0,0,0.10);
}
figure.fig figcaption {
  margin-top: 9px;
  font-size: 9.5pt;
  color: var(--muted);
  font-style: italic;
  text-align: center;
}

/* Segnaposto per uno screenshot non ancora inserito */
figure.fig .ph {
  border: 2px dashed #b9a97f;
  background: #fbf7ee;
  border-radius: 8px;
  padding: 20px 16px;
  text-align: center;
}
figure.fig .ph-tag {
  font-weight: 700;
  color: #8a6d1f;
  font-size: 11pt;
}
figure.fig .ph-desc {
  color: #5a5147;
  font-size: 10pt;
  font-style: italic;
  margin-top: 6px;
}
figure.fig .ph-file {
  margin-top: 8px;
  font-size: 9.5pt;
  color: #6a6259;
}

hr {
  border: none;
  border-top: 1px solid var(--line);
  margin: 24px 0;
}

/* Liste: numerate e gerarchiche (1, 1.1, 1.1.2) via counter — standard doc 00 */
ol {
  list-style: none;
  counter-reset: item;
  margin: 0 0 12px;
  padding-left: 2.2em;
  text-align: left;
}
ol > li {
  counter-increment: item;
  margin: 4px 0;
}
ol > li::before {
  content: counters(item, ".") ". ";
  font-weight: 700;
  color: var(--godot-blue-dark);
}
ul { list-style: disc; margin: 0 0 12px; padding-left: 24px; text-align: left; }
ul li { margin: 4px 0; }

/* ---------- LIVELLI DI AIUTO (i 4 livelli dell'eserciziario) ---------- */
/* Nel PDF sono mostrati APERTI; il colore del bordo segue il pallino. */
details.livello {
  border: 1px solid var(--line);
  border-left: 5px solid var(--line);
  border-radius: 5px;
  margin: 14px 0;
  padding: 0 16px 8px;
  background: #fcfaf5;
  text-align: left;
}
details.livello > summary {
  list-style: none;
  font-family: var(--serif);
  font-weight: 700;
  font-size: 12.5pt;
  padding: 9px 16px;
  margin: 0 -16px 10px;
  border-bottom: 1px solid var(--line);
  background: #f0ebe0;
  page-break-after: avoid;
}
details.livello > summary::-webkit-details-marker { display: none; }
details.livello > summary::marker { content: ""; }
details.lv2 { border-left-color: #d9a400; }
details.lv2 > summary { background: #fbf1cd; }
details.lv3 { border-left-color: #de7a1a; }
details.lv3 > summary { background: #fbe3cc; }
details.lv4 { border-left-color: #d23b3b; }
details.lv4 > summary { background: #f7dada; }
"""


def find_logo():
    """Logo di copertina, SOLO se c'è un logo del corso di Informatica in
    classe-1/immagini/. Niente ripiego sul logo di Godot: è un altro corso."""
    p = IMG_DIR / "logo_corso.png"
    return data_uri(p) if p.exists() else ""


def main():
    if len(sys.argv) < 2 or sys.argv[1] not in DOCS:
        raise SystemExit(
            f"Uso: python3 genera_pdf.py <documento>\nScegli tra: {', '.join(DOCS)}"
        )
    key = sys.argv[1]
    cfg = DOCS[key]
    src_md = (MANUALE_DIR / cfg["src"]).resolve()
    out_html = BUILD_DIR / f"{key}.html"

    global DOC_DIR
    DOC_DIR = src_md.parent  # le immagini si cercano accanto al documento

    md_text = src_md.read_text(encoding="utf-8")
    version, date = read_version_and_date(md_text)
    body_html = build_body_html(md_text)

    logo_uri = find_logo()
    logo_html = f'<img class="logo" src="{logo_uri}" alt="Logo"/>' if logo_uri else ""

    meta_line = ""
    if version or date:
        parts = []
        if version:
            parts.append(f"Versione {version}")
        if date:
            parts.append(date)
        meta_line = " · ".join(parts)

    doc = f"""<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="utf-8"/>
<title>{html.escape(cfg['title'])} — {html.escape(COVER_SUBTITLE)}</title>
<style>{CSS}</style>
</head>
<body>
  <section class="cover">
    {logo_html}
    <div class="title">{html.escape(cfg['title'])}</div>
    <div class="rule-cover"></div>
    <div class="subtitle">{html.escape(COVER_SUBTITLE)}</div>
    <div class="meta">{html.escape(meta_line)}</div>
    <div class="author">{html.escape(COVER_AUTHOR)}</div>
  </section>
  <main>
    {body_html}
  </main>
</body>
</html>"""

    out_html.write_text(doc, encoding="utf-8")
    print(f"HTML scritto: {out_html}  ({len(doc)} byte)")

    # Il PDF consegnabile sta ACCANTO al suo .md, con la versione nel nome
    # (regola nel CLAUDE.md): es. programma.md v0.3 -> programma-v0.3.pdf
    slug = (version or "0.0").strip().replace(" ", "")
    pdf_path = src_md.parent / f"{src_md.stem}-v{slug}.pdf"
    (BUILD_DIR / ".build.json").write_text(
        json.dumps({"html": str(out_html), "pdf": str(pdf_path)}), encoding="utf-8"
    )
    print(f"PDF consegnabile: {pdf_path}")


if __name__ == "__main__":
    main()
