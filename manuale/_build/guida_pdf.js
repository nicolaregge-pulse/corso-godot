// Stampa in PDF (A4) un HTML di guida generato da guida_pdf.py, con Chromium.
// Uso: node guida_pdf.js <input.html> <output.pdf>
const path = require('path');
const { chromium } = require('playwright');

(async () => {
  const htmlPath = path.resolve(process.argv[2]);
  const pdfPath = path.resolve(process.argv[3]);
  const browser = await chromium.launch({
    executablePath: process.env.CHROMIUM_PATH || undefined,
  });
  const page = await browser.newPage();
  await page.goto('file://' + htmlPath, { waitUntil: 'networkidle' });
  await page.pdf({
    path: pdfPath,
    format: 'A4',
    printBackground: true,
    margin: { top: '16mm', bottom: '16mm', left: '16mm', right: '16mm' },
    displayHeaderFooter: true,
    headerTemplate: '<div></div>',
    footerTemplate:
      '<div style="width:100%; font-size:8px; color:#8a97a5; ' +
      'font-family: Segoe UI, Arial, sans-serif; padding:0 16mm; ' +
      'display:flex; justify-content:space-between;">' +
      '<span>Corso di Godot</span>' +
      '<span>Pag. <span class="pageNumber"></span> / <span class="totalPages"></span></span>' +
      '</div>',
  });
  await browser.close();
  console.log('PDF scritto: ' + pdfPath);
})().catch((e) => { console.error(e); process.exit(1); });
