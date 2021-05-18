// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BurningRingOfFire extends StatelessWidget {
  const BurningRingOfFire({Key? key}) : super(key: key);

  static const List<String> _types = [
    'clubs',
    'diamonds',
    'hearts',
    'spades',
  ];

  static const List<String> _description = [
    'Waterfall - The person who picked the card will ask a question to his neighbours. The person answering it faster will decide the direction. Now everyone should keep drinking until the person next to you stops',
    'You - Pick someone to drink.',
    'Me - You must drink.',
    'Floor - When you put your hand on the table everyone must follow and whomever is last must drink. You are the floor master till someone else picks a four.',
    'Guys - All guys drink.',
    'Chicks - All girls must drink.',
    'Heaven - Point your finger in the sky, whoever is last must drink.',
    'Mate - Chose a drinking mate who has to drink with you every time.',
    'Rhyme - Pick a word such as and the person next to you must rhyme with that word, this goes on to the next person and the next, in a circle, until someone messes up and he or she will have to drink. You have to know atleast two rhymes yourself!',
    'Never have I ever - Play a round "Never have I ever ...", whoever has done it must drink.',
    'Make a Rule – You can make up any rule that everyone has to follow, such as you can only drink with your left hand. Everyone (including you) must follow this rule for the whole entire game and if you disobey you must drink.',
    'Questionmaster - The person who picked the card is now the questionmaster. Whoever answers a question of this person shall drink. ou are the questionmaster till someone else picks a queen',
    'Snake Eyes - Whoever picks this card has ‘snake eyes’. Whenever they make eye contact with another player throughout the game, that player must drink.',
  ];

  @override
  Widget build(BuildContext context) {
    final String _type = _types[Random().nextInt(3)];
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: _getCard(index, _type),
          title: Text(_description[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: 13,
    );
  }

  SvgPicture _getCard(int number, String? type) {
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
    return SvgPicture.asset(
      'assets/playingCards/Ace of hearts.svg',
    );
    if (number < 10) {
      print('assets/playingCards/${_cards[number]} of $type.svg');
      return SvgPicture.asset(
        'assets/playingCards/${_cards[number]} of $type.svg',
      );
    } else if (number < 13) {
      return SvgPicture.asset(
        'assets/playingCards/${_cards[number]} of ${type}2.svg',
      );
    } else {
      return SvgPicture.asset(
        'assets/playingCards/${_cards[number]}.svg',
      );
    }
  }
}
