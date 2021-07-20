// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/screens/drinking_games/toasts.dart';

/// New Toasts
///
/// displays one of the new toasts and gives the ability to navigate them7
/// Source of the toasts: https://wein-verstehen.de/111-lustige-trinksprueche-die-dich-zum-lachen-bringen/
class ToastsNew extends StatelessWidget {
  const ToastsNew({Key? key}) : super(key: key);

  static const List<String> _sprueche = [
    "Lieber saufen bis zum abwinken, als winken bis zum Absaufen!",
    "Bist du nach dem Kotzen blind. War zu stark der Gegenwind!",
    "Wo früher meine Leber war, ist heute eine Minibar!",
    "Ein Ingenieur der nicht säuft, ist wie ein Motor der nicht läuft!",
    "Lieber einen Bauch vom Saufen, als einen Buckel vom Arbeiten!",
    "Delirium Delarium – voll wie ein Aquarium!",
    "Sternenförmig kommen wir zusammen und sternhagelvoll gehen wir auseinander!",
    "Lieber Mond Du hast es schwer, hast allen Grund zur Klage. Du bist nur zwölf Mal voll im Jahr, ich bin es alle Tage.",
    "Ich bin nicht betrunken! Ich bin von Natur aus laut, lustig und ungeschickt!",
    "Ein Mann ohne Bauch ist ein Krüppel!",
    "Ein Gläschen in Ehren kann niemand verwehren.",
    "Des kleinen Mannes Sonnenschein, ist ficken und besoffen sein.",
    "Jeder muss an etwas glauben. Ich glaub, ich trink noch Einen!",
    "Lieber in der dunkelsten Kneipe, als am hellsten Arbeitsplatz.",
    "Euch ist bekannt, was wir bedürfen, wir wollen starke Getränke schlürfen.",
    "Mich deucht, das Größt` bei einem Fest ist, wenn man sich`s wohl schmecken lässt.",
    "Von der Mitte zur Titte zum Sack, zack, zack!",
    "Ein Hund und ein Schwein, gingen eine Ehe ein und das Produkt aus diesem Bunde, sind wir versoffnen Schweinehunde.",
    "Trinken ist ein Laster – aber ein schönes.",
    "Wer Liebe mag und Einigkeit, der trinkt auch mal ne Kleinigkeit",
    "Unser letzter Wille, noch mehr Promille!",
    "Ist der Ruf erst ruiniert, säuft sich’s völlig ungeniert.",
    "Von der Wiege bis zur Bahre ist der Suff das einzig Wahre!",
    "Mein größter Feind das ist der Alkohol, doch in der Bibel steht geschrieben, du sollst auch deine Feinde lieben.",
    "Genug getrunken, jetzt wird gesoffen!",
    "Nüchtern bin ich schüchtern aber voll bin ich toll!",
    "Wo Saufen eine Ehre ist, kann Kotzen keine Schande sein!",
    "Stößchen! Wie man unter Männern sagt.",
    "Oh Alkohol, oh Alkohol, dass Du mein Feind bist weiß ich wohl, doch in der Bibel steht geschrieben, Du solltest Deine Feinde Lieben. Also Prost!",
    "Lieber besoffen und blank, als nüchtern und krank",
    "Alles Scheiße alles Mist, wenn du nicht besoffen bist.",
    "Iß, was gar ist, trink, was klar ist,red, was wahr ist. – Martin Luther",
    "Essen ist ein Bedürfnis des Magens, Trinken ein Bedürfnis der Seele. Essen ist ein gewöhnliches Handwerk, Trinken eine Kunst. – Claude Tillier",
    "Es trinkt der Mensch, es säuft das Pferd: nur heute ist es umgekehrt.",
    "Wer ordentlich ißt, soll auch gut trinken.",
    "Zu viel kann man nie trinken, doch trinkt man nie genug! Gotthold Ephraim Lessing",
    "Ob ich morgen leben werde, Weiß ich freilich nicht: Aber, wenn ich morgen lebe, Daß ich morgen trinken werde, Weiß ich ganz gewiß. Gotthold Ephraim Lessing",
    "Es tut mir im Herz so weh, wenn ich vom Glas den Boden seh.",
    "Sport ist Mord, nur Sprit hält fit.",
    "Wer tanzt hat bloß kein Geld zum Saufen.",
    "Betrunkene und Kinder sagen die Wahrheit.",
    "Das Leben ist an manchen Tagen, halt nur im Vollrausch zu ertragen.",
    "Zwischen Leber und Nierchen passt immer ein Bierchen.",
    "Morgens ein Bier und der Tag gehört Dir!",
    "Zwischen Leber und Milz passt immer noch ein Pils!",
    "Anstatt zu heizen, lieber ein Weizen!",
    "Das erste Bier, das löscht den Durst. Ein zweites stimmt mich heiter. Nach dreien ist mir alles Wurst, drum sauf’ ich einfach weiter.",
    "Melkt der Bauer seinen Stier, trank der Trottel zu viel Bier.",
    "Der Kopf tut weh, die Füße stinken. Höchste Zeit ein Bier zu trinken!",
    "Bier ist lecker, Bier ist toll, am liebsten bin ich voll!",
    "Der kluge Mensch, glaubt es mir, der redet nicht und trinkt sein Bier.",
    "Auch Wasser wird zum edlen Tropfen, mischt man es mit Malz und Hopfen.",
    "Wer Bier verschenkt, wird aufgehängt!",
    "Müde bin ich geh zur Ruh, decke meinen Bierbauch zu. Vater laß den Kater mein, morgen nicht so grausam sein. Bitte gib mir wieder Durst, alles andere ist mir Wurst.",
    "Wer Hopfen säht, wird Bier ernten. – Wolf Dietrich",
    "Flüssig Brot macht Wangen rot!",
    "Ex und hopp, in den Kopp!",
    "Da ist ja Hopfen und Malz verloren!",
    "Hol’ mir mal ne Flasche Bier, sonst streich’ ich hier! Gerhard Schröder",
    "Wenn ich Deinen Hals berühre, Deinen Mund an meinen führe, ach, wie sehn´ ich mich nach Dir, heissgeliebte Flasche Bier!",
    "Lass dich nicht lumpen, hoch den Humpen!",
    "Bierbauch? Kann ich auch!",
    "Zwischen Leber und Nierchen passt immer ein Bierchen.",
    "Morgens ein Bier und der Tag gehört Dir!",
    "Zwischen Leber und Milz passt immer noch ein Pils.",
    "Anstatt zu heizen, lieber ein Weizen!",
    "Das erste Bier, das löscht den Durst. Ein zweites stimmt mich heiter. Nach dreien ist mir alles Wurst, drum sauf’ ich einfach weiter.",
    "Melkt der Bauer seinen Stier, trank der Trottel zu viel Bier.",
    "Der Kopf tut weh, die Füße stinken. Höchste Zeit ein Bier zu trinken!",
    "Bier ist lecker, Bier ist toll, am liebsten bin ich voll!",
    "Der kluge Mensch, glaubt es mir, der redet nicht und trinkt sein Bier.",
    "Auch Wasser wird zum edlen Tropfen, mischt man es mit Malz und Hopfen.",
    "Wer Bier verschenkt, wird aufgehängt!",
    "Müde bin ich geh zur Ruh, decke meinen Bierbauch zu. Vater laß den Kater mein, morgen nicht so grausam sein. Bitte gib mir wieder Durst, alles andere ist mir Wurst.",
    "Wer Hopfen säht, wird Bier ernten. – Wolf Dietrich",
    "Flüssig Brot macht Wangen rot!",
    "Ex und hopp, in den Kopp!",
    "Da ist ja Hopfen und Malz verloren!",
    "Hol’ mir mal ne Flasche Bier, sonst streich’ ich hier! – Gerhard Schröder",
    "Wenn ich Deinen Hals berühre, Deinen Mund an meinen führe, ach, wie sehn´ ich mich nach Dir, heissgeliebte Flasche Bier!",
    "Lass dich nicht lumpen, hoch den Humpen!",
    "Bierbauch? Kann ich auch!",
    "Lasst uns froh das Glas erheben, unser Jubilar soll leben – sorgenfrei und voll Genuss – dass ist möglich, nein, ein Muss! – Lisl Güthoff",
    "Hoch die Gläser, hoch die Tassen, jeder soll den Nachbarn fassen. Lasst die Sorgen mal zu Haus und geht fröhlich aus euch raus! – Lisl Güthoff",
    "Frohes Fest und schöne Tage, einen Wein von bester Lage. Braten, Torten und Kaffee Gäste aus der Fern` und Näh`! – Lisl Güthoff",
    "Geburtstag, sei mir willkommen! Und fröhlich will ich an dir sein, das hab ich mir recht vorgenommen, und trinken Wein, und trinken Wein und singen Lieder – aber Geburtstag, komm doch noch wieder. – Matthias Claudius",
    "Lasset die vollen Gläser erklingen ein Lebehoch dem Freund zu bringen: schenket nochmal die Gläser voll, trinket auf des Freundes Wohl!",
    "Ein Festtag soll dich stärken zu deines Werktags Werken, dass du an dein Geschäfte mitbringest frische Kräfte. Friedrich Rückert",
    "Wenn Geburtstagsfreuden winken, kann man ruhig mal etwas trinken. Im Wein liegt Wahrheit sagt der Brauch, drum halt dich dran und tu es auch!",
    "Dies für den und das für jenen. Viele Tische sind gedeckt. Keine Zunge soll verhöhnen, was der andern Zunge schmeckt. Lass jedem seine Freuden, gönn ihm, dass er sich erquickt, wenn er sittsam und bescheiden auf den eignen Teller blickt. Wenn jedoch bei deinem Tisch er unverschämt dich neckt und stört, dann so gib ihm einen Wischer, dass er merkt, was sich gehört. – Wilhelm Busch",
    "Es ist halt schön, wenn wir die Freunde kommen sehn. Schön ist es ferner, wenn sie bleiben und sich mit uns die Zeit vertreiben. – Doch wenn sie schließlich wieder gehen, ist`s auch recht schön. – Wilhelm Busch",
    "Sauf bis dir der Nabel glänzt, hell wie ein Karfunkel, damit du eine Leuchte hast in deines Daseins Dunkel.",
    "Ich trinke, um meine Probleme zu ertränken, aber diese verdammten Bastarde können schwimmen!",
    "Der Wein hält nichts geheim.",
    "Das Leben ist zu kurz, um schlechten Wein zu trinken!",
    "Es gibt mehr alte Weintrinker, als alte Ärzte. (➤Rotwein ist gesund)",
    "Ergreift das Glas und trinkt den Wein, ein jeder Mensch soll glücklich sein!",
    "Das Wasser ist des Ochsen Kraft, der Mensch trinkt Wein und Gerstensaft. Drum stoß ich an mit Bier und Wein, wer möchte schon ein Ochse sein.",
    "Wasser macht weise, fröhlich der Wein, drum trinke sie beide, um beides zu sein.",
    "Der liebe Gott hat nicht gewollt, dass edler Rebensaft verderben sollt drum hat er uns nicht nur die Reben, sondern auch den Durst gegeben!",
    "Für Sorgen sorgt das liebe Leben und Sorgenbrecher sind die Reben – Johann Wolfgang von Goethe",
    "Sauf´ ma – sterb´ ma sauf´ ma net – sterb´n ma a, oiso – sauf´ ma!",
    "Isch bin Pfälzer, Gott sei Dank, denn käm ich aus em onnre Lond, un misst aus kleene Gläser dringe, isch glaab des dät mer gonz schää schdinge!",
    "Bauern verkaufts eichre Kia, donn kennst so saufn wia mia.",
    "Hätt’ da Adam a boarisches Bier bsess’n, Hätt er den Apfel niemals gess’n!",
    "S Glas in’d Hand, zum Wohl mitnand!",
    "Mach’s Maul ned unnütz auf, Red’ was g’scheites oder sauf!",
    "An Meter vor an Meter z’ruck an Meter obe an Meter aufa jetzt sauf ma!",
    "Gott erfand den Wein, Gott erfand das Bier, doch den Schnaps den brannten wir.",
    "Erinnerungslücken sind der Hauptgewinn am Boden einer jeden Wodkaflasche.",
    "Kommt die Schwiegermutter mal ins Haus Und rutscht sie auf dem Hausgang aus Macht sie dann sogleich wieder kehrt Des is a Schnapserl wert!",
    "Wir trinken Schnaps, wir trinken Wein im Sitzen, Stehen und Liegen. Und wenn wir einmal Engel sind, dann trinken wir im Fliegen.",
    "Caipi, Beck’s und Jägermeister das sind unsere Lebensgeister – Christoph Bräkling",
    "Es gibt zwei Dinge, die ein Highlander nackt mag, und eine davon ist Malt Whisky.",
    "Whisky löst keine Probleme! Das tut Milch aber auch nicht.",
    "Ein Glas ist fabelhaft, zwei sind zu viel, und drei zu wenig. Schnaps, du edler Goetterfunke, Schlingel aus Elysium, nieder mit dir, du Halunke! Runter in dein Tuskulum.",
    "Auf die Männer, die wir lieben und die Penner, die wir kriegen!",
    "Es lebe die Liebe, das Bier und der Suff, der uneheliche Beischlaf, der Papst und das Puff! PROST!",
    "Benediktum, benedaktum, in Afrika rennnen die Frauen nackt rum. Bei uns da tragen sie Kleider. Leider! Doch laßt den Mut nicht sinken! Wir wollen noch ordentlich trinken!",
    "Prost, Prost, Prösterchen Wir gehen heut ins Klösterchen und machen aus den Päterchen alles kleine Väterchen.",
    "In diesem Sinne, ab in die Rinne!",
    "Hau wech die Scheiße!",
    "Prost ihr Säcke! Prost du Sack!",
    "So jung, kommen wir nie wieder zusammen",
    "Essen nimmt, Trinken gibt Enthusiasmus. – Jean Paul",
    "Auf die Weiber! Zack! Zack! Zack!",
    "Prostata!",
    "Der Durst kommt beim Trinken.",
    "Dieses Glas dem guten Geist. – Friedrich Schiller",
    "Nich‘ lang schnacken, Kopp innen Nacken!",
  ];

  @override
  Widget build(BuildContext context) {
    return const Toasts(
      sprueche: _sprueche,
    );
  }
}
