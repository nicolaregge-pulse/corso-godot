-- ==========================================================
-- Database dei prodotti del negozio (per Supabase)
-- ----------------------------------------------------------
-- Come si usa: copia TUTTO questo testo e incollalo nella
-- lavagna SQL di Supabase (menu a sinistra: "SQL Editor"),
-- poi premi "Run". Crea la tabella "prodotti", ci mette
-- qualche prodotto di esempio e permette al negozio di
-- LEGGERLI (ma non di modificarli).
-- ==========================================================

-- 1) La tabella dei prodotti
create table prodotti (
  id      bigint generated always as identity primary key,  -- numero automatico
  nome    text    not null,   -- il nome del prodotto
  prezzo  numeric not null,   -- il prezzo (es. 12.90)
  foto    text                -- per ora un'emoji (es. '👕')
);

-- 2) Qualche prodotto di esempio  (CAMBIA QUI: mettine di tuoi!)
insert into prodotti (nome, prezzo, foto) values
  ('Maglietta',  12.90, '👕'),
  ('Scarpe',     39.90, '👟'),
  ('Cappellino',  9.90, '🧢'),
  ('Zaino',      24.90, '🎒');

-- 3) Permesso di sola lettura per il negozio
--    (chiunque può VEDERE i prodotti, nessuno può cambiarli dal sito)
alter table prodotti enable row level security;

create policy "lettura pubblica dei prodotti"
  on prodotti
  for select
  using (true);
