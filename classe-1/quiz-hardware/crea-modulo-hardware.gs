/*
  crea-modulo-hardware.gs — crea in 1 clic un Quiz su Google Moduli sull'HARDWARE del PC.
  Domande trilingui (IT/AR/ZH), punteggio automatico.
  Uso: script.new -> Ctrl+A -> Canc -> incolla -> Ctrl+S -> scegli creaQuiz -> Esegui -> autorizza.
*/
function creaQuiz(){
  var f=FormApp.create("Quiz - Hardware del PC").setIsQuiz(true);
  var D=[
  ["1) A cosa serve la CPU? / ما وظيفة المعالج (CPU)؟ / CPU 有什么用？",[["È il cervello del PC: fa i calcoli",true],["Conserva i file per sempre",false],["Mostra le immagini sullo schermo",false]]],
  ["2) A cosa serve la RAM? / ما وظيفة الذاكرة (RAM)؟ / 内存 RAM 有什么用？",[["Memoria temporanea per i programmi aperti",true],["Conserva i file per sempre",false],["Raffredda il computer",false]]],
  ["3) Dove si salvano i file in modo permanente? / أين تُحفظ الملفات بشكل دائم؟ / 文件永久保存在哪里？",[["Nel disco: Hard Disk o SSD",true],["Nella RAM",false],["Nella CPU",false]]],
  ["4) Cosa è più veloce? / أيّهما أسرع؟ / 哪个更快？",[["L'SSD",true],["L'Hard Disk a dischi",false],["Sono uguali",false]]],
  ["5) A cosa serve la scheda madre? / ما وظيفة اللوحة الأم؟ / 主板有什么用？",[["Collega tra loro tutti i componenti",true],["Fa i calcoli al posto della CPU",false],["Produce la corrente",false]]],
  ["6) A cosa serve l'alimentatore? / ما وظيفة مزوّد الطاقة؟ / 电源有什么用？",[["Dà corrente ai componenti",true],["Conserva i file",false],["Mostra le immagini",false]]],
  ["7) La scheda video (GPU) serve soprattutto per? / لِمَ تُستخدم بطاقة الرسوميات (GPU)؟ / 显卡主要用于什么？",[["Grafica, immagini e giochi",true],["Salvare i file",false],["Collegarsi a internet",false]]],
  ["8) In cosa si misura la velocità della CPU? / بأيّ وحدة تُقاس سرعة المعالج؟ / CPU 速度用什么单位？",[["GHz (gigahertz)",true],["GB (gigabyte)",false],["Watt",false]]],
  ["9) In cosa si misura la capacità di RAM e disco? / بأيّ وحدة تُقاس سعة الذاكرة والقرص؟ / 内存和硬盘容量用什么单位？",[["GB (gigabyte)",true],["GHz",false],["Pixel",false]]],
  ["10) Tastiera e mouse sono dispositivi di? / لوحة المفاتيح والفأرة من أجهزة؟ / 键盘和鼠标属于哪类设备？",[["Input (ingresso)",true],["Output (uscita)",false],["Memoria",false]]],
  ["11) Il monitor è un dispositivo di? / الشاشة جهاز؟ / 显示器属于哪类设备？",[["Output (uscita)",true],["Input (ingresso)",false],["Alimentazione",false]]],
  ["12) Cosa serve per raffreddare la CPU? / ما الذي يبرّد المعالج؟ / 用什么给 CPU 散热？",[["La ventola / il dissipatore",true],["L'alimentatore",false],["La RAM",false]]]
  ];
  D.forEach(function(q){var i=f.addMultipleChoiceItem();i.setTitle(q[0]).setPoints(1).setRequired(true);i.setChoices(q[1].map(function(o){return i.createChoice(o[0],o[1]);}));});
  Logger.log("PRONTO. Modifica: "+f.getEditUrl());
}
