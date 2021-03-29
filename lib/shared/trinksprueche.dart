// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:math';

class Trinksprueche extends StatefulWidget {
  final List<String> sprueche;

  Trinksprueche({required this.sprueche});

  @override
  State<Trinksprueche> createState() => _TrinkspruecheState();
}

class _TrinkspruecheState extends State<Trinksprueche> {
  static int _index = 1;

  void randomIndex() {
    setState(() {
      _index = Random().nextInt(widget.sprueche.length) + 1;
    });
  }

  void lastIndex() {
    if (_index > 1) {
      setState(() {
        _index--;
      });
    }
  }

  void nextIndex() {
    if (_index < widget.sprueche.length) {
      setState(() {
        _index++;
      });
    }
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    randomIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trinksprüche'),
      ),
      body: ListView(
        // padding: const EdgeInsets.all(20.0),
        children: [
          Container(
            margin: EdgeInsets.all(30.0),
            // constraints: BoxConstraints(minHeight: 100),
            child: Center(
              child: Text(widget.sprueche[_index - 1],
                  style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              child: const Text('Zurück'),
              onPressed: () => lastIndex(),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              child: const Text('Weiter'),
              onPressed: () => nextIndex(),
            ),
          ]),
          const SizedBox(height: 16),
          Center(
            child: const Text('Bestimmte Zahl?'),
          ),
          const SizedBox(height: 16),
          Slider(
            value: _index.toDouble(),
            min: 1,
            max: widget.sprueche.length.toDouble(),
            onChanged: (double value) => setState(() => _index = value.round()),
            divisions: widget.sprueche.length - 1,
            label: "$_index",
          ),
          const SizedBox(height: 16),
          Center(
            child: const Text('Zufällige Zahl?'),
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.all(30.0),
            child: ElevatedButton(
              child: const Text('Random'),
              onPressed: () => randomIndex(),
            ),
          ),
        ],
      ),
    );
  }
}
