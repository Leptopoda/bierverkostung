// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'statistiken_list.dart';

/// Color indicator blob
///
/// small blob of color indicator used in the PieChart legend
class _LegendIndicator extends StatefulWidget {
  const _LegendIndicator({
    Key? key,
    required this.title,
    this.subtitle,
    required this.color,
    this.isSquare = true,
    this.size = 12,
    this.textColor = const Color(0xff505050),
    required this.selected,
  }) : super(key: key);

  final Color color;
  final Widget title;
  final Widget? subtitle;
  final bool isSquare;
  final double size;
  final Color textColor;
  final bool selected;

  @override
  _LegendIndicatorState createState() => _LegendIndicatorState();
}

class _LegendIndicatorState extends State<_LegendIndicator>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AnimatedSize(
          vsync: this,
          curve: Curves.easeInOut,
          duration: kThemeAnimationDuration,
          reverseDuration: kThemeAnimationDuration,
          child: Container(
            width: widget.selected ? widget.size / 2 : 0.0,
          ),
        ),
        Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape:
                widget.isSquare || false ? BoxShape.rectangle : BoxShape.circle,
            color: widget.color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        widget.title,
        widget.subtitle ?? Container(),
      ],
    );
  }
}

/// Legend Item
///
/// defines legend entries
class _GraphLegendItem extends StatelessWidget {
  const _GraphLegendItem({
    Key? key,
    required this.title,
    required this.index,
    required this.subtitle,
    required this.color,
  }) : super(key: key);
  final String title;
  final int index;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Consumer<_PieChartNotifier>(
      builder: (BuildContext context, _PieChartNotifier value, _) {
        return _LegendIndicator(
          selected: value.selected == index,
          title: Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          color: color,
          isSquare: false,
        );
      },
    );
  }
}
