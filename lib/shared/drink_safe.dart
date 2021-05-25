// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/services/local_storage.dart';

Future<void> drinkResponsible(BuildContext context) async {
  final bool? drinkResponsibleShown =
      await LocalDatabaseService().getDrinkResponsible();
  if (drinkResponsibleShown == true) {
    return;
  }
  return showDialog(
    context: context,
    builder: (BuildContext _) => AlertDialog(
      title: const Text('Drink Safe!'),
      content: const SingleChildScrollView(
        child: Text(
          'This can be a lot of fun. Any children’s game can essentially be made into something that involves drinking. While these games are fun, we must remember to drink responsibly and even hand over the keys, order a Lyft/Uber to get home, or have someone who is the designated driver available to you. '
          'That being said, not everyone drinks, so you shouldn’t force it upon him or her. If they want to partake in the game as well (because it will be fun, drinking or not), you’ll want to offer them something else to drink, water, soda, nonalcoholic versions of what everyone else is drinking, etc. '
          'It doesn’t have to be limited to just those who are “partying” someone has to be responsible or maybe they are Sober, and that’s okay too. No one has to be left out. '
          'Have fun and if you are looking for a few more ideas, just get creative and make some up that are more relevant to your group of people and let us know about your ideas.',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            LocalDatabaseService().setDrinkResponsible();
            Navigator.of(context).pop();
          },
          child: const Text("Don't show again"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Continue'),
        ),
      ],
    ),
  );
}

Future<void> drinkSafe(BuildContext context) async {
  final bool? drinkResponsibleShown =
      await LocalDatabaseService().getDrinkSafe();
  if (drinkResponsibleShown == true) {
    return;
  }
  return showDialog(
    context: context,
    builder: (BuildContext _) => AlertDialog(
      title: const Text('Drink Safe!'),
      // TODO: change message
      content: const SingleChildScrollView(
        child: Text(
          'This can be a lot of fun. Any children’s game can essentially be made into something that involves drinking. While these games are fun, we must remember to drink responsibly and even hand over the keys, order a Lyft/Uber to get home, or have someone who is the designated driver available to you. '
          'That being said, not everyone drinks, so you shouldn’t force it upon him or her. If they want to partake in the game as well (because it will be fun, drinking or not), you’ll want to offer them something else to drink, water, soda, nonalcoholic versions of what everyone else is drinking, etc. '
          'It doesn’t have to be limited to just those who are “partying” someone has to be responsible or maybe they are Sober, and that’s okay too. No one has to be left out. '
          'Have fun and if you are looking for a few more ideas, just get creative and make some up that are more relevant to your group of people and let us know about your ideas.',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            LocalDatabaseService().setDrinkSafe();
            Navigator.of(context).pop();
          },
          child: const Text("Don't show again"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Continue'),
        ),
      ],
    ),
  );
}
