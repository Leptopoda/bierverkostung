// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/screens/bierverkostung/disp_beer.dart';

// TODO: Deduplicate this file with NewTasting

class DispTasting extends StatelessWidget {
  final Tasting tasting;
  final bool tablet;

  const DispTasting({
    Key? key,
    required this.tasting,
    required this.tablet,
  }) : super(key: key);

  static const TextStyle _heading = TextStyle(
    fontSize: 22,
    color: Colors.yellow,
  );
  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !tablet
          ? AppBar(
              title: Text(AppLocalizations.of(context)!.beertasting),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.beertasting_general,
            style: _heading,
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: DateFormat.yMMMMd().format(tasting.date),
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.beertasting_date,
              suffixIcon: const Icon(Icons.calendar_today_outlined),
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.location,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.beertasting_location,
              suffixIcon: const Icon(Icons.location_on_outlined),
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.beer.beerName,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.beerOne,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.beertasting_opticalAppearence,
            style: _heading,
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.foamColour,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.beertasting_foamColour,
              suffixIcon: const Icon(Icons.color_lens_outlined),
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.foamStructure,
            decoration: InputDecoration(
              labelText:
                  AppLocalizations.of(context)!.beertasting_foamStructure,
            ),
          ),
          Text(AppLocalizations.of(context)!.beertasting_foamStability),
          SliderIndicator(
            value: tasting.foamStability,
            min: 0,
            max: 3,
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: '${tasting.colourEbc}',
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.beertasting_ebc,
              suffixIcon: Icon(
                Icons.circle,
                color: Colors.yellow[800],
              ),
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.beerColour,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.beertasting_beerColour,
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.beerColourDesc,
            decoration: InputDecoration(
              labelText:
                  AppLocalizations.of(context)!.beertasting_colorDescription,
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.clarity,
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
            readOnly: true,
            initialValue: tasting.mouthFeelDesc,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.beertasting_mmouthFeel,
            ),
          ),
          Text(AppLocalizations.of(context)!.beertasting_bitterness),
          SliderIndicator(
            value: tasting.bitternessRating,
            min: 0,
            max: 3,
          ),
          Text(AppLocalizations.of(context)!.beertasting_sweetness),
          SliderIndicator(
            value: tasting.sweetnessRating,
            min: 0,
            max: 3,
          ),
          Text(AppLocalizations.of(context)!.beertasting_acidity),
          SliderIndicator(
            value: tasting.acidityRating,
            min: 0,
            max: 3,
          ),
          Text(AppLocalizations.of(context)!.beertasting_bodyFullness),
          SliderIndicator(
            value: tasting.fullBodiedRating,
            min: 0,
            max: 3,
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.bodyDesc,
            decoration: InputDecoration(
              labelText:
                  AppLocalizations.of(context)!.beertasting_bodyDescription,
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.aftertasteDesc,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.beertasting_aftertaste,
            ),
          ),
          Text(AppLocalizations.of(context)!.beertasting_aftertasteRating),
          SliderIndicator(
            value: tasting.aftertasteRating,
            min: 0,
            max: 3,
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.foodRecommendation,
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
            readOnly: true,
            initialValue: tasting.totalImpressionDesc,
            decoration: InputDecoration(
              labelText:
                  AppLocalizations.of(context)!.beertasting_totalImpression,
            ),
          ),
          Text(AppLocalizations.of(context)!.beertasting_totalRating),
          SliderIndicator(
            value: tasting.totalImpressionRating,
            min: 1,
            max: 3,
          ),
          Text(
            AppLocalizations.of(context)!.beerOne,
            style: _heading,
          ),
          ...DispBeer(
            beer: tasting.beer,
          ).dispBeer(context),
        ],
      ),
    );
  }
}

class SliderIndicator extends StatefulWidget {
  final int min;
  final int max;
  final int value;

  const SliderIndicator({
    Key? key,
    required this.min,
    required this.max,
    required this.value,
  }) : super(key: key);

  @override
  _SliderIndicatorState createState() => _SliderIndicatorState();
}

class _SliderIndicatorState extends State<SliderIndicator> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: widget.value.toDouble(),
      min: widget.min.toDouble(),
      max: widget.max.toDouble(),
      divisions: widget.max - widget.min,
      label: '${widget.value}',
      onChanged: (double value) {},
    );
  }
}
