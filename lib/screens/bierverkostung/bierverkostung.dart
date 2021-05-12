// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/shared/constants.dart';
import 'package:bierverkostung/shared/master_details_scaffold.dart';

import 'package:bierverkostung/screens/conference/conference.dart';
import 'package:bierverkostung/screens/promille_rechner/promille_rechner.dart';
import 'package:bierverkostung/screens/settings/settings_button.dart';
import 'package:bierverkostung/screens/bierverkostung/disp_verkostung.dart';
import 'package:bierverkostung/screens/bierverkostung/new_tasting.dart';

class Bierverkostung extends StatefulWidget {
  const Bierverkostung({Key? key}) : super(key: key);

  @override
  _BierverkostungState createState() => _BierverkostungState();
}

class _BierverkostungState extends State<Bierverkostung> {
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
    if (_groupID != null) {
      return MasterDetailContainer(
        master: StreamBuilder<List<Tasting>>(
          stream: DatabaseService(groupID: _groupID).tastings,
          builder:
              (BuildContext context, AsyncSnapshot<List<Tasting>> snapshot) {
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
                        'Bier: ${snapshot.data![index].beer.beerName} Datum: ${snapshot.data![index].date}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      onTap: () => _onTap(
                        context,
                        DispTasting(tasting: snapshot.data![index]),
                      ),
                    );
                  },
                );
            }
          },
        ),
        detail: child,
        appBar: AppBar(
          title: const Text('Bierverkostung'),
          actions: const <Widget>[
            MeetingButton(),
            PromilleRechnerButton(),
            SettingsButton(),
          ],
        ),
        fab: _fab(context),
      );
    } else {
      return const Text('loading');
    }
  }

  void _onTap(BuildContext context, Widget detail) {
    if (isMobile(context)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text('New Tasting'),
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
      onPressed: () => _onTap(context, const NewTasting()),
      child: const Icon(Icons.add),
    );
  }
}
