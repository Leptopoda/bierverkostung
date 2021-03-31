// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
// import 'package:floating_action_bubble/floating_action_bubble.dart'; //TODO: Use null safety

class Bierverkostung extends StatelessWidget {
  const Bierverkostung({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Bierverkostung'),
    );
  }
}

class BierverkostungFab extends StatelessWidget {
  const BierverkostungFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => const BierverkostungAlert(),
      ),
      child: const Icon(Icons.add),
    );
  }
}

/*
class BierverkostungFab extends StatefulWidget {
  const BierverkostungFab({Key? key}) : super(key: key);

  @override
  State<BierverkostungFab> createState() => _BierverkostungFabState();
}

class _BierverkostungFabState extends State<BierverkostungFab>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // animated floatingActionBubble
    return FloatingActionBubble(
      // Menu items
      items: <Bubble>[
        // Floating action menu item
        /* Bubble(
          title:"BierverkostungFab",
          iconColor :Colors.white,
          bubbleColor : Colors.blue,
          icon: Icons.settings,
          titleStyle:const TextStyle(fontSize: 16 , color: Colors.white),
          onPress: () {
            _animationController.reverse();
          },
        ), */
        // Floating action menu item
        Bubble(
          title: "Bier",
          iconColor: Colors.black,
          bubbleColor: Colors.amber[800],
          icon: Icons.people,
          titleStyle: const TextStyle(fontSize: 16, color: Colors.black),
          onPress: () {
            _animationController.reverse();
          },
        ),
        //Floating action menu item
        Bubble(
          title: 'Verkostung',
          iconColor: Colors.black,
          bubbleColor: Colors.amber[800],
          icon: Icons.home,
          titleStyle: const TextStyle(fontSize: 16, color: Colors.black),
          onPress: () {
            _animationController.reverse();
          },
        ),
      ],

      // animation controller
      animation: _animation,

      // On pressed change animation state
      onPress: () => _animationController.isCompleted
          ? _animationController.reverse()
          : _animationController.forward(),

      // Floating Action button Icon color
      // iconColor: Colors.blue,

      // Flaoting Action button Icon
      iconData: Icons.add,
      // backGroundColor: Colors.white,
    );
  }
}
 */

class BierverkostungAlert extends StatefulWidget {
  const BierverkostungAlert({Key? key}) : super(key: key);

  @override
  State<BierverkostungAlert> createState() => _BierverkostungAlertState();
}

class _BierverkostungAlertState extends State<BierverkostungAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Noch ein Bier"),
      content: const Text('TBA'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
