// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Burning Ring Of Fire Game
///
/// Displays the rules, etc
class BurningRingOfFire extends StatelessWidget {
  const BurningRingOfFire({Key? key}) : super(key: key);

  static const List<String> _types = [
    'clubs',
    'diamonds',
    'hearts',
    'spades',
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> _description = [
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_ace,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_two,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_three,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_four,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_five,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_six,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_seven,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_eight,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_nine,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_ten,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_jack,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_queen,
      AppLocalizations.of(context)!
          .drinkingGames_burningRingOfFire_description_king,
    ];

    final List<Widget> _gameDescription = [
      ListTile(
        title: Text(AppLocalizations.of(context)!.drinkingGames_generalRules),
      ),
      ListTile(
        leading: const Text('1'),
        title: Text(AppLocalizations.of(context)!
            .drinkingGames_burningRingOfFire_rules_1),
      ),
      ListTile(
        leading: const Text('2'),
        title: Text(AppLocalizations.of(context)!
            .drinkingGames_burningRingOfFire_rules_2),
      ),
      ListTile(
        leading: const Text('3'),
        title: Text(AppLocalizations.of(context)!
            .drinkingGames_burningRingOfFire_rules_3),
      ),
      ListTile(
        leading: const Text('4'),
        title: Text(AppLocalizations.of(context)!
            .drinkingGames_burningRingOfFire_rules_4),
      ),
      ListTile(
        title: Text(AppLocalizations.of(context)!
            .drinkingGames_burningRingOfFire_rules_extra),
      ),
      ListTile(
        title: Text(AppLocalizations.of(context)!.drinkingGames_materials),
      ),
      ListTile(
        leading: const Text('1'),
        title: Text(AppLocalizations.of(context)!
            .drinkingGames_burningRingOfFire_materials_1),
      ),
      ListTile(
        leading: const Text('2'),
        title: Text(AppLocalizations.of(context)!
            .drinkingGames_burningRingOfFire_materials_2),
      ),
    ];

    final String _type = _types[Random().nextInt(3)];
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        if (index < _gameDescription.length) {
          return _gameDescription[index];
        }

        index -= _gameDescription.length;
        return ListTile(
          leading: AspectRatio(
            aspectRatio: 1.45,
            child: _getCard(index, _type),
          ),
          title: Text(_description[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: _gameDescription.length + 13,
    );
  }

  /// gets the selected asset
  static SvgPicture _getCard(int number, String? type) {
    const List<String> _cards = [
      'Ace',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      'Jack',
      'Queen',
      'King',
      'Red joker',
      'Black joker',
      'Pinochle2',
    ];

    if (number < 10) {
      return SvgPicture.asset(
        'assets/playingCards/card ${_cards[number]} of $type.svg',
      );
    } else if (number < 13) {
      return SvgPicture.asset(
        'assets/playingCards/card ${_cards[number]} of ${type}2.svg',
      );
    } else {
      return SvgPicture.asset(
        'assets/playingCards/card ${_cards[number]}.svg',
      );
    }
  }
}
