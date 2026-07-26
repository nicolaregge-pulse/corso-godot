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
import mimetypes
import re
from pathlib import Path

import markdown

# ---------------------------------------------------------------------------
# Percorsi
# ---------------------------------------------------------------------------
BUILD_DIR = Path(__file__).resolve().parent
MANUALE_DIR = BUILD_DIR.parent
SRC_MD = MANUALE_DIR / "manuale.md"
IMG_DIR = MANUALE_DIR / "immagini"
OUT_HTML = BUILD_DIR / "manuale.html"

# ---------------------------------------------------------------------------
# Metadati copertina (letti/derivati dal manuale)
# ---------------------------------------------------------------------------
COVER_TITLE = "Il Manuale"
COVER_SUBTITLE = "Corso di Godot"
COVER_AUTHOR = "Corso a cura del prof. Nicola Regge"


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
    body_md = normalize_lists(body_md)

    # Niente 'sane_lists': nel sorgente alcuni elenchi seguono subito una riga
    # di testo (senza riga vuota); il parser tollerante li rende come vere liste.
    md = markdown.Markdown(
        extensions=["extra", "smarty", "toc"],
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
            cap = html.escape(alt) if alt else ""
            return (f'<figure class="fig">'
                    f'<img src="{uri}" alt="{html.escape(alt)}"/>'
                    + (f'<figcaption>{cap}</figcaption>' if cap else "")
                    + '</figure>')
        return m.group(0)

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

    body_html = transform_chapter_openers(body_html)

    return body_html


def transform_chapter_openers(html_str: str) -> str:
    """Trasforma ogni <h2> in un'apertura di capitolo in stile libro.

    "Capitolo 0 — Cos'è Godot"  ->  occhiello "Capitolo 0" (centrato, piccolo)
    + titolo grande centrato. Gli <h2> senza "Capitolo N" diventano un titolo
    centrato senza occhiello (es. "Changelog del manuale").
    """
    def repl(m):
        attrs = m.group("attrs") or ""
        inner = m.group("inner").strip()
        # separa "Capitolo N" / "Scheda N" / "Esercizio N" da " — resto del titolo"
        mm = re.match(r"^((?:Capitolo|Scheda|Esercizio)\s+[^\s—–-]+)\s+[—–-]\s+(.+)$", inner)
        if mm:
            kicker = mm.group(1)
            title = mm.group(2)
            return (
                '<div class="chapter">'
                f'<div class="kicker">{kicker}</div>'
                f'<h2{attrs} class="ctitle">{title}</h2>'
                "</div>"
            )
        return (
            '<div class="chapter">'
            f'<h2{attrs} class="ctitle">{inner}</h2>'
            "</div>"
        )

    return re.sub(
        r"<h2(?P<attrs>[^>]*)>(?P<inner>.*?)</h2>",
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
.chapter::after {
  content: "";
  display: block;
  width: 64px;
  height: 3px;
  background: var(--godot-blue);
  margin: 16px auto 0;
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

pre.code {
  background: #22282f;
  color: #e6edf3;
  padding: 14px 16px;
  border-radius: 6px;
  overflow-x: auto;
  font-size: 9.6pt;
  line-height: 1.5;
  text-align: left;
  page-break-inside: avoid;
  margin: 14px 0 16px;
  border: 1px solid #2b3543;
}
pre.code code {
  background: none;
  border: none;
  padding: 0;
  color: inherit;
  font-size: inherit;
}
pre.code .kw  { color: #ff9d6b; font-weight: 600; }
pre.code .str { color: #a5e075; }
pre.code .num { color: #d4a0ff; }
pre.code .com { color: #7d8896; font-style: italic; }

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

hr {
  border: none;
  border-top: 1px solid var(--line);
  margin: 24px 0;
}

ul, ol { margin: 0 0 12px; padding-left: 24px; text-align: left; }
li { margin: 4px 0; }
"""


def main():
    md_text = SRC_MD.read_text(encoding="utf-8")
    version, date = read_version_and_date(md_text)
    body_html = build_body_html(md_text)

    logo_uri = data_uri(IMG_DIR / "logo_vertical_monochrome_light.png")

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
<title>{html.escape(COVER_TITLE)} — {html.escape(COVER_SUBTITLE)}</title>
<style>{CSS}</style>
</head>
<body>
  <section class="cover">
    <img class="logo" src="{logo_uri}" alt="Logo Godot"/>
    <div class="title">{html.escape(COVER_TITLE)}</div>
    <div class="rule-cover"></div>
    <div class="subtitle">{html.escape(COVER_SUBTITLE)} <span class="emoji">🎮</span></div>
    <div class="meta">{html.escape(meta_line)}</div>
    <div class="author">{html.escape(COVER_AUTHOR)}</div>
  </section>
  <main>
    {body_html}
  </main>
</body>
</html>"""

    OUT_HTML.write_text(doc, encoding="utf-8")
    print(f"HTML scritto: {OUT_HTML}  ({len(doc)} byte)")

    # Nome del PDF consegnabile: SEMPRE con il numero di versione, mai due uguali.
    # Es. versione "0.1" -> manuale-v0.1.pdf   (regola nel CLAUDE.md).
    slug = (version or "0.0").strip().replace(" ", "")
    pdf_name = f"manuale-v{slug}.pdf"
    (BUILD_DIR / ".pdfname").write_text(pdf_name, encoding="utf-8")
    print(f"Nome PDF consegnabile: {pdf_name}")


if __name__ == "__main__":
    main()
