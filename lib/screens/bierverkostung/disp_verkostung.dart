// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/screens/bierverkostung/disp_beer.dart';

// TODO: Deduplicate this file with NewTasting

class DispTasting extends StatelessWidget {
  final Tasting tasting;

  const DispTasting({
    Key? key,
    required this.tasting,
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
      appBar: AppBar(
        title: const Text('Verkostung'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: <Widget>[
          const Text(
            'General',
            style: _heading,
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: DateFormat.yMMMMd().format(tasting.date),
            decoration: const InputDecoration(
              labelText: 'Date',
              suffixIcon: Icon(Icons.calendar_today_outlined),
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.location,
            decoration: const InputDecoration(
              labelText: 'Location',
              suffixIcon: Icon(Icons.location_on_outlined),
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.beer.beerName,
            decoration: const InputDecoration(
              labelText: 'Bier',
            ),
          ),
          const Text(
            'Optical Appearance',
            style: _heading,
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.foamColour,
            decoration: const InputDecoration(
              labelText: 'Foam Colour',
              suffixIcon: Icon(Icons.color_lens_outlined),
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.foamStructure,
            decoration: const InputDecoration(
              labelText: 'Foam Structure',
            ),
          ),
          const Text('Foam Stability'),
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
              labelText: 'EBC',
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
            decoration: const InputDecoration(
              labelText: 'Beer Colour',
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.beerColourDesc,
            decoration: const InputDecoration(
              labelText: 'Color Description',
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.clarity,
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
            readOnly: true,
            initialValue: tasting.mouthFeelDesc,
            decoration: const InputDecoration(
              labelText: 'Mundgefühl',
            ),
          ),
          const Text('Bitterness'),
          SliderIndicator(
            value: tasting.bitternessRating,
            min: 0,
            max: 3,
          ),
          const Text('Sweetness'),
          SliderIndicator(
            value: tasting.sweetnessRating,
            min: 0,
            max: 3,
          ),
          const Text('Acidity'),
          SliderIndicator(
            value: tasting.acidityRating,
            min: 0,
            max: 3,
          ),
          const Text('Body Fullness'),
          SliderIndicator(
            value: tasting.fullBodiedRating,
            min: 0,
            max: 3,
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.bodyDesc,
            decoration: const InputDecoration(
              labelText: 'Body Description',
            ),
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.aftertasteDesc,
            decoration: const InputDecoration(
              labelText: 'Nachgeschmack',
            ),
          ),
          const Text('Nachgeschmack rating'),
          SliderIndicator(
            value: tasting.aftertasteRating,
            min: 0,
            max: 3,
          ),
          TextFormField(
            style: _text,
            readOnly: true,
            initialValue: tasting.foodRecommendation,
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
            readOnly: true,
            initialValue: tasting.totalImpressionDesc,
            decoration: const InputDecoration(
              labelText: 'Total Impression',
            ),
          ),
          const Text('Total Rating'),
          SliderIndicator(
            value: tasting.totalImpressionRating,
            min: 1,
            max: 3,
          ),
          const Text(
            'Beer',
            style: _heading,
          ),
          ...DispBeer(
            beer: tasting.beer,
          ).dispBeer(),
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
