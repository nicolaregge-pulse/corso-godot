#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Genera un HTML impaginato e pulito da una guida in Markdown, pronto da
stampare in PDF con guida_pdf.js (Chromium).

Uso:
    python3 guida_pdf.py <percorso-della-guida.md>
Scrive un file .guida.html accanto e ne stampa il percorso.
"""
import sys
from pathlib import Path
import markdown

CSS = """
*{box-sizing:border-box}
html,body{margin:0}
body{font-family:-apple-system,"Segoe UI",Arial,sans-serif;color:#1b1b1b;line-height:1.55;font-size:12pt;padding:0}
main{padding:0}
h1{font-size:22pt;margin:0 0 14px;padding-bottom:8px;border-bottom:2px solid #2b2b2b}
h2{font-size:15.5pt;margin:22px 0 8px;color:#222}
h3{font-size:13pt;margin:16px 0 6px;color:#222}
p,li{font-size:12pt}
ol,ul{padding-left:22px;margin:8px 0}
li{margin:3px 0}
strong{color:#000}
code{font-family:Consolas,"Courier New",monospace;background:#f0f0f0;padding:1px 5px;border-radius:3px;font-size:10.5pt}
pre{background:#f6f6f6;border:1px solid #dcdcdc;border-radius:6px;padding:10px 12px;overflow:auto}
pre code{background:none;padding:0;font-size:10.5pt}
blockquote{border-left:4px solid #cfcfcf;margin:12px 0;padding:4px 14px;color:#444;background:#fafafa}
table{border-collapse:collapse;margin:10px 0}
td,th{border:1px solid #ccc;padding:6px 10px;font-size:11pt}
h1,h2,h3,li,p{page-break-inside:avoid}
"""

def build(mdpath: str) -> Path:
    src = Path(mdpath)
    text = src.read_text(encoding="utf-8")
    body = markdown.markdown(text, extensions=["extra", "sane_lists", "nl2br"])
    doc = ("<!doctype html><html lang='it'><head><meta charset='utf-8'>"
           "<style>" + CSS + "</style></head><body><main>" + body + "</main></body></html>")
    out = src.with_suffix(".guida.html")
    out.write_text(doc, encoding="utf-8")
    return out

if __name__ == "__main__":
    print(build(sys.argv[1]))
