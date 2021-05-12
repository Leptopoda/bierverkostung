// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/services/auth.dart';
import 'package:bierverkostung/shared/constants.dart';
import 'package:bierverkostung/shared/master_details_scaffold.dart';
import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/beers.dart';

import 'package:bierverkostung/screens/bierverkostung/new_beer.dart';

class BeerList extends StatefulWidget {
  const BeerList({
    Key? key,
  }) : super(key: key);

  @override
  _BeerListState createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> {
  Widget? child;
  String? _groupID;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  // ignore: avoid_void_async
  void getUser() async {
    final String? _groupID2 =
        await AuthService().getClaim('group_id') as String?;
    setState(() {
      _groupID = _groupID2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterDetailContainer(
      appBar: AppBar(
        title: const Text('Biere'),
      ),
      master: StreamBuilder<List<Beer>>(
        stream: DatabaseService(groupID: _groupID).beers,
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
                  );
                },
              );
          }
        },
      ),
      detail: child,
      fab: _fab(context),
    );
  }

  void _onTap(BuildContext context, Widget detail) {
    if (isMobile(context)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text('New Beer'),
            ),
            body: detail,
          ),
        ),
      );
    } else {
      setState(() {
        child = detail;
      });
    }
  }

  Widget _fab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _onTap(context, NewBeer()),
      child: const Icon(Icons.add),
    );
  }
}
