// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:flutter/material.dart';

class TastingTest extends StatelessWidget {
  const TastingTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Tasting test = Tasting(
      beer: const Beer(beerName: 'beerName'),
      date: DateTime.now(),
    );
    return EditableListView(
      tasting: test,
    );
  }
}

class EditableListView extends StatefulWidget {
  final Tasting? tasting;
  const EditableListView({
    this.tasting,
    Key? key,
  }) : super(key: key);

  @override
  _EditableListViewState createState() => _EditableListViewState();
}

class _EditableListViewState extends State<EditableListView> {
  late bool readOnly;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.tasting?.beer.beerName);

    if (widget.tasting == null) {
      setState(() => readOnly = false);
    } else {
      setState(() => readOnly = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('beertasting'),
        actions: [
          if (readOnly)
            IconButton(
              tooltip: 'edit tasting',
              onPressed: () => setState(() => readOnly = false),
              icon: const Icon(Icons.edit_outlined),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              const Text('hallo'),
              TextFormField(
                style: const TextStyle(fontSize: 20),
                readOnly: readOnly,
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'lable',
                ),
              ),
              if (!readOnly)
                ElevatedButton(
                  onPressed: () => setState(() => readOnly = true),
                  child: const Text('submit'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
