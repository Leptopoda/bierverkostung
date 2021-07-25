// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

// TODO: fix assertion controller OR initial value == null,
// probably set the initial value via the controller

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/screens/beertasting/color_to_ebc.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/tastings.dart';

/// Screen to add a new Beer
///
/// It exposes the fields of a [Tasting] into a UI
@Deprecated('we only use [TastingInfoList]')
class NewTasting extends StatelessWidget {
  const NewTasting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).beertasting_newTasting),
      ),
      body: const SingleChildScrollView(child: TastingInfoList()),
    );
  }
}

class TastingInfoList extends StatefulWidget {
  final Tasting? tasting;
  const TastingInfoList({
    this.tasting,
    Key? key,
  }) : super(key: key);

  @override
  _TastingInfoListState createState() => _TastingInfoListState();
}

class _TastingInfoListState extends State<TastingInfoList> {
  final _formKey = GlobalKey<FormState>();

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

  late Beer _beer;
  late bool readOnly;
  late DateTime _selectedDate;

  late TextEditingController _dateController;
  late TextEditingController _location;
  late TextEditingController _beerName;
  late TextEditingController _beerColour;
  late TextEditingController _beerColourDesc;
  late TextEditingController _clarity;
  late TextEditingController _foamColour;
  late TextEditingController _foamStructure;
  late TextEditingController _mouthFeelDesc;
  late TextEditingController _bodyDesc;
  late TextEditingController _aftertasteDesc;
  late TextEditingController _foodRecommendation;
  late TextEditingController _totalImpressionDesc;

  int? colourEbc;
  late int foamStability;
  late int bitternessRating;
  late int sweetnessRating;
  late int acidityRating;
  late int fullBodiedRating;
  late int aftertasteRating;
  late int totalImpressionRating;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    _dateController =
        TextEditingController(text: DateFormat.yMMMMd().format(_selectedDate));
    _location = TextEditingController(text: widget.tasting?.location);
    _beerName = TextEditingController(text: widget.tasting?.beer.beerName);
    _beerColour = TextEditingController(text: widget.tasting?.beerColour);
    _beerColourDesc =
        TextEditingController(text: widget.tasting?.beerColourDesc);
    _clarity = TextEditingController(text: widget.tasting?.clarity);
    _foamColour = TextEditingController(text: widget.tasting?.foamColour);
    _foamStructure = TextEditingController(text: widget.tasting?.foamStructure);
    _mouthFeelDesc = TextEditingController(text: widget.tasting?.mouthFeelDesc);
    _bodyDesc = TextEditingController(text: widget.tasting?.bodyDesc);
    _aftertasteDesc =
        TextEditingController(text: widget.tasting?.aftertasteDesc);
    _foodRecommendation =
        TextEditingController(text: widget.tasting?.foodRecommendation);
    _totalImpressionDesc =
        TextEditingController(text: widget.tasting?.totalImpressionDesc);

    if (widget.tasting != null) {
      colourEbc = widget.tasting!.colourEbc;
      foamStability = widget.tasting!.foamStability;
      bitternessRating = widget.tasting!.bitternessRating;
      sweetnessRating = widget.tasting!.sweetnessRating;
      acidityRating = widget.tasting!.acidityRating;
      fullBodiedRating = widget.tasting!.fullBodiedRating;
      aftertasteRating = widget.tasting!.aftertasteRating;
      totalImpressionRating = widget.tasting!.totalImpressionRating;

      _beer = widget.tasting!.beer;
    } else {
      foamStability = 1;
      bitternessRating = 1;
      sweetnessRating = 1;
      acidityRating = 1;
      fullBodiedRating = 1;
      aftertasteRating = 1;
      totalImpressionRating = 1;
    }

    if (widget.tasting == null) {
      setState(() => readOnly = false);
    } else {
      setState(() => readOnly = true);
    }

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
          key: _formKey,
          child: Column(
            children: <Widget>[
              _TastingCard(
                children: [
                  Text(
                    AppLocalizations.of(context).beertasting_general,
                    style: _heading,
                  ),
                  // InputDatePickerFormField(firstDate: DateTime(2015), lastDate: DateTime(2100)),
                  if (!readOnly)
                    TextFormField(
                      style: _text,
                      readOnly: true,
                      controller: _dateController,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).beertasting_date,
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                  if (readOnly)
                    TextFormField(
                      style: _text,
                      readOnly: true,
                      initialValue:
                          DateFormat.yMMMMd().format(widget.tasting!.date),
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).beertasting_date,
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                  TextFormField(
                    style: _text,
                    readOnly: readOnly,
                    controller: _location,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_location,
                      suffixIcon: const Icon(Icons.location_on_outlined),
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    readOnly: true,
                    controller: _beerName,
                    onTap: () {
                      if (!readOnly) _selectBeer(context);
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beerOne,
                    ),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? AppLocalizations.of(context).form_required
                          : null;
                    },
                  ),
                ],
              ),
              _TastingCard(
                children: [
                  Text(
                    AppLocalizations.of(context).beertasting_opticalAppearence,
                    style: _heading,
                  ),
                  TextFormField(
                    style: _text,
                    readOnly: readOnly,
                    controller: _foamColour,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_foamColour,
                      suffixIcon: const Icon(Icons.color_lens_outlined),
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    readOnly: readOnly,
                    controller: _foamStructure,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .beertasting_foamStructure,
                    ),
                  ),
                  Text(AppLocalizations.of(context).beertasting_foamStability),
                  Slider(
                    value: foamStability.toDouble(),
                    // min: 0,
                    max: 3,
                    divisions: 3,
                    label: '$foamStability',
                    onChanged: (double value) {
                      if (!readOnly) {
                        setState(() => foamStability = value.round());
                      }
                    },
                  ),
                  if (!readOnly)
                    DropdownButtonFormField(
                      value: colourEbc,
                      items: _ebc.map<DropdownMenuItem<int>>(
                        (int? val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Row(
                              children: [
                                Text('$val'),
                                Icon(
                                  Icons.circle,
                                  color: EbcColor.toColor(val),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (int? val) => setState(() => colourEbc = val),
                      decoration: InputDecoration(
                        labelText: 'EBC',
                        suffixIcon: (colourEbc != null)
                            ? Icon(
                                Icons.circle,
                                color: EbcColor.toColor(colourEbc),
                              )
                            : null,
                      ),
                    ),
                  if (readOnly)
                    TextFormField(
                      style: _text,
                      readOnly: true,
                      initialValue: '${widget.tasting!.colourEbc}',
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).beertasting_ebc,
                        suffixIcon: Icon(
                          Icons.circle,
                          color: EbcColor.toColor(widget.tasting!.colourEbc),
                        ),
                      ),
                    ),
                  TextFormField(
                    readOnly: readOnly,
                    style: _text,
                    controller: _beerColour,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_beerColour,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    readOnly: readOnly,
                    controller: _beerColourDesc,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .beertasting_colorDescription,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    readOnly: readOnly,
                    controller: _clarity,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_clarity,
                    ),
                  ),
                ],
              ),
              _TastingCard(
                children: [
                  Text(
                    AppLocalizations.of(context).beertasting_taste,
                    style: _heading,
                  ),
                  TextFormField(
                    style: _text,
                    readOnly: readOnly,
                    controller: _mouthFeelDesc,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_mmouthFeel,
                    ),
                  ),
                  Text(AppLocalizations.of(context).beertasting_bitterness),
                  Slider(
                    value: bitternessRating.toDouble(),
                    // min: 0,
                    max: 3,
                    divisions: 3,
                    label: '$bitternessRating',
                    onChanged: (double value) {
                      if (!readOnly) {
                        setState(() => bitternessRating = value.round());
                      }
                    },
                  ),
                  Text(AppLocalizations.of(context).beertasting_sweetness),
                  Slider(
                    value: sweetnessRating.toDouble(),
                    // min: 0,
                    max: 3,
                    divisions: 3,
                    label: '$sweetnessRating',
                    onChanged: (double value) {
                      if (!readOnly) {
                        setState(() => sweetnessRating = value.round());
                      }
                    },
                  ),
                  Text(AppLocalizations.of(context).beertasting_acidity),
                  Slider(
                    value: acidityRating.toDouble(),
                    // min: 0,
                    max: 3,
                    divisions: 3,
                    label: '$acidityRating',
                    onChanged: (double value) {
                      if (!readOnly) {
                        setState(() => acidityRating = value.round());
                      }
                    },
                  ),
                  Text(AppLocalizations.of(context).beertasting_bodyFullness),
                  Slider(
                    value: fullBodiedRating.toDouble(),
                    // min: 0,
                    max: 3,
                    divisions: 3,
                    label: '$fullBodiedRating',
                    onChanged: (double value) {
                      if (!readOnly) {
                        setState(() => fullBodiedRating = value.round());
                      }
                    },
                  ),
                  TextFormField(
                    style: _text,
                    readOnly: readOnly,
                    controller: _bodyDesc,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .beertasting_bodyDescription,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    readOnly: readOnly,
                    controller: _aftertasteDesc,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_aftertaste,
                    ),
                  ),
                  Text(AppLocalizations.of(context)
                      .beertasting_aftertasteRating),
                  Slider(
                    value: aftertasteRating.toDouble(),
                    // min: 0,
                    max: 3,
                    divisions: 3,
                    label: '$aftertasteRating',
                    onChanged: (double value) {
                      if (!readOnly) {
                        setState(() => aftertasteRating = value.round());
                      }
                    },
                  ),
                  TextFormField(
                    style: _text,
                    readOnly: readOnly,
                    controller: _foodRecommendation,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .beertasting_foodRecomendation,
                    ),
                  ),
                ],
              ),
              _TastingCard(
                children: [
                  Text(
                    AppLocalizations.of(context).beertasting_conclusion,
                    style: _heading,
                  ),
                  TextFormField(
                    style: _text,
                    readOnly: readOnly,
                    controller: _totalImpressionDesc,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .beertasting_totalImpression),
                  ),
                  Text(AppLocalizations.of(context).beertasting_totalRating),
                  Slider(
                    value: totalImpressionRating.toDouble(),
                    min: 1,
                    max: 3,
                    divisions: 2,
                    label: '$totalImpressionRating',
                    onChanged: (double value) {
                      if (!readOnly) {
                        setState(() => totalImpressionRating = value.round());
                      }
                    },
                  ),
                ],
              ),
              if (!readOnly)
                ElevatedButton(
                  onPressed: () => _submit(context),
                  child: Text(AppLocalizations.of(context).form_submit),
                ),
            ],
          ),
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
          content: Text(AppLocalizations.of(context).loading_processingData),
        ),
      );
      _formKey.currentState!.save();

      final Tasting _tasting = Tasting(
        beer: _beer,
        date: _selectedDate,
        location: _location.value.text,
        beerColour: _beerColour.value.text,
        beerColourDesc: _beerColourDesc.value.text,
        colourEbc: colourEbc,
        clarity: _clarity.value.text,
        foamColour: _foamColour.value.text,
        foamStructure: _foamStructure.value.text,
        foamStability: foamStability,
        bitternessRating: bitternessRating,
        sweetnessRating: sweetnessRating,
        acidityRating: acidityRating,
        mouthFeelDesc: _mouthFeelDesc.value.text,
        fullBodiedRating: fullBodiedRating,
        bodyDesc: _bodyDesc.value.text,
        aftertasteDesc: _aftertasteDesc.value.text,
        aftertasteRating: aftertasteRating,
        foodRecommendation: _foodRecommendation.value.text,
        totalImpressionDesc: _totalImpressionDesc.value.text,
        totalImpressionRating: totalImpressionRating,
      );
      await DatabaseService.saveTasting(_tasting);

      Navigator.pop(context);
    }
  }

  /// Calls [DispBeer] to select a [Beer]
  Future<void> _selectBeer(BuildContext context) async {
    final Beer? _selectedBeer =
        await Navigator.pushNamed<Beer?>(context, '/BeerList');

    if (_selectedBeer != null) {
      setState(() {
        _beerName.text = _selectedBeer.beerName;
        _beer = _selectedBeer;
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
      _selectedDate = _picked;
      setState(
        () => _dateController.text = DateFormat.yMMMMd().format(_selectedDate),
      );
    }
  }
}

class _TastingCard extends StatelessWidget {
  final List<Widget> children;
  const _TastingCard({
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
