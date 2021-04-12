// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/screens/bierverkostung/new_beer.dart';

class BeerList extends StatelessWidget {
  final User user;
  const BeerList({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biere'),
      ),
      body: StreamBuilder<List<Beer>>(
        stream: DatabaseService(uid: user.uid).beers,
        builder: (BuildContext context, AsyncSnapshot<List<Beer>> snapshot) {
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
                  child: Text('noch keine Biere vorhanden'),
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
                      'Bier: ${snapshot.data![index].beerName}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context, snapshot.data![index]);
                    },
                    /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DispTasting(
                        tasting: snapshot.data![index],
                      ),
                    ),
                  ), */
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: BierverkostungFab(
        user: user,
      ),
    );
  }
}

class BierverkostungFab extends StatelessWidget {
  final User user;
  const BierverkostungFab({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => NewBeer(
            user: user,
          ),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }
}
