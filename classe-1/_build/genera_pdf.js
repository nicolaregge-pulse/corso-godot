// Converte manuale.html in PDF impaginato (A4) usando Chromium via Playwright.
// Uso: node genera_pdf.js
const path = require('path');
const fs = require('fs');
const { chromium } = require('playwright');

const BUILD_DIR = __dirname;

// genera_pdf.py scrive in .build.json quale HTML rendere e con che nome salvare
// il PDF (con la versione nel nome). Così vale sia per il manuale sia per
// l'eserciziario.
const info = JSON.parse(
  fs.readFileSync(path.join(BUILD_DIR, '.build.json'), 'utf8')
);
// genera_pdf.py scrive percorsi ASSOLUTI in .build.json
const HTML_PATH = info.html;
const PDF_PATH = info.pdf;

(async () => {
  const browser = await chromium.launch({
    executablePath: process.env.CHROMIUM_PATH || undefined,
  });
  const page = await browser.newPage();
  await page.goto('file://' + HTML_PATH, { waitUntil: 'networkidle' });

  // Piè di pagina con numero di pagina (non sulla copertina: la prima pagina
  // resta pulita perché usiamo margini e Chromium mostra il footer ovunque,
  // ma il numero parte da 1 = copertina; accettabile per un libro di corso).
  const opts = {
    path: PDF_PATH,
    format: 'A4',
    printBackground: true,
    displayHeaderFooter: true,
    margin: { top: '18mm', bottom: '18mm', left: '16mm', right: '16mm' },
    headerTemplate: '<div></div>',
    footerTemplate:
      '<div style="width:100%; font-size:8px; color:#8a97a5; ' +
      'font-family: Segoe UI, Arial, sans-serif; padding:0 16mm; ' +
      'display:flex; justify-content:space-between;">' +
      '<span>Corso di Informatica — Classe 1</span>' +
      '<span>Pag. <span class="pageNumber"></span> / <span class="totalPages"></span></span>' +
      '</div>',
  };

  // Per il libro completo (PDF_OUTLINE=1) aggiungo i SEGNALIBRI navigabili
  // ricavati dai titoli. Se la versione di Playwright non li supporta, riprovo
  // senza — così il PDF esce comunque.
  if (process.env.PDF_OUTLINE) {
    try {
      await page.pdf({ ...opts, tagged: true, outline: true });
    } catch (e) {
      console.warn('Segnalibri non supportati, genero senza:', e.message);
      await page.pdf(opts);
    }
  } else {
    await page.pdf(opts);
  }

  await browser.close();
  console.log('PDF scritto: ' + PDF_PATH);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
