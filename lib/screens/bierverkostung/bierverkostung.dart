// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
// import 'package:floating_action_bubble/floating_action_bubble.dart'; //TODO: Use null safety
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/screens/bierverkostung/new_tasting.dart';
import 'package:bierverkostung/screens/bierverkostung/disp_verkostung.dart';

class Bierverkostung extends StatelessWidget {
  const Bierverkostung({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? _user = Provider.of<User?>(context);

    return StreamBuilder<List<Tasting>>(
      stream: DatabaseService(uid: _user!.uid).tastings,
      builder: (BuildContext context, AsyncSnapshot<List<Tasting>> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: '${snapshot.error}',
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (!snapshot.hasData) {
              return const Center(
                child: Text('noch keine Verkostungen vorhanden'),
              );
            }

            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    'Bier: ${snapshot.data![index].beer.beerName} Datum: ${snapshot.data![index].date.toString()}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DispTasting(
                        tasting: snapshot.data![index],
                      ),
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }
}

class BierverkostungFab extends StatelessWidget {
  const BierverkostungFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? _user = Provider.of<User?>(context);

    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => NewTasting(
            user: _user!,
          ),
        ),
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
