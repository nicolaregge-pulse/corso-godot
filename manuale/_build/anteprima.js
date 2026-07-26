// Rende l'HTML in immagini PNG paginate (formato A4) per anteprima visiva.
const path = require('path');
const { chromium } = require('playwright');

const BUILD_DIR = __dirname;
const HTML_PATH = path.join(BUILD_DIR, 'manuale.html');

(async () => {
  const browser = await chromium.launch({
    executablePath: process.env.CHROMIUM_PATH || undefined,
  });
  // A4 a 96dpi ~ 794x1123 px. Uso larghezza area di stampa (A4 - margini).
  const page = await browser.newPage({ viewport: { width: 794, height: 1123 } });
  await page.emulateMedia({ media: 'print' });
  await page.goto('file://' + HTML_PATH, { waitUntil: 'networkidle' });
  // screenshot dell'intera pagina scrollabile
  await page.screenshot({
    path: path.join(BUILD_DIR, 'anteprima_full.png'),
    fullPage: true,
  });
  await browser.close();
  console.log('anteprima scritta');
})().catch((e) => { console.error(e); process.exit(1); });
