/*
  crea-modulo.gs — crea AUTOMATICAMENTE un Quiz su Google Moduli
  Argomenti: Regole della classe + Versioning (le versioni)
  Lingue: italiano · arabo · cinese semplificato
  Il quiz assegna il PUNTEGGIO da solo (risposta giusta segnata).

  COME SI USA (passo-passo, vedi anche il foglio di riferimento):
  1. Apri  script.google.com  e crea un "Nuovo progetto".
  2. Cancella tutto il codice di esempio e INCOLLA questo file.
  3. In alto scegli la funzione  creaQuiz  e premi "Esegui".
  4. Autorizza (col tuo account scuola) quando lo chiede.
  5. Nel registro (Esecuzioni) trovi il link del Modulo creato.
*/

function creaQuiz() {
  var form = FormApp.create('Quiz — Regole della classe e Versioning')
    .setIsQuiz(true)
    .setDescription(
      'Interrogazione su: le regole della classe e il versioning (le versioni). ' +
      'Puoi usare il quaderno.\n' +
      'اختبار عن: قواعد الصف والإصدارات (versioning). يمكنك استخدام الدفتر.\n' +
      '关于：课堂规则和版本（versioning）的测验。可以使用笔记本。'
    );

  var domande = [
    // ---- REGOLE DELLA CLASSE ----
    {
      t: '1) Come si chiede la parola in classe?',
      h: 'كيف تطلب الإذن بالكلام في الصف؟\n在课堂上如何请求发言？',
      opz: [
        ['Si alza la mano ben alta e si aspetta che il docente dia la parola / يرفع اليد عاليًا وينتظر أن يعطيه المعلّم الكلمة / 把手举高，等老师叫你发言', true],
        ['Si parla quando si vuole / يتكلّم متى شاء / 想说就说', false],
        ['Si chiama il docente ad alta voce / ينادي المعلّم بصوت عالٍ / 大声叫老师', false]
      ]
    },
    {
      t: '2) Il docente ti fa un cenno con la mano. Cosa significa?',
      h: 'يشير إليك المعلّم بيده. ماذا يعني ذلك؟\n老师向你做手势示意。这是什么意思？',
      opz: [
        ['Puoi abbassare la mano, ti darà la parola appena può / يمكنك خفض يدك وسيعطيك الكلمة حالما يستطيع / 你可以把手放下，他一有空就叫你', true],
        ['Devi uscire dall\'aula / عليك الخروج من الصف / 你要离开教室', false],
        ['Hai sbagliato / لقد أخطأت / 你错了', false]
      ]
    },
    {
      t: '3) Sulla lavagna compare l\'orologio. Cosa devi fare?',
      h: 'تظهر الساعة على السبّورة. ماذا عليك أن تفعل؟\n黑板上出现时钟。你该做什么？',
      opz: [
        ['Attivarti e fare l\'esercitazione / تنطلق وتقوم بالتمرين / 行动起来，做练习', true],
        ['Aspettare la ricreazione / تنتظر الاستراحة / 等待课间休息', false],
        ['Guardare un video / تشاهد فيديو / 看视频', false]
      ]
    },
    {
      t: '4) Mentre lavori al computer, è permesso guardare YouTube?',
      h: 'أثناء العمل على الحاسوب، هل يُسمح بمشاهدة YouTube؟\n在用电脑工作时，可以看 YouTube 吗？',
      opz: [
        ['No, niente YouTube o cose che non c\'entrano / لا، ممنوع YouTube أو الأشياء غير المتعلّقة / 不行，不看 YouTube 或无关的东西', true],
        ['Sì, sempre / نعم، دائمًا / 可以，随时', false],
        ['Sì, se a basso volume / نعم، إذا كان الصوت منخفضًا / 可以，只要声音小', false]
      ]
    },
    {
      t: '5) Dove compare la nuova esercitazione da fare?',
      h: 'أين يظهر التمرين الجديد المطلوب؟\n新的练习会出现在哪里？',
      opz: [
        ['Su Google Classroom / على Google Classroom / 在 Google Classroom 上', true],
        ['Su YouTube / على YouTube / 在 YouTube 上', false],
        ['Sulla lavagna / على السبّورة / 在黑板上', false]
      ]
    },
    // ---- VERSIONING ----
    {
      t: '6) Nel numero v2.3, quale numero indica una PICCOLA modifica?',
      h: 'في الرقم v2.3، أيّ رقم يدلّ على تعديل صغير؟\n在 v2.3 中，哪个数字表示小改动？',
      opz: [
        ['Il secondo (il 3) / الثاني (الرقم 3) / 第二个（3）', true],
        ['Il primo (il 2) / الأول (الرقم 2) / 第一个（2）', false],
        ['Tutti e due / كلاهما / 两个都是', false]
      ]
    },
    {
      t: '7) Fai una piccola correzione alla versione v1.2. Come diventa?',
      h: 'تُجري تصحيحًا صغيرًا على النسخة v1.2. كيف تصبح؟\n你对 v1.2 做了一个小修正。它会变成什么？',
      opz: [ ['v1.3', true], ['v2.0', false], ['v0.2', false] ]
    },
    {
      t: '8) Dopo la v1.4 esce un cambiamento IMPORTANTE (release principale). Quale numero è giusto?',
      h: 'بعد v1.4 يصدر تغيير كبير (إصدار رئيسي). ما الرقم الصحيح؟\n在 v1.4 之后发布了一个重大更新（主版本）。正确的编号是？',
      opz: [ ['v2.0', true], ['v1.5', false], ['v1.4.1', false] ]
    },
    {
      t: '9) Cosa vuol dire "branch" (ramo)?',
      h: 'ماذا تعني كلمة «branch» (فرع)؟\n“branch”（分支）是什么意思？',
      opz: [
        ['Un ramo che si stacca per lavorare senza rompere il resto / فرع ينفصل للعمل دون كسر الباقي / 分出一个分支，独立工作而不破坏其余部分', true],
        ['Cancellare tutto il progetto / حذف المشروع كلّه / 删除整个项目', false],
        ['Spegnere il computer / إطفاء الحاسوب / 关闭电脑', false]
      ]
    },
    {
      t: '10) Cosa vuol dire "merge" (unione)?',
      h: 'ماذا تعني كلمة «merge» (دمج)؟\n“merge”（合并）是什么意思？',
      opz: [
        ['Riunire un ramo con quello principale / إعادة دمج فرع مع الفرع الرئيسي / 把一个分支合并回主分支', true],
        ['Perdere il lavoro fatto / فقدان العمل المنجز / 丢失做过的工作', false],
        ['Ricominciare da zero / البدء من الصفر / 从头再来', false]
      ]
    },
    {
      t: '11) Una versione già consegnata ai ragazzi: se cambio qualcosa, cosa faccio?',
      h: 'نسخة سُلّمت للطلاب: إذا غيّرت شيئًا، ماذا أفعل؟\n已经发给学生的版本：如果我改了东西，该怎么做？',
      opz: [
        ['Aumento (bump) il numero di versione e ne faccio una nuova / أرفع رقم النسخة وأصنع نسخة جديدة / 提高版本号，做一个新版本', true],
        ['La sovrascrivo con lo stesso nome / أستبدلها بالاسم نفسه / 用相同的名字覆盖它', false],
        ['Non serve fare niente / لا حاجة لفعل شيء / 什么都不用做', false]
      ]
    },
    {
      t: '12) Cosa significa una versione "0.x" (per esempio v0.3)?',
      h: 'ماذا تعني نسخة «0.x» (مثل v0.3)؟\n“0.x”版本（例如 v0.3）是什么意思？',
      opz: [
        ['È ancora in prova, non completa / لا تزال تجريبية غير مكتملة / 还在试验中，尚未完成', true],
        ['È la versione finale e completa / هي النسخة النهائية الكاملة / 是最终完整版本', false],
        ['È una versione rotta / هي نسخة معطوبة / 是坏掉的版本', false]
      ]
    }
  ];

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
