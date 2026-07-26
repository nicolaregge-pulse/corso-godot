// Converte manuale.html in PDF impaginato (A4) usando Chromium via Playwright.
// Uso: node genera_pdf.js
const path = require('path');
const fs = require('fs');
const { chromium } = require('playwright');

const BUILD_DIR = __dirname;
const HTML_PATH = path.join(BUILD_DIR, 'manuale.html');

// Il nome del PDF (con versione) lo decide genera_pdf.py e lo scrive in .pdfname.
const nameFile = path.join(BUILD_DIR, '.pdfname');
const pdfName = fs.existsSync(nameFile)
  ? fs.readFileSync(nameFile, 'utf8').trim()
  : 'manuale-v0.0.pdf';
const PDF_PATH = path.join(BUILD_DIR, '..', pdfName);

(async () => {
  const browser = await chromium.launch({
    executablePath: process.env.CHROMIUM_PATH || undefined,
  });
  const page = await browser.newPage();
  await page.goto('file://' + HTML_PATH, { waitUntil: 'networkidle' });

  // Piè di pagina con numero di pagina (non sulla copertina: la prima pagina
  // resta pulita perché usiamo margini e Chromium mostra il footer ovunque,
  // ma il numero parte da 1 = copertina; accettabile per un libro di corso).
  await page.pdf({
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
      '<span>Il Manuale — Corso di Godot</span>' +
      '<span>Pag. <span class="pageNumber"></span> / <span class="totalPages"></span></span>' +
      '</div>',
  });

  await browser.close();
  console.log('PDF scritto: ' + PDF_PATH);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
