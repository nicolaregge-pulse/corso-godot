/*
  crea-modulo-italiano.gs — versione SOLO ITALIANO del quiz (per classi dove
  tutti capiscono l'italiano, es. la seconda). Crea in 1 clic un Quiz su Google
  Moduli con punteggio automatico. Uso: script.new -> Ctrl+A -> Canc -> incolla
  -> Ctrl+S -> scegli creaQuiz -> Esegui -> autorizza.
*/
function creaQuiz(){
  var f=FormApp.create("Quiz - Regole e Versioning").setIsQuiz(true);
  var D=[
  ["1) Come si chiede la parola in classe?",[["Alzo la mano ben alta e aspetto che il docente dia la parola",true],["Parlo quando voglio",false],["Chiamo il docente ad alta voce",false]]],
  ["2) Il docente ti fa un cenno con la mano: cosa significa?",[["Posso abbassare la mano, mi darà la parola appena può",true],["Devo uscire",false],["Ho sbagliato",false]]],
  ["3) Sulla lavagna compare l orologio: cosa fai?",[["Mi attivo e faccio l esercitazione",true],["Aspetto la ricreazione",false],["Guardo un video",false]]],
  ["4) Si può guardare YouTube mentre si lavora?",[["No, niente YouTube o cose che non c entrano",true],["Sì, sempre",false],["Sì, a basso volume",false]]],
  ["5) Dove compare la nuova esercitazione?",[["Su Google Classroom",true],["Su YouTube",false],["Sulla lavagna",false]]],
  ["6) In v2.3 quale numero è la piccola modifica?",[["Il secondo (3)",true],["Il primo (2)",false],["Tutti e due",false]]],
  ["7) Piccola correzione a v1.2: come diventa?",[["v1.3",true],["v2.0",false],["v0.2",false]]],
  ["8) Dopo v1.4 un cambiamento importante: quale numero?",[["v2.0",true],["v1.5",false],["v1.4.1",false]]],
  ["9) Cosa vuol dire branch (ramo)?",[["Un ramo che si stacca per lavorare senza rompere il resto",true],["Cancellare il progetto",false],["Spegnere il PC",false]]],
  ["10) Cosa vuol dire merge (unione)?",[["Riunire un ramo con quello principale",true],["Perdere il lavoro",false],["Ricominciare da zero",false]]],
  ["11) Versione già consegnata, se cambio qualcosa?",[["Aumento il numero di versione e ne faccio una nuova",true],["La sovrascrivo con lo stesso nome",false],["Non faccio niente",false]]],
  ["12) Cosa significa una versione 0.x (es. v0.3)?",[["Ancora in prova, non completa",true],["La versione finale",false],["Una versione rotta",false]]]
  ];
  D.forEach(function(q){var i=f.addMultipleChoiceItem();i.setTitle(q[0]).setPoints(1).setRequired(true);i.setChoices(q[1].map(function(o){return i.createChoice(o[0],o[1]);}));});
  Logger.log("PRONTO. Modifica: "+f.getEditUrl());
}
