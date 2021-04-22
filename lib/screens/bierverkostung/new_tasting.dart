// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart' show Provider;

import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/models/users.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/tastings.dart';

class NewTasting extends StatefulWidget {
  const NewTasting({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewTastingState();
}

class _NewTastingState extends State<NewTasting> {
  late DateTime _selectedDate;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _beer = TextEditingController();
  final TextEditingController _beerColour = TextEditingController();
  final TextEditingController _beerColourDesc = TextEditingController();
  final TextEditingController _clarity = TextEditingController();
  final TextEditingController _foamColour = TextEditingController();
  final TextEditingController _foamStructure = TextEditingController();
  final TextEditingController _mouthFeelDesc = TextEditingController();
  final TextEditingController _bodyDesc = TextEditingController();
  final TextEditingController _aftertasteDesc = TextEditingController();
  final TextEditingController _foodRecommendation = TextEditingController();
  final TextEditingController _totalImpressionDesc = TextEditingController();

  static const TextStyle _heading = TextStyle(
    fontSize: 22,
    color: Colors.yellow,
  );
  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  int _colourEbc = 4;
  int _foamStability = 1;
  int _bitternessRating = 1;
  int _sweetnessRating = 1;
  int _acidityRating = 1;
  int _fullBodiedRating = 1;
  int _aftertasteRating = 1;
  int _totalImpressionRating = 1;

  final List<int?> _ebc = [
    null,
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
  ];

  @override
  void initState() {
    _selectedDate = DateTime.now();
    _dateController.text = DateFormat.yMMMMd().format(_selectedDate);
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _location.dispose();
    _beer.dispose();
    _beerColour.dispose();
    _beerColourDesc.dispose();
    _clarity.dispose();
    _foamColour.dispose();
    _foamStructure.dispose();
    _mouthFeelDesc.dispose();
    _bodyDesc.dispose();
    _aftertasteDesc.dispose();
    _foodRecommendation.dispose();
    _totalImpressionDesc.dispose();
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
            // InputDatePickerFormField(firstDate: DateTime(2015), lastDate: DateTime(2100)),
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
              controller: _location,
              decoration: const InputDecoration(
                labelText: 'Location',
                suffixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
            TextFormField(
              style: _text,
              readOnly: true,
              controller: _beer,
              onTap: () => _selectBeer(context),
              decoration: const InputDecoration(
                labelText: 'Bier',
              ),
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
              controller: _foamColour,
              decoration: const InputDecoration(
                labelText: 'Foam Colour',
                suffixIcon: Icon(Icons.color_lens_outlined),
              ),
            ),
            TextFormField(
              style: _text,
              controller: _foamStructure,
              decoration: const InputDecoration(
                labelText: 'Foam Structure',
              ),
            ),
            const Text('Foam Stability'),
            Slider(
              value: _foamStability.toDouble(),
              // min: 0,
              max: 3,
              divisions: 3,
              label: '$_foamStability',
              onChanged: (double value) =>
                  setState(() => _foamStability = value.round()),
            ),
            DropdownButtonFormField(
              value: _colourEbc,
              items: _ebc.map<DropdownMenuItem<int>>(
                (int? val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text('$val'),
                  );
                },
              ).toList(),
              onChanged: (int? val) => setState(() => _colourEbc = val!),
              decoration: InputDecoration(
                labelText: 'EBC',
                suffixIcon: Icon(
                  Icons.circle,
                  color: Colors.yellow[800],
                ),
              ),
            ),
            TextFormField(
              style: _text,
              controller: _beerColour,
              decoration: const InputDecoration(
                labelText: 'Beer Colour',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _beerColourDesc,
              decoration: const InputDecoration(
                labelText: 'Color Description',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _clarity,
              decoration: const InputDecoration(
                labelText: 'Clarity',
              ),
            ),
            const Text(
              'Taste',
              style: _heading,
            ),
            TextFormField(
              style: _text,
              controller: _mouthFeelDesc,
              decoration: const InputDecoration(
                labelText: 'Mundgefühl',
              ),
            ),
            const Text('Bitterness'),
            Slider(
              value: _bitternessRating.toDouble(),
              // min: 0,
              max: 3,
              divisions: 3,
              label: '$_bitternessRating',
              onChanged: (double value) =>
                  setState(() => _bitternessRating = value.round()),
            ),
            const Text('Sweetness'),
            Slider(
              value: _sweetnessRating.toDouble(),
              // min: 0,
              max: 3,
              divisions: 3,
              label: '$_sweetnessRating',
              onChanged: (double value) =>
                  setState(() => _sweetnessRating = value.round()),
            ),
            const Text('Acidity'),
            Slider(
              value: _acidityRating.toDouble(),
              // min: 0,
              max: 3,
              divisions: 3,
              label: '$_acidityRating',
              onChanged: (double value) =>
                  setState(() => _acidityRating = value.round()),
            ),
            const Text('Body Fullness'),
            Slider(
              value: _fullBodiedRating.toDouble(),
              // min: 0,
              max: 3,
              divisions: 3,
              label: '$_fullBodiedRating',
              onChanged: (double value) =>
                  setState(() => _fullBodiedRating = value.round()),
            ),
            TextFormField(
              style: _text,
              controller: _bodyDesc,
              decoration: const InputDecoration(
                labelText: 'Body Description',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _aftertasteDesc,
              decoration: const InputDecoration(
                labelText: 'Nachgeschmack',
              ),
            ),
            const Text('Nachgeschmack rating'),
            Slider(
              value: _aftertasteRating.toDouble(),
              // min: 0,
              max: 3,
              divisions: 3,
              label: '$_aftertasteRating',
              onChanged: (double value) =>
                  setState(() => _aftertasteRating = value.round()),
            ),
            TextFormField(
              style: _text,
              controller: _foodRecommendation,
              decoration: const InputDecoration(
                labelText: 'Food Recomendation',
              ),
            ),
            const Text(
              'Conclusion',
              style: _heading,
            ),
            TextFormField(
              style: _text,
              controller: _totalImpressionDesc,
              decoration: const InputDecoration(
                labelText: 'Total Impression',
              ),
            ),
            const Text('Total Rating'),
            Slider(
              value: _totalImpressionRating.toDouble(),
              min: 1,
              max: 3,
              divisions: 2,
              label: '$_totalImpressionRating',
              onChanged: (double value) =>
                  setState(() => _totalImpressionRating = value.round()),
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
    final UserData _user = Provider.of<UserData?>(context, listen: false)!;
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Processing Data')));
      _formKey.currentState!.save();

      final Beer _bier1 = Beer(
        beerName: _beer.value.text,
      );

      final Tasting _tasting1 = Tasting(
        beer: _bier1,
        date: _selectedDate,
        location: _location.value.text,
        beerColour: _beerColour.value.text,
        beerColourDesc: _beerColourDesc.value.text,
        colourEbc: _colourEbc,
        clarity: _clarity.value.text,
        foamColour: _foamColour.value.text,
        foamStructure: _foamStructure.value.text,
        foamStability: _foamStability,
        bitternessRating: _bitternessRating,
        sweetnessRating: _sweetnessRating,
        acidityRating: _acidityRating,
        mouthFeelDesc: _mouthFeelDesc.value.text,
        fullBodiedRating: _fullBodiedRating,
        bodyDesc: _bodyDesc.value.text,
        aftertasteDesc: _aftertasteDesc.value.text,
        aftertasteRating: _aftertasteRating,
        foodRecommendation: _foodRecommendation.value.text,
        totalImpressionDesc: _totalImpressionDesc.value.text,
        totalImpressionRating: _totalImpressionRating,
      );

      await DatabaseService(user: _user).saveTasting(_tasting1);

      Navigator.of(context).pop();
    }
  }

  Future<void> _selectBeer(BuildContext context) async {
    final Beer? _beer1 = await Navigator.pushNamed<Beer?>(context, '/BeerList');

    if (_beer1 != null) {
      setState(() {
        _beer.text = _beer1.beerName;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(
        () {
          _selectedDate = _picked;
          _dateController.text = DateFormat.yMMMMd().format(_selectedDate);
        },
      );
    }
  }
}
