// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Signature for the [SliderField.buildCounter] callback.
typedef InputCounterWidgetBuilder = Widget? Function(
  /// The build context for the TextField.
  BuildContext context, {

  /// Whether or not the TextField is currently focused.  Mainly provided for
  /// the [liveRegion] parameter in the [Semantics] widget for accessibility.
  required bool isFocused,
});

/// Slider wrapped inside a [InputDecorator]
///
/// this will allow sliders to be implemented in a [Form] together with [TextFormField]
class SliderField extends StatefulWidget {
  const SliderField({
    Key? key,
    this.decoration,
    this.enabled,
    this.buildCounter,
    this.focusNode,
    this.style,
    required this.value,
    required this.onChanged,
    this.expands = false,
    this.readOnly = false,
    this.min = 0,
    this.max = 3,
  }) : super(key: key);

  final InputDecoration? decoration;
  final bool? enabled;
  final InputCounterWidgetBuilder? buildCounter;
  final FocusNode? focusNode;

  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  final int value;
  final double min;
  final double max;

  final ValueChanged<int> onChanged;

  @override
  _SliderFieldState createState() => _SliderFieldState();
}

class _SliderFieldState extends State<SliderField> {
  bool get _isEnabled => widget.enabled ?? widget.decoration?.enabled ?? true;
  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  Widget build(BuildContext context) {
    final int _divisions = (widget.max - widget.min).round();
    final FocusNode focusNode = _effectiveFocusNode;

    return InputDecorator(
      decoration: _getEffectiveDecoration(),
      baseStyle: widget.style,
      isFocused: focusNode.hasFocus,
      expands: widget.expands,
      child: Slider(
        value: widget.value.toDouble(),
        min: widget.min,
        max: widget.max,
        divisions: _divisions,
        label: widget.value.toString(),
        onChanged: (double val) {
          if (!widget.readOnly) widget.onChanged(val.round());
        },
      ),
    );
  }

  InputDecoration _getEffectiveDecoration() {
    final ThemeData themeData = Theme.of(context);
    final InputDecoration effectiveDecoration =
        (widget.decoration ?? const InputDecoration())
            .applyDefaults(themeData.inputDecorationTheme)
            .copyWith(
              enabled: _isEnabled,
            );

    // No need to build anything if counter or counterText were given directly.
    if (effectiveDecoration.counter != null ||
        effectiveDecoration.counterText != null) return effectiveDecoration;

    // If buildCounter was provided, use it to generate a counter widget.
    Widget? counter;
    if (effectiveDecoration.counter == null &&
        effectiveDecoration.counterText == null &&
        widget.buildCounter != null) {
      final bool isFocused = _effectiveFocusNode.hasFocus;
      final Widget? builtCounter = widget.buildCounter!(
        context,
        isFocused: isFocused,
      );
      // If buildCounter returns null, don't add a counter widget to the field.
      if (builtCounter != null) {
        counter = Semantics(
          container: true,
          liveRegion: isFocused,
          child: builtCounter,
        );
      }
      return effectiveDecoration.copyWith(counter: counter);
    }

    return effectiveDecoration;
  }
}
