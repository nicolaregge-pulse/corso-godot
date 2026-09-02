// Render ATTESTATO-RUOLI.html -> ATTESTATO-RUOLI-v0.4.pdf (unico PDF, 4 pagine).
// Se attestati/logo-piamarta.(png|jpg|jpeg|webp) esiste, lo inserisce come logo.
const fs = require('fs');
const path = require('path');
const { chromium } = require('/home/user/corso-godot/classe-1/_build/node_modules/playwright');

const DIR = __dirname;
const VERSION = 'v0.4';
const htmlPath = path.join(DIR, 'ATTESTATO-RUOLI.html');
let html = fs.readFileSync(htmlPath, 'utf8');

// cerca il file logo
const candidates = ['logo-piamarta.png', 'logo-piamarta.jpg', 'logo-piamarta.jpeg', 'logo-piamarta.webp'];
let logoTag = '';
for (const name of candidates) {
  const p = path.join(DIR, name);
  if (fs.existsSync(p)) {
    const ext = path.extname(name).slice(1).replace('jpg', 'jpeg');
    const b64 = fs.readFileSync(p).toString('base64');
    logoTag = `<img class="logo" src="data:image/${ext};base64,${b64}" alt="Piamarta Formazione">`;
    console.log('Logo trovato: ' + name);
    break;
  }
}
if (!logoTag) console.log('Nessun logo trovato (slot vuoto). Aggiungi attestati/logo-piamarta.png per includerlo.');

html = html.split('{{LOGO}}').join(logoTag);

(async () => {
  const browser = await chromium.launch({
    executablePath: process.env.CHROMIUM_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome',
  });
  const page = await browser.newPage();
  await page.setContent(html, { waitUntil: 'networkidle' });
  const out = path.join(DIR, `ATTESTATO-RUOLI-${VERSION}.pdf`);
  await page.pdf({ path: out, format: 'A4', printBackground: true,
    margin: { top: '0', bottom: '0', left: '0', right: '0' } });
  await browser.close();
  console.log('Creato: ' + out);
})();
