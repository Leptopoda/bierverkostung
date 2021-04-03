// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/tastings.dart';

class NewTasting extends StatefulWidget {
  final User user;

  const NewTasting({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewTastingState();
}

class _NewTastingState extends State<NewTasting> {
  late DateTime _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  static const TextStyle _heading =
      TextStyle(fontSize: 22, color: Colors.yellow);
  static const TextStyle _text = TextStyle(fontSize: 18);

  final Tasting _tasting = Tasting();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _selectedDate = DateTime.now();
    _dateController.text = DateFormat.yMMMMd().format(_selectedDate);
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neue Verkostung'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(30.0),
          children: <Widget>[
            const Text(
              'General',
              style: _heading,
            ),
            TextFormField(
              style: _text,
              readOnly: true,
              controller: _dateController,
              onTap: () => _selectDate(context),
              decoration: const InputDecoration(
                labelText: 'Date',
                suffixIcon: Icon(Icons.calendar_today_outlined),
              ),
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Location',
                suffixIcon: Icon(Icons.location_on_outlined),
              ),
              onSaved: (String? value) => _tasting.location = value,
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Bier',
              ),
              onSaved: (String? value) {
                final Beer _bier1 = Beer(
                  beerName: value!,
                );
                _tasting.beer = _bier1;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pflichtfeld';
                }
                return null;
              },
            ),
            const Text(
              'Optical Appearance',
              style: _heading,
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Foam Colour',
                suffixIcon: Icon(Icons.color_lens_outlined),
              ),
              onSaved: (String? value) => _tasting.foamColour = value,
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Foam Structure',
              ),
              onSaved: (String? value) => _tasting.foamStructure = value,
            ),
            const Text('Foam Stability'),
            Slider(
              value: _tasting.foamStability.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '${_tasting.foamStability}',
              onChanged: (double value) =>
                  setState(() => _tasting.foamStability = value.round()),
            ),
            DropdownButtonFormField(
              value: _tasting.colourEbc,
              items: <int>[
                4,
                6,
                8,
                12,
                16,
                20,
                26,
                33,
                39,
                47,
                57,
                69,
                79,
              ].map<DropdownMenuItem<int>>(
                (int val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text('$val'),
                  );
                },
              ).toList(),
              onChanged: (int? val) => setState(() => _tasting.colourEbc = val!),
              decoration: const InputDecoration(
                labelText: 'EBC',
                // icon: Icon(Icons.calendar_today),
              ),
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Beer Colour',
              ),
              onSaved: (String? value) => _tasting.beerColour = value,
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Color Description',
              ),
              onSaved: (String? value) => _tasting.beerColourDesc = value,
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Clarity',
              ),
              onSaved: (String? value) => _tasting.clarity = value,
            ),
            const Text(
              'Taste',
              style: _heading,
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Mundgefühl',
              ),
              onSaved: (String? value) => _tasting.mouthFeelDesc = value,
            ),
            const Text('Bitterness'),
            Slider(
              value: _tasting.bitternessRating.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '${_tasting.bitternessRating}',
              onChanged: (double value) =>
                  setState(() => _tasting.bitternessRating = value.round()),
            ),
            const Text('Sweetness'),
            Slider(
              value: _tasting.sweetnessRating.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '${_tasting.sweetnessRating}',
              onChanged: (double value) =>
                  setState(() => _tasting.sweetnessRating = value.round()),
            ),
            const Text('Acidity'),
            Slider(
              value: _tasting.acidityRating.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '${_tasting.acidityRating}',
              onChanged: (double value) =>
                  setState(() => _tasting.acidityRating = value.round()),
            ),
            const Text('Body Fullness'),
            Slider(
              value: _tasting.fullBodiedRating.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '${_tasting.fullBodiedRating}',
              onChanged: (double value) =>
                  setState(() => _tasting.fullBodiedRating = value.round()),
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Body Description',
              ),
              onSaved: (String? value) => _tasting.bodyDesc = value,
            ),
            TextFormField(
              // TODO: add intensity
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Nachgeschmack',
              ),
              onSaved: (String? value) => _tasting.aftertasteDesc = value,
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Food Recomendation',
              ),
              onSaved: (String? value) => _tasting.foodRecommendation = value,
            ),
            const Text(
              'Conclusion',
              style: _heading,
            ),
            TextFormField(
              style: _text,
              decoration: const InputDecoration(
                labelText: 'Total Impression',
              ),
              onSaved: (String? value) => _tasting.totalImpressionDesc = value,
            ),
            const Text('Total Rating'),
            Slider(
              value: _tasting.totalImpressionRating.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '${_tasting.totalImpressionRating}',
              onChanged: (double value) =>
                  setState(() => _tasting.totalImpressionRating = value.round()),
            ),
            ElevatedButton(
              onPressed: () => _submit(context),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Processing Data')));
      _formKey.currentState!.save();
      _tasting.date = _selectedDate;
      await DatabaseService(uid: widget.user.uid).saveTasting(_tasting);

      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(
        () {
          _selectedDate = picked;
          _dateController.text = DateFormat.yMMMMd().format(_selectedDate);
        },
      );
    }
  }
}
