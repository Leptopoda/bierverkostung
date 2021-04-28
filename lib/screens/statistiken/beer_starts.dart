// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:random_color/random_color.dart';

import 'package:bierverkostung/screens/statistiken/chart_indicator.dart';

class StatistikenBeerChart extends StatefulWidget {
  final List<Map> data;
  const StatistikenBeerChart({Key? key, required this.data}) : super(key: key);

  @override
  _StatistikenBeerChartState createState() => _StatistikenBeerChartState();
}

class _StatistikenBeerChartState extends State<StatistikenBeerChart> {
  int touchedIndex = -1;
  late List<Color> colors;

  @override
  Widget build(BuildContext context) {
    colors = randomColors(widget.data.length);
    return Row(
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        chart(),
        Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: legend(widget.data),
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }

  Widget chart() {
    return Expanded(
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
            setState(() {
              final desiredTouch =
                  pieTouchResponse.touchInput is! PointerExitEvent &&
                      pieTouchResponse.touchInput is! PointerUpEvent;
              if (desiredTouch && pieTouchResponse.touchedSection != null) {
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              } else {
                touchedIndex = -1;
              }
            });
          }),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: showingSections(widget.data),
        ),
      ),
    );
  }

  List<Widget> legend(List<Map> data) {
    return List.generate(data.length, (i) {
      return Indicator(
        color: colors[i],
        text: data[i]['beerName'] as String,
        isSquare: true,
      );
    });
  }

  List<PieChartSectionData> showingSections(List<Map> data) {
    int count = 0;
    for (final element in data) {
      count += element['beerCount'] as int;
    }

    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      final double value = ((data[i]['beerCount'] as int) / count) * 100;
      return PieChartSectionData(
        color: colors[i],
        value: value,
        title: '${value.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    });
  }

  List<Color> randomColors(int size) {
    return List.generate(size, (i) {
      return RandomColor().randomColor(colorHue: ColorHue.yellow);
    });
  }
}
