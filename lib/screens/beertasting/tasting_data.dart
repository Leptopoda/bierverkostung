// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/shared/tasting_beer_card.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/tastings.dart';

part 'package:bierverkostung/screens/beertasting/color_to_ebc.dart';
part 'package:bierverkostung/screens/beertasting/custom_slider.dart';

/// Screen to add a new Beer
///
/// It exposes the fields of a [Tasting] into a UI
/// set [tasting] in order to get a screen to display the given tasting
class TastingInfoList extends StatefulWidget {
  final Tasting? tasting;
  final bool tablet;

  const TastingInfoList({
    this.tasting,
    this.tablet = false,
    Key? key,
  }) : super(key: key);

  @override
  _TastingInfoListState createState() => _TastingInfoListState();
}

class _TastingInfoListState extends State<TastingInfoList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
  late bool _readOnly;
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

  int? _colourEbc;
  late int _foamStability;
  late int _bitternessRating;
  late int _sweetnessRating;
  late int _acidityRating;
  late int _fullBodiedRating;
  late int _aftertasteRating;
  late int _totalImpressionRating;

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
      _colourEbc = widget.tasting!.colourEbc;
      _foamStability = widget.tasting!.foamStability;
      _bitternessRating = widget.tasting!.bitternessRating;
      _sweetnessRating = widget.tasting!.sweetnessRating;
      _acidityRating = widget.tasting!.acidityRating;
      _fullBodiedRating = widget.tasting!.fullBodiedRating;
      _aftertasteRating = widget.tasting!.aftertasteRating;
      _totalImpressionRating = widget.tasting!.totalImpressionRating;

      _beer = widget.tasting!.beer;
    } else {
      _foamStability = 1;
      _bitternessRating = 1;
      _sweetnessRating = 1;
      _acidityRating = 1;
      _fullBodiedRating = 1;
      _aftertasteRating = 1;
      _totalImpressionRating = 1;
    }

    if (widget.tasting == null) {
      setState(() => _readOnly = false);
    } else {
      setState(() => _readOnly = true);
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
      appBar: !widget.tablet
          ? AppBar(
              title: Text(AppLocalizations.of(context).beertasting),
            )
          : null,
      floatingActionButton: _readOnly
          ? FloatingActionButton(
              tooltip: AppLocalizations.of(context).beertasting_editTasting,
              onPressed: _onEdit,
              child: const Icon(Icons.edit_outlined),
            )
          : null,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TastingBeerCard(
                children: [
                  Text(
                    AppLocalizations.of(context).beertasting_general,
                    style: _heading,
                  ),
                  // InputDatePickerFormField(firstDate: DateTime(2015), lastDate: DateTime(2100)),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: true,
                    controller: _dateController,
                    onTap: _selectDate,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beertasting_date,
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
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
                    onTap: !_readOnly ? _selectBeer : _showBeer,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beerOne,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).form_required;
                      }
                    },
                  ),
                ],
              ),
              TastingBeerCard(
                children: [
                  Text(
                    AppLocalizations.of(context).beertasting_opticalAppearence,
                    style: _heading,
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _foamColour,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_foamColour,
                      suffixIcon: const Icon(Icons.color_lens_outlined),
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _foamStructure,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .beertasting_foamStructure,
                    ),
                  ),
                  _SliderField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .beertasting_foamStability,
                    ),
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    value: _foamStability,
                    onChanged: (int value) =>
                        setState(() => _foamStability = value),
                  ),
                  _EBCFormField(
                    ebc: _ebc,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    value: _colourEbc,
                    onChanged: (int? val) => setState(() => _colourEbc = val),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _beerColour,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_beerColour,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _beerColourDesc,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .beertasting_colorDescription,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _clarity,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_clarity,
                    ),
                  ),
                ],
              ),
              TastingBeerCard(
                children: [
                  Text(
                    AppLocalizations.of(context).beertasting_taste,
                    style: _heading,
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _mouthFeelDesc,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_mmouthFeel,
                    ),
                  ),
                  _SliderField(
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_bitterness,
                    ),
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    value: _bitternessRating,
                    onChanged: (int value) =>
                        setState(() => _bitternessRating = value),
                  ),
                  _SliderField(
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).beertasting_sweetness,
                      ),
                      enabled: !_readOnly,
                      readOnly: _readOnly,
                      value: _sweetnessRating,
                      onChanged: (int value) =>
                          setState(() => _sweetnessRating = value)),
                  _SliderField(
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_acidity,
                    ),
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    value: _acidityRating,
                    onChanged: (int value) =>
                        setState(() => _acidityRating = value),
                  ),
                  _SliderField(
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_bodyFullness,
                    ),
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    value: _fullBodiedRating,
                    onChanged: (int value) =>
                        setState(() => _fullBodiedRating = value),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _bodyDesc,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .beertasting_bodyDescription,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _aftertasteDesc,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_aftertaste,
                    ),
                  ),
                  _SliderField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .beertasting_aftertasteRating,
                    ),
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    value: _aftertasteRating,
                    onChanged: (int value) =>
                        setState(() => _aftertasteRating = value),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _foodRecommendation,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .beertasting_foodRecomendation,
                    ),
                  ),
                ],
              ),
              TastingBeerCard(
                children: [
                  Text(
                    AppLocalizations.of(context).beertasting_conclusion,
                    style: _heading,
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _totalImpressionDesc,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .beertasting_totalImpression),
                  ),
                  _SliderField(
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).beertasting_totalRating,
                    ),
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    value: _totalImpressionRating,
                    min: 1,
                    onChanged: (int value) =>
                        setState(() => _totalImpressionRating = value),
                  ),
                ],
              ),
              if (!_readOnly)
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(AppLocalizations.of(context).form_submit),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// validates the inputs and submits them to FireStore
  Future<void> _submit() async {
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

      Navigator.pop(context);
    }
  }

  /// sets the [_readOnly] flag to false
  void _onEdit() => setState(() => _readOnly = false);

  /// Calls [DispBeer] to select a [Beer]
  Future<void> _selectBeer() async {
    final Beer? _selectedBeer =
        await Navigator.pushNamed<Beer?>(context, '/BeerList');

    if (_selectedBeer != null) {
      setState(() {
        _beerName.text = _selectedBeer.beerName;
        _beer = _selectedBeer;
      });
    }
  }

  /// Calls [DispBeer] to show the [Beer] data
  Future<void> _showBeer() async {
    await Navigator.pushNamed(context, '/NewBeer', arguments: _beer);
  }

  /// Selects a date from DatePicker
  Future<void> _selectDate() async {
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

/// widget to select or display the ebc
///
/// [value] is the currnent value or the value to be displayed
class _EBCFormField extends StatelessWidget {
  const _EBCFormField({
    Key? key,
    required this.ebc,
    this.value,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
  }) : super(key: key);

  final int? value;
  final List<int?> ebc;
  final bool readOnly;
  final bool enabled;
  final ValueChanged<int?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final Icon? _suffixIcon = (value != null)
        ? Icon(
            Icons.circle,
            color: EbcColor.toColor(value),
          )
        : null;
    final InputDecoration _decoration = InputDecoration(
      labelText: AppLocalizations.of(context).beertasting_ebc,
      suffixIcon: _suffixIcon,
    );

    if (!readOnly) {
      final List<DropdownMenuItem<int?>> _ebcItems = List.generate(
        ebc.length,
        (index) => _getEBCItem(ebc[index]),
      );

      return DropdownButtonFormField<int?>(
        value: value,
        items: _ebcItems,
        onChanged: onChanged,
        decoration: _decoration,
      );
    } else {
      final TextStyle? _text = Theme.of(context).textTheme.bodyText2;

      return TextFormField(
        style: _text,
        enabled: enabled,
        readOnly: true,
        initialValue: value?.toString(),
        decoration: _decoration,
      );
    }
  }

  /// generates a DropdownMenuItem<int?> displaying the selected [ebc] as colour
  static DropdownMenuItem<int?> _getEBCItem(int? ebc) {
    return DropdownMenuItem<int?>(
      value: ebc,
      child: (ebc != null)
          ? Row(
              children: [
                Text(ebc.toString()),
                Icon(
                  Icons.circle,
                  color: EbcColor.toColor(ebc),
                ),
              ],
            )
          : Container(),
    );
  }
}
