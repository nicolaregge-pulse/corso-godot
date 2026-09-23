/*
  crea-modulo-hardware.gs — crea in 1 clic un Quiz su Google Moduli sull'HARDWARE del PC.
  DOMANDE E OPZIONI trilingui (IT/AR/ZH), punteggio automatico.
  Uso: script.new -> Ctrl+A -> Canc -> incolla -> Ctrl+S -> scegli creaQuiz -> Esegui -> autorizza.
*/
function creaQuiz(){
  var f=FormApp.create("20260923_Esercitazione-Hardware-PC_multilingua_v1.0").setIsQuiz(true);
  var D=[
  ["1) A cosa serve la CPU? / ما وظيفة المعالج (CPU)؟ / CPU 有什么用？",[["È il cervello del PC: fa i calcoli / هو عقل الحاسوب: يقوم بالحسابات / 电脑的大脑：进行运算",true],["Conserva i file per sempre / يحفظ الملفات للأبد / 永久保存文件",false],["Mostra le immagini sullo schermo / يعرض الصور على الشاشة / 在屏幕上显示图像",false]]],
  ["2) A cosa serve la RAM? / ما وظيفة الذاكرة (RAM)؟ / 内存 RAM 有什么用？",[["Memoria temporanea per i programmi aperti / ذاكرة مؤقتة للبرامج المفتوحة / 打开程序的临时内存",true],["Conserva i file per sempre / يحفظ الملفات للأبد / 永久保存文件",false],["Raffredda il computer / يبرّد الحاسوب / 给电脑散热",false]]],
  ["3) Dove si salvano i file in modo permanente? / أين تُحفظ الملفات بشكل دائم؟ / 文件永久保存在哪里？",[["Nel disco: Hard Disk o SSD / على القرص: Hard Disk أو SSD / 在硬盘：Hard Disk 或 SSD",true],["Nella RAM / في الذاكرة RAM / 在内存 RAM",false],["Nella CPU / في المعالج CPU / 在 CPU",false]]],
  ["4) Cosa è più veloce? / أيّهما أسرع؟ / 哪个更快？",[["L'SSD / SSD / SSD",true],["L'Hard Disk a dischi / القرص الصلب ذو الأقراص / 机械硬盘",false],["Sono uguali / متساويان / 一样",false]]],
  ["5) A cosa serve la scheda madre? / ما وظيفة اللوحة الأم؟ / 主板有什么用？",[["Collega tra loro tutti i componenti / تربط جميع المكوّنات ببعضها / 连接所有部件",true],["Fa i calcoli al posto della CPU / تقوم بالحسابات بدل المعالج / 代替 CPU 运算",false],["Produce la corrente / تولّد الكهرباء / 产生电流",false]]],
  ["6) A cosa serve l'alimentatore? / ما وظيفة مزوّد الطاقة؟ / 电源有什么用？",[["Dà corrente ai componenti / يزوّد المكوّنات بالكهرباء / 给部件供电",true],["Conserva i file / يحفظ الملفات / 保存文件",false],["Mostra le immagini / يعرض الصور / 显示图像",false]]],
  ["7) La scheda video (GPU) serve soprattutto per? / لِمَ تُستخدم بطاقة الرسوميات (GPU)؟ / 显卡主要用于什么？",[["Grafica, immagini e giochi / الرسوميات والصور والألعاب / 图形、图像和游戏",true],["Salvare i file / حفظ الملفات / 保存文件",false],["Collegarsi a internet / الاتصال بالإنترنت / 连接互联网",false]]],
  ["8) In cosa si misura la velocità della CPU? / بأيّ وحدة تُقاس سرعة المعالج؟ / CPU 速度用什么单位？",[["GHz (gigahertz)",true],["GB (gigabyte)",false],["Watt / واط / 瓦特",false]]],
  ["9) In cosa si misura la capacità di RAM e disco? / بأيّ وحدة تُقاس سعة الذاكرة والقرص؟ / 内存和硬盘容量用什么单位？",[["GB (gigabyte)",true],["GHz",false],["Pixel / بكسل / 像素",false]]],
  ["10) Tastiera e mouse sono dispositivi di? / لوحة المفاتيح والفأرة من أجهزة؟ / 键盘和鼠标属于哪类设备？",[["Input - ingresso / إدخال (Input) / 输入 (Input)",true],["Output - uscita / إخراج (Output) / 输出 (Output)",false],["Memoria / ذاكرة / 内存",false]]],
  ["11) Il monitor è un dispositivo di? / الشاشة جهاز؟ / 显示器属于哪类设备？",[["Output - uscita / إخراج (Output) / 输出 (Output)",true],["Input - ingresso / إدخال (Input) / 输入 (Input)",false],["Alimentazione / تغذية كهربائية / 供电",false]]],
  ["12) Cosa serve per raffreddare la CPU? / ما الذي يبرّد المعالج؟ / 用什么给 CPU 散热？",[["La ventola / il dissipatore / المروحة أو المشتّت / 风扇或散热器",true],["L'alimentatore / مزوّد الطاقة / 电源",false],["La RAM / الذاكرة RAM / 内存 RAM",false]]]
  ];
  D.forEach(function(q){var i=f.addMultipleChoiceItem();i.setTitle(q[0]).setPoints(1).setRequired(true);i.setChoices(q[1].map(function(o){return i.createChoice(o[0],o[1]);}));});
  Logger.log("PRONTO. Modifica: "+f.getEditUrl());
}
