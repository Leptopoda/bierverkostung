// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/screens/drinking_games/toasts.dart';

/// Old Toasts
///
/// displays one of the old toasts and gives the ability to navigate them
class ToastsOld extends StatelessWidget {
  const ToastsOld({Key? key}) : super(key: key);

  static const List<String> _sprueche = [
    'Ein jeder weckt den Nebenmann, der Letzte stößt sich selber an.',
    'Lüft an das Gatchen, lupft an das Bein, ein jeder will der erste sein.',
    'Arschloch hoch Amerika, der Bäcker von Laboe ist da.',
    'Der Adler in die Lüfte steigt, dem Volke seine Eier zeigt.',
    'Der Gynäkologe sitzt und lauscht, wie das Urin an ihm vorbeirauscht.',
    'Den Puma fängt man mit ´ner Falle, der Puff ist keine Lesehalle.',
    'Auf X und Y gibt´s keinen Reim, im Puff riechts es nach Mösenschleim.',
    'Die Gartenbank, so klein und schmal, dem Geilen ist das ganz egal.',
    'Die Hure ist kein schlechtes Mädel, sie spielt den Seemann an dem Dödel.',
    'Ein schöner Vogel ist die Gans, der Käp´ten, der fickt ohne Schwanz.',
    'Das Schiff durch das Weltmeer segelt, es quitscht, wenn man im Wasser vögelt.',
    'Ne süße Frucht ist die Melone, ein Leichenfick ist auch nicht ohne.',
    'Der Affe kaut vom Baum die Rinde, der Schwule an der Monatsbinde.',
    'Die Kinder spielen auf dem Anker, vom Archfick wird kein Mädchen schwanger.',
    'Rotbraun ist des Rehlein Rücken, Matrosen wollen auch schon ficken.',
    'Der Fähnrich sprach zu seiner Rose, heb hoch das Hemd, laß weg die Hose.',
    'Der Bär fickt öffentlich im Zwinger, die Jungfrau heimlich mit dem Finger.',
    'Der Schwule springt von Ast zu Ast, bis ihm ein Ast in´s Arschloch paßt.',
    'Seemann prüf dein Sackgewicht, an Backbord kommt Laboe in Sicht.',
    'Der Falter in der Sonne gaukelt, die Filzlaus auf dem Sackhaar schaukelt.',
    'Schiffe kann ein jeder bau´n, was nicht paßt, wird hingehau´n.',
    'Auf jedem Schiff, was dampft und segelt, ist einer, der die Putzfrau vögelt. Und ist das Schiff auch noch so klein, die Putzfrau will gevögelt sein.',
    'Ein Neger steht am Felsenriff, und übt den neuen Wechselgriff. Er schaut hinunter auf das Meer und schiebt die Vorhaut hin und her. Und siehe da, man glaubt es kaum, auf der Nille weißer Schaum.',
    'Im Abendwind die Palmen nicken, Dragoner ihre Pferde ficken.',
    'Der Neger die Banane kaut, der Arsch hat keine Jungfernhaut.',
    'Die Uhr im Pisspott, das Schiff ist weg, unterm Finger Mösendreck. Die Heuer versoffen, vermatscht das Gehirn, von der Jungfrau verachtet, geliebt von der Dirn. Von außen vergammelt, von innen auf Draht, das ist der deutsche Marinesoldat.',
    'Fressen, scheißen und das Ficken, können nur dem Sealord glücke.',
    'Der Bär fickt öffentlich im Zwinger, der Backfisch nimmt den Mittelfinger.',
    'Hart ist der Zahn der Bisamratte, doch härter ist die Morgenlatte.',
    'Seemann leg die Riemen klar, die Waschfrau von Laboe ist da',
    'Die Palme steht im Libanon, auch Nero ornanierte dort schon.',
    'Rekruten kriechen durch den Lehm, ein Tittenfick ist auch sehr schön (bequem).',
    'Auf der Straße nach Burgrund, liegt ein totgefickter Hund. Auf der Straße Richtung Kiel, sieht man davon auch sehr viel.',
    'Wir kommen von Bord, sind die Lords der See, wir saufen nur Rum und bumsen wie eh und  je.',
    'Feuchte Möse, dicker Schwanz, nasse Augen voller Glanz.',
    'Der Moses auf dem Achterdeck, der fegt den kalten Bauern weg.',
    'Senkt die Rohre, hebt die Leiber, die Pier steht voller nackter Weiber. Bleibt liegen, der Maat hat gelogen, die Weiber sind alle angezogen.',
    'Seemann, leg die Socken klar, die Waschfrau zeigt von achtern klar.',
    'Danua war ein Perserkönig, beim dritten Mal da kommt sehr wenig.',
    'Schakale durch die Wüste ziehn, der Tripper färbt das Hemd grün.',
    'In der Straße nach Havanna liegt die totgefickte Anna. In der Straße nebenan, liegt ein Pimmel ohne Mann.',
    'Meist fängt es an mit ´nem Kuß, der Arschfick ist ein Hochgenuß.',
    'Sansibar ist eine Insel, Syphillis zerfrißt den Pinsel.',
    'Vom Regen wird man naß und nasser, die Regel ist kein Mundspülwasser.',
    'Der Gänserich, der ärgert sich, im kalten Wasser steht er nicht.',
    'Matrosen kämpfen bis zum Tod, die Hure fickt für´s tägliche Brot.',
    'Die Qualle wächst am Strand der Meere, am Arsch wächst die Klabusterbeere.',
    'Uhren an den Wänden ticken, komisch ist´s, wenn Greise ficken.',
    'Ein neues Spiel, ein neues Glück, die Vorhaut will nicht mehr zurück.',
    'Ein schöner Fisch ist der Barsch, die Zukunftsfotze ist der Arsch.',
    'Der Dachs im tiefsten Walde haust, der Dünnschiß durch die Kimme rauscht.',
    'Im Zoo man heut die Tiere gemustert, die Jungfrau wird in´s Loch geplustert.',
    'Der Maat sitzt auf des Mastes Spitze, und kaut an seiner Tripperspitze.',
    'Enten watscheln durch den Lehm, ein voller Sack ist unbequem.',
    'Die Ziege auf dem Berge Grast, die Zunge um den Kitzler rast.',
    'Der Bootsmann wollt den Käp´ten wecken, doch der war grad am Fotze lecken.',
    'Auf jedem Schiff, was schwimmt und schwabbelt, ist einer drauf, der dämlich sabbelt.',
    'Ich wache auf mit schweren Dödel, neben mir ein fremdes Mädel. Im Laken riecht es sauer, an der Wand ein kalter Bauer. Tief im Herzen Trippersorgen, so beginnt der Montagmorgen.',
    'Hohes Gras und viele Mücken, kalter Arsch und nichts zu ficken.',
    'Der Seemann auf der Koje pennt, die Filzlaus längs der Sacknaht rennt.',
    'Der Hund auf der Straß´ begattet, dem Menschen ist das nicht gestattet.',
    'Das Negerfräulein trommelt laut, des Nachts auf ihrer Jungfernhaut.',
    'An Bord da winselt laut der Hund, der Schwanz steckt schon im Muttermund.',
    'Bumsen und besoffensein ist des Seemanns Sonnenschein.',
    'Durch die Lüfte zieht ein Pfeil, Osaka macht den Opa geil.',
    'Jeden morgen frisch und munter, geht die Vorhaut rauf und runter.',
    'Vögeln ist des Seemanns Wonne, doch vögeln tut er keine Nonne.',
    'Der Adler fällt durch Büchsenschuß, der Arschfick ist ein Hochgenuß.',
    'Pistolenschüße sind meist tödlich, Periodenpisse meist rötlich.',
    'Einst war ich ein Engel, unschuldig und rein, dann kam ich zur Marine und wurde ein Schwein. Wir saufen und bürsten, wir leben wie die Fürsten.',
    'Wenn der Schwanz im Dunkeln leuchtet, war die Votze gut befeuchtet.',
    'Votzensaft am Nasenbein, zeugt von einen geilen Schwein.',
  ];

  @override
  Widget build(BuildContext context) {
    return const Toasts(
      sprueche: _sprueche,
    );
  }
}
