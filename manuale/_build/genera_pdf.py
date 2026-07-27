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

# ---------------------------------------------------------------------------
# Documenti che sappiamo impaginare. Si sceglie da riga di comando:
#   python3 genera_pdf.py manuale      (default)
#   python3 genera_pdf.py eserciziario
# ---------------------------------------------------------------------------
COVER_SUBTITLE = "Corso di Godot"
COVER_AUTHOR = "Corso a cura del prof. Nicola Regge"

DOCS = {
    "manuale": {"src": "manuale.md", "title": "Il Manuale", "emoji": "🎮"},
    "eserciziario": {"src": "eserciziario.md", "title": "L'Eserciziario", "emoji": "🎯"},
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

    # Toglie il Changelog dal libro dei ragazzi (crea confusione). Resta nel
    # sorgente .md per tenere lo storico delle versioni, ma non finisce nel PDF.
    body_md = re.split(r"\n#{1,6}\s+Changelog\b", body_md, maxsplit=1)[0]
    body_md = re.sub(r"\n-{3,}\s*$", "", body_md).rstrip()

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
        # normalizza percorso relativo a manuale/
        p = (MANUALE_DIR / src).resolve()
        if not p.exists():
            # prova nella cartella immagini
            p = (IMG_DIR / Path(src).name).resolve()
        if p.exists():
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
        # Immagine non ancora fornita da Nicola: segnaposto pulito (non rotto),
        # così si vede DOVE va lo screenshot e con quale nome file.
        alt_txt = html.unescape(alt) if alt else ""
        return ('<div class="imgph"><span class="imgph-t">Screenshot da inserire</span>'
                + (f'<br>{html.escape(alt_txt)}' if alt_txt else "")
                + f'<br><span class="imgph-f">{html.escape(src)}</span></div>')

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

    # La lettera di apertura (la si riconosce dalla firma) va resa "a mano":
    # avvolgiamo tutto ciò che sta prima del primo <hr> in un blocco .lettera.
    mhr = re.search(r"<hr\s*/?>", body_html)
    if mhr and 'class="firma"' in body_html[: mhr.start()]:
        body_html = ('<div class="lettera">' + body_html[: mhr.start()]
                     + "</div>" + body_html[mhr.start():])

    # Toglie la lineetta orizzontale (---) subito prima di un'apertura di
    # capitolo: da sola può scivolare su una pagina nuova e lasciarla vuota.
    body_html = re.sub(r'<hr\s*/?>\s*(?=<div class="chapter")', "", body_html)

    body_html = typographic_fixes(body_html)
    return body_html


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
            kicker = mm.group(1)
            title = mm.group(2)
            return (
                '<div class="chapter">'
                f'<div class="kicker">{kicker}</div>'
                f'<h2{attrs} class="ctitle">{title}</h2>'
                f'{sub_html}'
                "</div>"
            )
        return (
            '<div class="chapter">'
            f'<h2{attrs} class="ctitle">{inner}</h2>'
            f'{sub_html}'
            "</div>"
        )

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
  --serif: Georgia, "Times New Roman", "Liberation Serif", "DejaVu Serif", serif;
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
  position: relative;
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
  position: absolute;
  bottom: 22mm;
  left: 0;
  right: 0;
  color: var(--muted);
  font-size: 11pt;
  letter-spacing: 0.5px;
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

/* Lettera scritta "a mano" (l'introduzione personale del docente) */
/* I titoli restano nel carattere "vecchio" (serif, come gli altri capitoli);
   solo il CORPO della lettera è scritto a mano. */
.lettera p {
  font-family: "Mano", cursive;
  font-size: 15pt;
  line-height: 1.4;
  margin: 0 0 8px;
  text-align: left;
  hyphens: none;
  -webkit-hyphens: none;
  color: #1c3350;
}
.lettera strong { font-weight: 700; color: #10202f; }

/* Firma "a penna" in calce a una lettera/pagina personale */
.firma {
  text-align: right;
  font-family: "Firma", cursive;
  font-size: 34pt;
  line-height: 1;
  color: #1b3a63;
  margin: 4px 14px 0 0;
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

/* Segnaposto per uno screenshot non ancora fornito */
.imgph {
  margin: 18px 0;
  padding: 26px 16px;
  border: 1.5px dashed var(--line);
  border-radius: 6px;
  background: #faf8f3;
  text-align: center;
  color: var(--muted);
  font-size: 10.5pt;
  page-break-inside: avoid;
}
.imgph .imgph-t { font-weight: 700; letter-spacing: 0.5px; text-transform: uppercase; font-size: 9pt; }
.imgph .imgph-f { font-family: "Consolas", monospace; font-size: 9pt; color: var(--godot-blue-dark); }

hr {
  border: none;
  border-top: 1px solid var(--line);
  margin: 24px 0;
}

ul, ol { margin: 0 0 12px; padding-left: 24px; text-align: left; }
li { margin: 4px 0; }

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


def main():
    key = sys.argv[1] if len(sys.argv) > 1 else "manuale"
    if key not in DOCS:
        raise SystemExit(
            f"Documento sconosciuto: {key!r}. Scegli tra: {', '.join(DOCS)}"
        )
    cfg = DOCS[key]
    src_md = MANUALE_DIR / cfg["src"]
    out_html = BUILD_DIR / f"{key}.html"

    md_text = src_md.read_text(encoding="utf-8")
    version, date = read_version_and_date(md_text)
    body_html = build_body_html(md_text)

    logo_uri = data_uri(IMG_DIR / "logo_vertical_monochrome_light.png")

    # Font di scrittura a mano, incorporati nel PDF (base64), così valgono offline:
    #  - "Firma" (Sacramento): elegante, per la firma.
    #  - "Mano" (Caveat): leggibile, per una lettera scritta a mano.
    font_face = ""
    firma_font = BUILD_DIR / "fonts" / "Sacramento-Regular.ttf"
    if firma_font.exists():
        font_face += ('@font-face { font-family: "Firma"; font-style: normal; '
                      'font-weight: 400; src: url("' + data_uri(firma_font)
                      + '") format("truetype"); }\n')
    mano_font = BUILD_DIR / "fonts" / "Caveat.ttf"
    if mano_font.exists():
        font_face += ('@font-face { font-family: "Mano"; font-style: normal; '
                      'font-weight: 400 700; src: url("' + data_uri(mano_font)
                      + '") format("truetype"); }\n')

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
<style>{font_face}
{CSS}</style>
</head>
<body>
  <section class="cover">
    <img class="logo" src="{logo_uri}" alt="Logo Godot"/>
    <div class="title">{html.escape(cfg['title'])}</div>
    <div class="rule-cover"></div>
    <div class="subtitle">{html.escape(COVER_SUBTITLE)}</div>
    <div class="author">{html.escape(COVER_AUTHOR)}</div>
  </section>
  <main>
    {body_html}
  </main>
</body>
</html>"""

    out_html.write_text(doc, encoding="utf-8")
    print(f"HTML scritto: {out_html}  ({len(doc)} byte)")

    # Nome del PDF consegnabile: SEMPRE con il numero di versione, mai due uguali.
    # Es. "manuale" v0.2 -> manuale-v0.2.pdf   (regola nel CLAUDE.md).
    slug = (version or "0.0").strip().replace(" ", "")
    pdf_name = f"{key}-v{slug}.pdf"
    footer_mid = f"Versione {version}" if version else ""
    (BUILD_DIR / ".build.json").write_text(
        json.dumps({"html": out_html.name, "pdf": pdf_name,
                    "footerLeft": COVER_SUBTITLE, "footerMid": footer_mid}),
        encoding="utf-8",
    )
    print(f"Nome PDF consegnabile: {pdf_name}")


if __name__ == "__main__":
    main()
