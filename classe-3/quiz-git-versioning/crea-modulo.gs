/*
  crea-modulo.gs — crea AUTOMATICAMENTE un Quiz su Google Moduli
  Argomenti: Git, GitHub, servizi (PaaS/aaS/Freemium) e Versioning
  Lingua: italiano (Classe 3 = solo italiano)
  Il quiz assegna il PUNTEGGIO da solo (risposta giusta segnata).

  COME SI USA (passo-passo, vedi anche il foglio di riferimento):
  1. Apri  script.google.com  e crea un "Nuovo progetto".
  2. Cancella tutto il codice di esempio e INCOLLA questo file.
  3. In alto scegli la funzione  creaQuiz  e premi "Esegui".
  4. Autorizza (col tuo account scuola) quando lo chiede.
  5. Nel registro (Esecuzioni) trovi il link del Modulo creato.
*/

function creaQuiz() {
  var form = FormApp.create('Quiz — Git e Versioning')
    .setIsQuiz(true)
    .setDescription(
      'Interrogazione su: Git, GitHub e le versioni (versioning). Puoi usare la dispensa.'
    );

  var domande = [
    {
      t: '1) Che cos\'e Git?',
      opz: [
        ['Uno strumento che tiene la storia di un progetto e fa tornare indietro', true],
        ['Un social network per programmatori', false],
        ['Un antivirus', false]
      ]
    },
    {
      t: '2) Qual e la differenza tra Git e GitHub?',
      opz: [
        ['Git e lo strumento; GitHub e il sito-servizio che tiene i progetti online', true],
        ['Sono la stessa identica cosa', false],
        ['Git e a pagamento, GitHub e gratis', false]
      ]
    },
    {
      t: '3) GitHub che tipo di servizio e?',
      opz: [
        ['Una piattaforma online gia pronta (PaaS)', true],
        ['Un gioco per telefono', false],
        ['Un programma da installare col CD', false]
      ]
    },
    {
      t: '4) Cosa vuol dire "Freemium"?',
      opz: [
        ['Le funzioni base sono gratis, quelle extra si pagano', true],
        ['E tutto gratis per sempre', false],
        ['Si paga tutto subito', false]
      ]
    },
    {
      t: '5) Quale di questi e un esempio di SaaS (software gia pronto da usare nel browser)?',
      opz: [
        ['Gmail / Google Documenti', true],
        ['Un server vuoto da configurare', false],
        ['Un hard disk', false]
      ]
    },
    {
      t: '6) Che cos\'e un "commit"?',
      opz: [
        ['Un salvataggio (una fotografia) del progetto con un messaggio', true],
        ['Cancellare tutto il progetto', false],
        ['Spegnere il computer', false]
      ]
    },
    {
      t: '7) Che cos\'e un "branch" (ramo)?',
      opz: [
        ['Una strada di lavoro parallela, per provare senza rovinare il main', true],
        ['Il cestino dei file', false],
        ['Il nome del computer', false]
      ]
    },
    {
      t: '8) Cosa significa fare un "merge"?',
      opz: [
        ['Unire un ramo con quello principale (main)', true],
        ['Perdere il lavoro fatto', false],
        ['Ricominciare da zero', false]
      ]
    },
    {
      t: '9) Sei alla versione v1.2.0 e correggi solo un piccolo bug. Qual e la nuova versione?',
      opz: [
        ['v1.2.1', true],
        ['v2.0.0', false],
        ['v1.3.0', false]
      ]
    },
    {
      t: '10) Sei alla versione v1.2.0 e aggiungi una funzione nuova (il resto funziona ancora). Qual e la nuova versione?',
      opz: [
        ['v1.3.0', true],
        ['v1.2.1', false],
        ['v2.0.0', false]
      ]
    },
    {
      t: '11) Una versione gia pubblicata: se cambi qualcosa, cosa fai?',
      opz: [
        ['Aumento (bump) il numero di versione e ne faccio una nuova', true],
        ['La sovrascrivo con lo stesso numero', false],
        ['Non serve fare niente', false]
      ]
    },
    {
      t: '12) Vuoi provare un\'idea rischiosa senza rovinare il gioco che funziona. Cosa fai?',
      opz: [
        ['Apro un branch a parte e provo li; se funziona faccio il merge', true],
        ['Cambio direttamente il main e spero bene', false],
        ['Rinuncio a provare', false]
      ]
    }
  ];

  // Prima domanda: CHI SEI (obbligatoria) — cosi il quiz NON e anonimo.
  var nome = form.addTextItem();
  nome.setTitle('Cognome e Nome');
  nome.setHelpText('Scrivi il tuo cognome e nome, come ti chiama il prof.');
  nome.setRequired(true);

  domande.forEach(function (d) {
    var item = form.addMultipleChoiceItem();
    item.setTitle(d.t);
    if (d.h) item.setHelpText(d.h);
    item.setPoints(1);
    item.setRequired(true);
    item.setChoices(d.opz.map(function (o) { return item.createChoice(o[0], o[1]); }));
  });

  Logger.log('MODULO CREATO.');
  Logger.log('Link per MODIFICARLO:   ' + form.getEditUrl());
  Logger.log('Link da COMPILARE:      ' + form.getPublishedUrl());
}
