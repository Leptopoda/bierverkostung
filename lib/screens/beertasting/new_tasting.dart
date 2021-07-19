// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/tastings.dart';

/// Screen to add a new Beer
///
/// It exposes the fields of a [Tasting] into a UI
class NewTasting extends StatefulWidget {
  const NewTasting({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewTastingState();
}

class _NewTastingState extends State<NewTasting> {
  late DateTime _selectedDate;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _beerName = TextEditingController();
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

  Beer? _beer;

  int _colourEbc = 4;
  int _foamStability = 1;
  int _bitternessRating = 1;
  int _sweetnessRating = 1;
  int _acidityRating = 1;
  int _fullBodiedRating = 1;
  int _aftertasteRating = 1;
  int _totalImpressionRating = 1;

  static const List<int?> _ebc = [
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
    _beerName.dispose();
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
    final TextStyle? _heading = Theme.of(context).textTheme.headline5;
    final TextStyle? _text = Theme.of(context).textTheme.bodyText2;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.beertasting_newTasting),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(30.0),
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.beertasting_general,
              style: _heading,
            ),
            // InputDatePickerFormField(firstDate: DateTime(2015), lastDate: DateTime(2100)),
            TextFormField(
              style: _text,
              readOnly: true,
              controller: _dateController,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beertasting_date,
                suffixIcon: const Icon(Icons.calendar_today_outlined),
              ),
            ),
            TextFormField(
              style: _text,
              controller: _location,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beertasting_location,
                suffixIcon: const Icon(Icons.location_on_outlined),
              ),
            ),
            TextFormField(
              style: _text,
              readOnly: true,
              controller: _beerName,
              onTap: () => _selectBeer(context),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beerOne,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.form_required;
                }
                return null;
              },
            ),
            Text(
              AppLocalizations.of(context)!.beertasting_opticalAppearence,
              style: _heading,
            ),
            TextFormField(
              style: _text,
              controller: _foamColour,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beertasting_foamColour,
                suffixIcon: const Icon(Icons.color_lens_outlined),
              ),
            ),
            TextFormField(
              style: _text,
              controller: _foamStructure,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.beertasting_foamStructure,
              ),
            ),
            Text(AppLocalizations.of(context)!.beertasting_foamStability),
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
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beertasting_beerColour,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _beerColourDesc,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.beertasting_colorDescription,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _clarity,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beertasting_clarity,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.beertasting_taste,
              style: _heading,
            ),
            TextFormField(
              style: _text,
              controller: _mouthFeelDesc,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beertasting_mmouthFeel,
              ),
            ),
            Text(AppLocalizations.of(context)!.beertasting_bitterness),
            Slider(
              value: _bitternessRating.toDouble(),
              // min: 0,
              max: 3,
              divisions: 3,
              label: '$_bitternessRating',
              onChanged: (double value) =>
                  setState(() => _bitternessRating = value.round()),
            ),
            Text(AppLocalizations.of(context)!.beertasting_sweetness),
            Slider(
              value: _sweetnessRating.toDouble(),
              // min: 0,
              max: 3,
              divisions: 3,
              label: '$_sweetnessRating',
              onChanged: (double value) =>
                  setState(() => _sweetnessRating = value.round()),
            ),
            Text(AppLocalizations.of(context)!.beertasting_acidity),
            Slider(
              value: _acidityRating.toDouble(),
              // min: 0,
              max: 3,
              divisions: 3,
              label: '$_acidityRating',
              onChanged: (double value) =>
                  setState(() => _acidityRating = value.round()),
            ),
            Text(AppLocalizations.of(context)!.beertasting_bodyFullness),
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
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.beertasting_bodyDescription,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _aftertasteDesc,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beertasting_aftertaste,
              ),
            ),
            Text(AppLocalizations.of(context)!.beertasting_aftertasteRating),
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
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.beertasting_foodRecomendation,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.beertasting_conclusion,
              style: _heading,
            ),
            TextFormField(
              style: _text,
              controller: _totalImpressionDesc,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!
                      .beertasting_totalImpression),
            ),
            Text(AppLocalizations.of(context)!.beertasting_totalRating),
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
              child: Text(AppLocalizations.of(context)!.form_submit),
            ),
          ],
        ),
      ),
    );
  }

  /// validates the inputs and submits them to FireStore
  Future<void> _submit(BuildContext context) async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.loading_processingData),
        ),
      );
      _formKey.currentState!.save();

      final Tasting _tasting = Tasting(
        beer: _beer!,
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
      await DatabaseService.saveTasting(_tasting);

      Navigator.of(context).pop();
    }
  }

  /// Calls [DispBeer] to select a [Beer]
  Future<void> _selectBeer(BuildContext context) async {
    _beer = await Navigator.pushNamed<Beer?>(context, '/BeerList');

    if (_beer != null) {
      setState(() {
        _beerName.text = _beer!.beerName;
      });
    }
  }

  /// Selects a date from DatePicker
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
