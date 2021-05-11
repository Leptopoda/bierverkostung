// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:random_color/random_color.dart';
import 'package:provider/provider.dart';
import 'graph_legend_item.dart';
import 'pie_chart_notifier.dart';

class StatistikenBeerChart extends StatefulWidget {
  final List<Map> data;
  const StatistikenBeerChart({Key? key, required this.data}) : super(key: key);

  @override
  _StatistikenBeerChartState createState() => _StatistikenBeerChartState();
}

class _StatistikenBeerChartState extends State<StatistikenBeerChart> {
  late List<Color> colors;
  int count = 0;

  @override
  void initState() {
    super.initState();
    colors = randomColors();
  }

  @override
  Widget build(BuildContext context) {
    for (final element in widget.data) {
      count += element['beerCount'] as int;
    }
    return ChangeNotifierProvider<PieChartNotifier>(
      create: (_) => PieChartNotifier(),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Biere',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ...legendItems(),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(flex: 3, child: chart()),
        ],
      ),
    );
  }

  Widget chart() {
    const double kShowTitleThresholdPercentage = 5.0;

    return Consumer<PieChartNotifier>(
      builder: (BuildContext context, PieChartNotifier notifier, _) => PieChart(
        PieChartData(
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: (notifier.selected >= 0) ? 4.0 : 2.0,
          pieTouchData: PieTouchData(
            touchCallback: (PieTouchResponse pieTouchResponse) => setState(() {
              final desiredTouch =
                  pieTouchResponse.touchInput is! PointerExitEvent &&
                      pieTouchResponse.touchInput is! PointerUpEvent;
              if (desiredTouch && pieTouchResponse.touchedSection != null) {
                notifier.selected =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              } else {
                notifier.selected = -1;
              }
            }),
          ),
          sections: List.generate(widget.data.length, (i) {
            final double value =
                ((widget.data[i]['beerCount'] as int) / count) * 100;
            return PieChartSectionData(
              color: colors[i],
              value: value,
              title: '${value.toStringAsFixed(1)}%',
              radius: 60 + (notifier.selected == i ? 5.0 : 0.0),
              showTitle: value >= kShowTitleThresholdPercentage,
              titleStyle: TextStyle(
                fontSize: notifier.selected == i ? 18 : 16,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ),
      ),
    );
  }

  List<Widget> legendItems() {
    return List.generate(widget.data.length, (i) {
      final double value = ((widget.data[i]['beerCount'] as int) / count) * 100;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: GraphLegendItem(
          index: i,
          title: widget.data[i]['beerName'] as String,
          subtitle: '${value.toStringAsFixed(2)}%',
          color: colors[i],
        ),
      );
    });
  }

  List<Color> randomColors() {
    return List.generate(widget.data.length, (i) {
      return RandomColor().randomColor(colorHue: ColorHue.yellow);
    });
  }
}
