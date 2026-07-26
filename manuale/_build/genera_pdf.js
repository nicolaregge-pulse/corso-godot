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
const HTML_PATH = path.join(BUILD_DIR, info.html);
const PDF_PATH = path.join(BUILD_DIR, '..', info.pdf);

(async () => {
  const browser = await chromium.launch({
    executablePath: process.env.CHROMIUM_PATH || undefined,
  });
  const page = await browser.newPage();
  await page.goto('file://' + HTML_PATH, { waitUntil: 'networkidle' });

  // Piè di pagina in TRE parti: a sinistra "Corso di Godot", al centro la
  // versione, a destra il numero di pagina.
  const fLeft = info.footerLeft || 'Corso di Godot';
  const fMid = info.footerMid || '';
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
      'display:flex; justify-content:space-between; align-items:center;">' +
      '<span style="flex:1; text-align:left;">' + fLeft + '</span>' +
      '<span style="flex:1; text-align:center;">' + fMid + '</span>' +
      '<span style="flex:1; text-align:right;">Pag. <span class="pageNumber"></span> / <span class="totalPages"></span></span>' +
      '</div>',
  });

  await browser.close();
  console.log('PDF scritto: ' + PDF_PATH);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
