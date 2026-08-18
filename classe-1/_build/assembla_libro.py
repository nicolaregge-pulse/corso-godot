#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Assembla il "SUPER LIBRO" del corso: un unico documento che contiene DENTRO
tutti i documenti del corso, ognuno nella sua ULTIMA versione, con un indice
cliccabile e navigabile.

Come funziona:
  1) legge, in ordine, i documenti sorgente elencati in LIBRO (le loro .md);
  2) di ognuno prende il corpo (senza la testata), sistema le immagini e assegna
     un'ancora ai titoli (per l'indice cliccabile);
  3) genera:
       - LIBRO-COMPLETO.md   (la fonte unica, rigenerata: NON modificare a mano)
       - _build/libro-completo.html (impaginato, con copertina + indice)
       - .build.json  -> dice a genera_pdf.js dove salvare il PDF
  4) il PDF vero e proprio lo produce genera_pdf.js (con i segnalibri).

REGOLA: ogni volta che si aggiorna un documento del corso, si RIGENERA questo
libro (basta rilanciare lo script + genera_pdf.js). Se cambia il contenuto,
si alza LIBRO_VERSION qui sotto.

Uso:
    python3 assembla_libro.py
    PDF_OUTLINE=1 CHROMIUM_PATH=... node genera_pdf.js
"""

import html
import json
import re
from pathlib import Path

import genera_pdf as G  # riusa tutte le funzioni di impaginazione già collaudate

# ---------------------------------------------------------------------------
# Versione del LIBRO COMPLETO (si alza quando cambia il contenuto aggregato)
# ---------------------------------------------------------------------------
LIBRO_VERSION = "1.15"
LIBRO_DATE = "16/08/2026"
LIBRO_TITLE = "Il Libro del Corso"
LIBRO_SUBTITLE = "Corso di Informatica — tutti i documenti in uno"

BUILD_DIR = Path(__file__).resolve().parent
CLASSE1_DIR = BUILD_DIR.parent
REPO_ROOT = CLASSE1_DIR.parent

# ---------------------------------------------------------------------------
# I documenti del libro, IN ORDINE. 'src' è relativo alla radice del repo.
# Sono le FONTI .md nella loro ultima versione: cambiandole e rilanciando lo
# script, il libro si riallinea da solo.
# ---------------------------------------------------------------------------
LIBRO = [
    # (etichetta parte, percorso .md dalla radice, titolo nel libro)
    ("Riferimento",            "00-STATO-DEL-CORSO.md",                        "Stato del Corso"),
    ("Riferimento",            "01-GLOSSARIO.md",                              "Glossario"),
    ("Riferimento",            "REGOLE-FORMATTAZIONE.md",                      "Regole di Formattazione"),
    ("Riferimento",            "STRUTTURA-REPOSITORY.md",                      "Struttura del Repository"),
    ("Riferimento",            "MAPPA-ARGOMENTI.md",                           "Mappa degli Argomenti — Macro-aree"),
    ("Classe 1 — Informatica", "classe-1/programma.md",                       "Programma del Corso"),
    ("Classe 1 — Informatica", "classe-1/bussola-mondo-del-lavoro.md",        "La Bussola del Lavoro"),
    ("Classe 1 — Informatica", "classe-1/da-far-fare-assolutamente.md",       "Da Far Fare Assolutamente"),
    ("Classe 1 — Informatica", "classe-1/negozio-online/GUIDA-RAGAZZI.md",    "Il Mio Negozio Online — Guida per i ragazzi"),
    ("Classe 1 — Informatica", "classe-1/negozio-online/PIANO-LEZIONE.md",    "Il Mio Negozio Online — Piano-lezione"),
    ("Corso Godot / GDScript", "manuale/manuale.md",                          "Il Manuale di Godot"),
    ("Corso Godot / GDScript", "manuale/eserciziario.md",                     "Eserciziario di Godot"),
    ("Corso Godot / GDScript", "manuale/quaderno-studente-TEMPLATE.md",       "Quaderno dello Studente (modello)"),
    ("Classe 2 — Informatica", "classe-2/programma.md",                       "Programma del Corso — Classe 2"),
    ("Classe 3 — Informatica", "classe-3/programma.md",                       "Programma del Corso — Classe 3"),
    ("Classe 3 — Informatica", "classe-3/reti-teoria.md",                     "Le Reti di Computer — Teoria"),
    ("Classe 3 — Informatica", "classe-3/esercizi/01-cablaggio-rj45.md",      "Cablaggio RJ45 — Scheda pratica"),
    ("Classe 4 — Informatica", "classe-4/programma.md",                       "Programma del Corso — Classe 4"),
    ("Indici e cataloghi",     "CORSO-INFORMATICA.md",                         "Corso Informatica — indice generale"),
    ("Indici e cataloghi",     "classe-1/MATERIALE-PRONTO.md",                 "Materiale del Corso — Classe 1"),
]


def strip_header(md_text: str) -> str:
    """Toglie la testata del documento (titolo + versione) fino al primo '---'."""
    lines = md_text.split("\n")
    for i, ln in enumerate(lines):
        if ln.strip() == "---":
            return "\n".join(lines[i + 1:]).strip()
    return md_text.strip()


def prepara_documento(md_text: str, docdir_rel: str, n: int):
    """Sistema il corpo di un documento per il libro.

    - immagini: da 'immagini/xxx.png' a '<cartella-doc>/immagini/xxx.png'
      (così il percorso è valido dalla radice del repo);
    - i segnaposto vuoti del quaderno ('______.png') diventano un riquadro;
    - a ogni titolo di sezione (##) mette un'ancora unica per l'indice.
    Ritorna (markdown_del_corpo, elenco_sezioni[(titolo, ancora)]).
    """
    body = strip_header(md_text)
    out, sezioni = [], []
    in_fence = False
    m = 0
    for line in body.split("\n"):
        s = line.lstrip()
        if s.startswith("```"):
            in_fence = not in_fence
            out.append(line)
            continue
        if not in_fence:
            # immagine a inizio riga: sistemo il percorso o metto un segnaposto
            if re.match(r"^\s*!\[", line):
                if "______" in line:
                    out.append("> 📷 *(qui lo studente incolla il suo screenshot)*")
                    continue
                line = re.sub(r"\]\(immagini/", f"]({docdir_rel}/immagini/", line)
                out.append(line)
                continue
            # titolo di sezione ## (non ###): assegno un'ancora
            hm = re.match(r"^##\s+(?!#)(.+?)\s*(\{#[^}]+\})?\s*$", line)
            if hm:
                m += 1
                sid = f"doc{n}-sec{m}"
                titolo = hm.group(1).strip()
                out.append(f"## {titolo} {{#{sid}}}")
                sezioni.append((titolo, sid))
                continue
        out.append(line)
    return "\n".join(out), sezioni


def main():
    # 1) leggo e preparo ogni documento
    documenti = []
    for idx, (parte, src_rel, titolo) in enumerate(LIBRO, start=1):
        src = (REPO_ROOT / src_rel).resolve()
        if not src.exists():
            print(f"⚠️  Salto (non trovato): {src_rel}")
            continue
        md_text = src.read_text(encoding="utf-8")
        version, date = G.read_version_and_date(md_text)
        docdir_rel = str(Path(src_rel).parent)  # es. 'manuale' o 'classe-1/negozio-online'
        corpo, sezioni = prepara_documento(md_text, docdir_rel, idx)
        documenti.append({
            "n": idx, "parte": parte, "titolo": titolo,
            "version": version, "date": date,
            "anchor": f"doc{idx}", "corpo": corpo, "sezioni": sezioni,
        })

    # 2) costruisco la fonte unica LIBRO-COMPLETO.md (rigenerata)
    parti_md = [
        f"# {LIBRO_TITLE}\n",
        f"**Versione {LIBRO_VERSION}** — {LIBRO_DATE}",
        f"*{LIBRO_SUBTITLE}. Fonte unica generata automaticamente da "
        f"`classe-1/_build/assembla_libro.py`: **non modificare a mano**, "
        f"si rigenera dai singoli documenti.*",
        "\n---\n",
    ]
    for d in documenti:
        parti_md.append(f"# {d['titolo']} {{#{d['anchor']}}}")
        meta = []
        if d["version"]:
            meta.append(f"Versione {d['version']}")
        if d["date"]:
            meta.append(d["date"])
        meta.append(f"Parte: {d['parte']}")
        parti_md.append(f"*{' · '.join(meta)}*\n")
        parti_md.append(d["corpo"])
        parti_md.append("\n")
    libro_md = "\n".join(parti_md).strip() + "\n"
    (REPO_ROOT / "LIBRO-COMPLETO.md").write_text(libro_md, encoding="utf-8")
    print(f"MD scritto: {REPO_ROOT / 'LIBRO-COMPLETO.md'}")

    # 3) costruisco il corpo HTML riusando l'impaginatore, ma con la radice del
    #    repo come base (così le immagini 'manuale/immagini/...' si trovano).
    G.MANUALE_DIR = REPO_ROOT
    G.IMG_DIR = REPO_ROOT
    G.DOC_DIR = REPO_ROOT  # nel libro i percorsi immagine sono già dalla radice
    body_html = G.build_body_html(libro_md)

    # 3b) i titoli di documento sono <h1>: li trasformo in "divisori di documento"
    def h1_repl(mm):
        attrs = mm.group("attrs") or ""
        inner = mm.group("inner").strip()
        return f'<div class="docdiv"><h1{attrs} class="dtitle">{inner}</h1></div>'
    body_html = re.sub(r"<h1(?P<attrs>[^>]*)>(?P<inner>.*?)</h1>",
                       h1_repl, body_html, flags=re.DOTALL)

    # 4) l'INDICE cliccabile (parti -> documenti -> sezioni)
    toc = ['<section class="toc"><h2 class="toc-h">Indice</h2>']
    parte_corrente = None
    for d in documenti:
        if d["parte"] != parte_corrente:
            parte_corrente = d["parte"]
            toc.append(f'<div class="toc-part">{html.escape(parte_corrente)}</div>')
        v = f' <span class="toc-v">v{html.escape(d["version"])}</span>' if d["version"] else ""
        toc.append(
            f'<div class="toc-doc"><a href="#{d["anchor"]}">'
            f'{html.escape(d["titolo"])}</a>{v}</div>'
        )
        for titolo, sid in d["sezioni"]:
            toc.append(f'<div class="toc-sec"><a href="#{sid}">{html.escape(titolo)}</a></div>')
    toc.append("</section>")
    toc_html = G.strip_emoji("\n".join(toc))   # niente emoji anche nell'indice

    # 5) copertina + indice + corpo -> HTML unico
    logo_uri = G.find_logo()
    logo_html = f'<img class="logo" src="{logo_uri}" alt="Logo"/>' if logo_uri else ""
    doc = f"""<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="utf-8"/>
<title>{html.escape(LIBRO_TITLE)} — {html.escape(LIBRO_SUBTITLE)}</title>
<style>{G.CSS}{EXTRA_CSS}</style>
</head>
<body>
  <section class="cover">
    {logo_html}
    <div class="title">{html.escape(LIBRO_TITLE)}</div>
    <div class="rule-cover"></div>
    <div class="subtitle">{html.escape(LIBRO_SUBTITLE)}</div>
    <div class="meta">Versione {html.escape(LIBRO_VERSION)} · {html.escape(LIBRO_DATE)}</div>
    <div class="author">{html.escape(G.COVER_AUTHOR)}</div>
  </section>
  {toc_html}
  <main>
    {body_html}
  </main>
</body>
</html>"""

    out_html = BUILD_DIR / "libro-completo.html"
    out_html.write_text(doc, encoding="utf-8")
    print(f"HTML scritto: {out_html}  ({len(doc)} byte)")

    pdf_path = REPO_ROOT / f"LIBRO-COMPLETO-v{LIBRO_VERSION}.pdf"
    (BUILD_DIR / ".build.json").write_text(
        json.dumps({"html": str(out_html), "pdf": str(pdf_path)}), encoding="utf-8"
    )
    print(f"PDF consegnabile (da rendere con genera_pdf.js): {pdf_path}")


# CSS aggiuntivo: divisori di documento (h1) + indice cliccabile
EXTRA_CSS = r"""
/* ---------- DIVISORE DI DOCUMENTO (titolo di ogni documento nel libro) ---------- */
.docdiv {
  page-break-before: always;
  text-align: center;
  padding-top: 12mm;
  margin-bottom: 22px;
  border-bottom: 3px double var(--godot-blue);
  padding-bottom: 18px;
}
h1.dtitle {
  font-family: var(--serif);
  font-size: 34pt;
  font-weight: 700;
  line-height: 1.12;
  color: var(--godot-blue-dark);
  margin: 0 auto;
  max-width: 90%;
}
.docdiv + p em { color: var(--muted); }   /* riga versione sotto il titolo */

/* ---------- INDICE ---------- */
.toc {
  page-break-after: always;
  padding-top: 6mm;
}
.toc-h {
  font-family: var(--serif);
  font-size: 24pt;
  text-align: center;
  color: var(--ink);
  margin: 0 0 22px;
}
.toc-part {
  font-family: var(--serif);
  text-transform: uppercase;
  letter-spacing: 3px;
  font-size: 10.5pt;
  font-weight: 700;
  color: var(--godot-blue);
  margin: 20px 0 8px;
  border-bottom: 1px solid var(--line);
  padding-bottom: 4px;
}
.toc-doc {
  font-size: 13pt;
  font-weight: 700;
  margin: 9px 0 3px;
}
.toc-doc a { color: var(--ink); }
.toc-v {
  font-size: 9pt;
  font-weight: 400;
  color: var(--muted);
  font-style: italic;
}
.toc-sec {
  font-size: 10.5pt;
  margin: 2px 0 2px 18px;
}
.toc-sec a { color: var(--godot-blue-dark); }
.toc a:hover { text-decoration: underline; }

/* ---------- MENO SPAZI VUOTI ----------
   Nel libro le sezioni (##) NON iniziano una pagina nuova ciascuna: scorrono
   una dietro l'altra. Va a capo solo tra un DOCUMENTO e l'altro (.docdiv). */
.chapter {
  page-break-before: auto;
  page-break-after: auto;
  padding-top: 0;
  margin: 22px 0 10px;
  text-align: left;
}
h2.ctitle {
  font-size: 19pt;
  max-width: 100%;
}
.chapter .kicker { margin-bottom: 6px; }
.chapter::after { margin: 10px 0 0; }
.chapter .csub { margin-left: 0; max-width: 100%; }
"""


if __name__ == "__main__":
    main()
