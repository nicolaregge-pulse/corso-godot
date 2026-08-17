#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Costruisce la SUPER-GUIDA del corso: un unico PDF che unisce tutti i documenti
(con le immagini gia' dentro i PDF sorgente), con una pagina di Sommario
cliccabile all'inizio e i segnalibri laterali.

Prerequisito: i singoli PDF devono gia' esistere (generati con genera_pdf.py
per manuale/eserciziario e guida_pdf.py per le guide e i documenti).

Auto-append: oltre ai documenti elencati in TITOLI, ogni PDF numerato in radice
(nel formato "NN Titolo.pdf") non ancora elencato viene aggiunto in coda in
automatico, cosi' un documento nuovo entra da solo nella super-guida.

Uso (dalla radice del repo):
    python3 manuale/_build/volume_pdf.py
Produce: CORSO-COMPLETO-v1.2.pdf
"""
import fitz  # PyMuPDF
from pathlib import Path

VERSIONE = "1.2"
DATA = "16/08/2026"
OUT = f"CORSO-COMPLETO-v{VERSIONE}.pdf"

# ordine e titoli delle voci del Sommario (percorso PDF -> titolo)
TITOLI = {
    "00 CORSO.pdf": "Corso Godot — panoramica generale (doc 00)",
    "01 GLOSSARIO.pdf": "Glossario (doc 01)",
    "manuale/manuale-v0.20.pdf": "Manuale — libro di testo — v0.20",
    "manuale/eserciziario-v0.15.pdf": "Eserciziario — v0.15",
    "manuale/quaderno-studente-TEMPLATE.pdf": "Quaderno dello studente — modello",
    "03 SCALETTA-LEZIONI.pdf": "Scaletta delle lezioni (doc 03)",
    "consegne/README.pdf": "Consegne — come sono organizzate",
    "consegne/CREA-ACCOUNT-GITHUB.pdf": "Guida — crearsi l'account GitHub",
    "consegne/INVITO-ALLA-CLASSE.pdf": "Guida — invito alla classe, primo giro",
    "consegne/_MODELLO/ISTRUZIONI.pdf": "Modello consegna — istruzioni",
    "consegne/_MODELLO/scheda.pdf": "Modello consegna — scheda",
    "consegne/_PROF/COME-CORREGGO.pdf": "Prof — come correggere",
    "consegne/_PROF/valutazione-MODELLO.pdf": "Prof — modello di valutazione",
    "consegne/2026-2027-1informatica/rossi-mario/es1-bottone/scheda.pdf": "Esempio consegna — scheda",
    "consegne/2026-2027-1informatica/rossi-mario/es1-bottone/valutazione.pdf": "Esempio consegna — valutazione",
    "esercizi/README.pdf": "Esercizi pronti — panoramica",
    "battaglia-navale-3d/README.pdf": "Gioco — Affonda la Bonomi",
    "gioco-del-quindici/README.pdf": "Gioco — Gioco del Quindici",
    "REGOLE-DOCUMENTI.pdf": "Regole di formattazione dei documenti",
}


def ordine_documenti() -> list:
    """TITOLI nell'ordine dato, piu' l'auto-append dei PDF numerati in radice
    non ancora elencati (es. un futuro "04 ....pdf")."""
    extra = sorted(str(p) for p in Path(".").glob("[0-9][0-9] *.pdf")
                   if str(p) not in TITOLI)
    return list(TITOLI.keys()) + extra


def titolo_di(f: str) -> str:
    return TITOLI.get(f) or Path(f).stem


def main() -> None:
    body = fitz.open()
    entries = []
    for f in ordine_documenti():
        if not Path(f).exists():
            print("  manca (saltato):", f)
            continue
        d = fitz.open(f)
        start = body.page_count
        body.insert_pdf(d)
        entries.append((f, start, d.page_count))
        d.close()

    final = fitz.open()
    final.new_page(width=595, height=842)  # pagina Sommario
    offset = 1
    final.insert_pdf(body)

    pg = final[0]
    pg.insert_text((60, 70), "Corso Godot", fontsize=24, fontname="hebo")
    pg.insert_text((60, 96),
                   f"Super-guida — tutto il materiale in un unico documento — v{VERSIONE} — {DATA}",
                   fontsize=10, fontname="helv", color=(0.3, 0.3, 0.3))
    pg.draw_line((60, 110), (535, 110), color=(0.2, 0.2, 0.2), width=1.2)
    pg.insert_text((60, 140), "Sommario", fontsize=15, fontname="hebo")
    y = 168
    for (f, s, n) in entries:
        fp = s + offset
        pg.insert_text((62, y), titolo_di(f), fontsize=11.5, fontname="helv")
        pg.insert_text((512, y), str(fp + 1), fontsize=11.5, fontname="helv")
        pg.insert_link({"kind": fitz.LINK_GOTO, "from": fitz.Rect(58, y - 12, 537, y + 4),
                        "page": fp, "to": fitz.Point(0, 0)})
        y += 25.5

    toc = [[1, "Sommario", 1]]
    for (f, s, n) in entries:
        toc.append([1, titolo_di(f), s + offset + 1])
    final.set_toc(toc)

    final.save(OUT, deflate=True, garbage=4)
    print(f"Documenti: {len(entries)} | Pagine totali: {final.page_count} | File: {OUT}")
    final.close()


if __name__ == "__main__":
    main()
