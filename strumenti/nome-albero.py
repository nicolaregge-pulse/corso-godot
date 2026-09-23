#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
nome-albero.py — nomi file DETERMINISTICI (il percorso e' dentro il nome).

Convenzione (regola 2.13 di REGOLE-NOSTRE-CLAUDE-NICOLA.md):
  Le cartelle del percorso si scrivono all'inizio del nome, separate da '__'
  (doppio underscore). L'ultimo pezzo dopo l'ultimo '__' e' il nome del file.
  Il singolo '_' resta il separatore dei campi DENTRO il nome file; '__' e' SOLO
  per le cartelle.

  Esempio:
    classe-1__utenze-password__20260923_Le-Mie-Utenze-Password_multilingua_v1.0.pdf
    -> classe-1/utenze-password/20260923_Le-Mie-Utenze-Password_multilingua_v1.0.pdf

Uso:
  # ESPANDI: da una cartella piena di file "piatti" ricostruisce l'albero
  python3 nome-albero.py espandi  CARTELLA_SORGENTE  CARTELLA_DESTINAZIONE

  # COLLASSA: da un albero di cartelle produce i nomi "piatti"
  python3 nome-albero.py collassa CARTELLA_ROOT      CARTELLA_DESTINAZIONE

Copia i file (non li sposta): l'originale resta al suo posto.
"""
import os, sys, shutil

SEP = "__"

def espandi(src, dst):
    n = 0
    for name in sorted(os.listdir(src)):
        p = os.path.join(src, name)
        if not os.path.isfile(p):
            continue
        parts = name.split(SEP)
        *cartelle, filename = parts
        target_dir = os.path.join(dst, *cartelle) if cartelle else dst
        os.makedirs(target_dir, exist_ok=True)
        shutil.copy2(p, os.path.join(target_dir, filename))
        print(f"  {name}\n   -> {os.path.join(*cartelle, filename) if cartelle else filename}")
        n += 1
    print(f"[espandi] {n} file ricostruiti in: {dst}")

def collassa(root, dst):
    os.makedirs(dst, exist_ok=True)
    n = 0
    root = os.path.abspath(root)
    for dirpath, _dirs, files in os.walk(root):
        rel = os.path.relpath(dirpath, root)
        cartelle = [] if rel == "." else rel.replace("\\", "/").split("/")
        for f in sorted(files):
            flat = SEP.join(cartelle + [f]) if cartelle else f
            shutil.copy2(os.path.join(dirpath, f), os.path.join(dst, flat))
            print(f"  {os.path.join(rel, f)}\n   -> {flat}")
            n += 1
    print(f"[collassa] {n} file appiattiti in: {dst}")

def main():
    if len(sys.argv) != 4 or sys.argv[1] not in ("espandi", "collassa"):
        print(__doc__)
        sys.exit(1)
    cmd, a, b = sys.argv[1], sys.argv[2], sys.argv[3]
    (espandi if cmd == "espandi" else collassa)(a, b)

if __name__ == "__main__":
    main()
