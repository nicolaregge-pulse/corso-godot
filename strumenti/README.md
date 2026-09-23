# Strumenti (script di servizio)

**Versione 0.1** — 23/09/2026
*Piccoli script di supporto per il docente. Non sono materiale per i ragazzi.*

## nome-albero.py — nomi file deterministici

Serve alla regola 2.13 (vedi `REGOLE-NOSTRE-CLAUDE-NICOLA.md`): il **percorso
delle cartelle è scritto dentro il nome del file**, con `__` (doppio underscore)
al posto della barra. Così da un mucchio di file "sciolti" si ricostruisce
l'albero delle cartelle in automatico.

1. **Espandi** (nomi piatti → albero di cartelle):
   `python3 strumenti/nome-albero.py espandi CARTELLA_SCARICATI CARTELLA_DESTINAZIONE`
2. **Collassa** (albero → nomi piatti, per inviarli):
   `python3 strumenti/nome-albero.py collassa CARTELLA_ROOT CARTELLA_DESTINAZIONE`

Copia i file (non li sposta). Esempio di nome:
`classe-1__utenze-password__20260923_Le-Mie-Utenze-Password_multilingua_v1.0.pdf`
→ `classe-1/utenze-password/20260923_Le-Mie-Utenze-Password_multilingua_v1.0.pdf`.

Nota: richiede Python (sul PC di Nicola, non a scuola). In alternativa il lavoro
lo fa Claude quando serve.
