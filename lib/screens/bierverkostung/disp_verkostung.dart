// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bierverkostung/models/tastings.dart';

// TODO: Deduplicate this file with NewTasting

class DispTasting extends StatefulWidget {
  final Tasting tasting;

  const DispTasting({
    Key? key,
    required this.tasting,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DispTastingState();
}

class _DispTastingState extends State<DispTasting> {
  final _formKey = GlobalKey<FormState>();

  static const TextStyle _heading = TextStyle(
    fontSize: 22,
    color: Colors.yellow,
  );
  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  late int _foamStability;
  late int _bitternessRating;
  late int _sweetnessRating;
  late int _acidityRating;
  late int _fullBodiedRating;
  late int _aftertasteRating;
  late int _totalImpressionRating;

  @override
  void initState() {
    _foamStability = widget.tasting.foamStability;
    _bitternessRating = widget.tasting.bitternessRating;
    _sweetnessRating = widget.tasting.sweetnessRating;
    _acidityRating = widget.tasting.acidityRating;
    _fullBodiedRating = widget.tasting.fullBodiedRating;
    _aftertasteRating = widget.tasting.aftertasteRating;
    _totalImpressionRating = widget.tasting.totalImpressionRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verkostung'),
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
              initialValue: DateFormat.yMMMMd().format(widget.tasting.date),
              decoration: const InputDecoration(
                labelText: 'Date',
                suffixIcon: Icon(Icons.calendar_today_outlined),
              ),
            ),
            TextFormField(
              style: _text,
              initialValue: widget.tasting.location,
              decoration: const InputDecoration(
                labelText: 'Location',
                suffixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
            TextFormField(
              style: _text,
              initialValue: widget.tasting.beer.beerName,
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
              initialValue: widget.tasting.foamColour,
              decoration: const InputDecoration(
                labelText: 'Foam Colour',
                suffixIcon: Icon(Icons.color_lens_outlined),
              ),
            ),
            TextFormField(
              style: _text,
              initialValue: widget.tasting.foamStructure,
              decoration: const InputDecoration(
                labelText: 'Foam Structure',
              ),
            ),
            const Text('Foam Stability'),
            Slider(
              value: _foamStability.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '$_foamStability',
              onChanged: (double value) =>
                  setState(() => _foamStability = value.round()),
            ),
            TextFormField(
              style: _text,
              initialValue: '${widget.tasting.colourEbc}',
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
              initialValue: widget.tasting.beerColour,
              decoration: const InputDecoration(
                labelText: 'Beer Colour',
              ),
            ),
            TextFormField(
              style: _text,
              initialValue: widget.tasting.beerColourDesc,
              decoration: const InputDecoration(
                labelText: 'Color Description',
              ),
            ),
            TextFormField(
              style: _text,
              initialValue: widget.tasting.clarity,
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
              initialValue: widget.tasting.mouthFeelDesc,
              decoration: const InputDecoration(
                labelText: 'Mundgefühl',
              ),
            ),
            const Text('Bitterness'),
            Slider(
              value: _bitternessRating.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '$_bitternessRating',
              onChanged: (double value) =>
                  setState(() => _bitternessRating = value.round()),
            ),
            const Text('Sweetness'),
            Slider(
              value: _sweetnessRating.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '$_sweetnessRating',
              onChanged: (double value) =>
                  setState(() => _sweetnessRating = value.round()),
            ),
            const Text('Acidity'),
            Slider(
              value: _acidityRating.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '$_acidityRating',
              onChanged: (double value) =>
                  setState(() => _acidityRating = value.round()),
            ),
            const Text('Body Fullness'),
            Slider(
              value: _fullBodiedRating.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              label: '$_fullBodiedRating',
              onChanged: (double value) =>
                  setState(() => _fullBodiedRating = value.round()),
            ),
            TextFormField(
              style: _text,
              initialValue: widget.tasting.bodyDesc,
              decoration: const InputDecoration(
                labelText: 'Body Description',
              ),
            ),
            TextFormField(
              // TODO: add intensity
              style: _text,
              initialValue: widget.tasting.aftertasteDesc,
              decoration: const InputDecoration(
                labelText: 'Nachgeschmack',
              ),
            ),
            TextFormField(
              style: _text,
              initialValue: widget.tasting.foodRecommendation,
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
              initialValue: widget.tasting.totalImpressionDesc,
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
          ],
        ),
      ),
    );
  }
}
