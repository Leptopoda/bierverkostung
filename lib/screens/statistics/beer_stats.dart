// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/statistics/stst_list.dart';

/// Pie Cahrt stats
///
/// dispalys the overall distribution of [Beer]
class _StatisticsBeerChart extends StatefulWidget {
  final List<Map> data;
  const _StatisticsBeerChart({Key? key, required this.data}) : super(key: key);

  @override
  _StatisticsBeerChartState createState() => _StatisticsBeerChartState();
}

class _StatisticsBeerChartState extends State<_StatisticsBeerChart> {
  late List<Color> _colors;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _colors = _randomColors();
    for (final element in widget.data) {
      _count += element['beerCount'] as int;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_PieChartNotifier>(
      create: (_) => _PieChartNotifier(),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    AppLocalizations.of(context)!.beerOther,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                ..._legendItems(),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
              flex: 3,
              child: _PieChartStat(
                colors: _colors,
                data: widget.data,
                count: _count,
              )),
        ],
      ),
    );
  }

  /// generates the legend items
  List<Widget> _legendItems() {
    return List.generate(
      widget.data.length,
      (i) {
        final double value = (widget.data[i]['beerCount'] as int) / _count;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: _GraphLegendItem(
            index: i,
            title: widget.data[i]['beerName'] as String,
            subtitle: NumberFormat('#0.00%').format(value),
            color: _colors[i],
          ),
        );
      },
    );
  }

  /// generates a list of random colors
  List<Color> _randomColors() {
    return List.generate(widget.data.length, (i) {
      return RandomColor().randomColor(colorHue: ColorHue.orange);
    });
  }
}

/// PieChart tile
///
/// the tile containing the actual stat
class _PieChartStat extends StatefulWidget {
  const _PieChartStat({
    Key? key,
    required this.colors,
    required this.data,
    required this.count,
  }) : super(key: key);

  final List<Color> colors;
  final List<Map> data;
  final int count;

  @override
  _PieChartStatState createState() => _PieChartStatState();
}

class _PieChartStatState extends State<_PieChartStat> {
  static const double kShowTitleThresholdPercentage = 5.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<_PieChartNotifier>(
      builder: (BuildContext context, _PieChartNotifier notifier, _) =>
          PieChart(
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
                (widget.data[i]['beerCount'] as int) / widget.count;
            return PieChartSectionData(
              color: widget.colors[i],
              value: value,
              title: NumberFormat('#0.0#%').format(value),
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
}
