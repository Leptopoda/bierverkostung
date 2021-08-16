// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// The type of the [RawAutocomplete] callback that converts an option value to
/// a string which can be displayed in the widget's options menu.
///
/// See also:
///
///   * [RawAutocomplete.displayStringForOption], which is of this type.
typedef _CustomAutocompleteOptionToString<T extends Object> = String? Function(
    T option);

/// A widget for helping the user make a selection by entering some text and
/// choosing from among a list of options.
///
/// This widget extends [AutoComplete] with some parameters from [RawAutocomplete]
class CustomAutoComplete<T extends Object> extends StatelessWidget {
  /// Create an instance of RawAutocomplete.
  ///
  /// either [optionsBuilder] or [options] must not be null.
  const CustomAutoComplete({
    Key? key,
    this.optionsBuilder,
    this.options,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.decoration,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    this.fieldViewBuilder,
    this.onSelected,
    this.optionsViewBuilder,
  })  : assert((optionsBuilder ?? options) != null),
        super(key: key);

  /// {@template flutter.widgets.RawAutocomplete.displayStringForOption}
  /// Returns the string to display in the field when the option is selected.
  ///
  /// This is useful when using a custom T type and the string to display is
  /// different than the string to search by.
  ///
  /// If not provided, will use `option.toString()`.
  /// {@endtemplate}
  final _CustomAutocompleteOptionToString<T> displayStringForOption;

  /// {@macro flutter.widgets.RawAutocomplete.fieldViewBuilder}
  ///
  /// If not provided, will build a standard Material-style text field by
  /// default.
  final AutocompleteFieldViewBuilder? fieldViewBuilder;

  /// {@macro flutter.widgets.RawAutocomplete.onSelected}
  final AutocompleteOnSelected<T>? onSelected;

  /// {@macro flutter.widgets.RawAutocomplete.optionsBuilder}
  final AutocompleteOptionsBuilder<T>? optionsBuilder;

  /// {@macro flutter.widgets.RawAutocomplete.optionsViewBuilder}
  ///
  /// If not provided, will build a standard Material-style list of results by
  /// default.
  final AutocompleteOptionsViewBuilder<T>? optionsViewBuilder;

  /// The [TextEditingController] that is used for the text field.
  ///
  /// {@macro flutter.widgets.RawAutocomplete.split}
  ///
  /// If this parameter is not null, then [focusNode] must also be not null.
  final TextEditingController? controller;

  /// The [FocusNode] that is used for the text field.
  ///
  /// {@template flutter.widgets.RawAutocomplete.split}
  /// The main purpose of this parameter is to allow the use of a separate text
  /// field located in another part of the widget tree instead of the text
  /// field built by [fieldViewBuilder]. For example, it may be desirable to
  /// place the text field in the AppBar and the options below in the main body.
  ///
  /// When following this pattern, [fieldViewBuilder] can return
  /// `SizedBox.shrink()` so that nothing is drawn where the text field would
  /// normally be. A separate text field can be created elsewhere, and a
  /// FocusNode and TextEditingController can be passed both to that text field
  /// and to RawAutocomplete.
  ///
  /// {@tool dartpad --template=freeform}
  /// This examples shows how to create an autocomplete widget with the text
  /// field in the AppBar and the results in the main body of the app.
  ///
  /// ```dart main
  /// import 'package:flutter/material.dart';
  /// import 'package:flutter/widgets.dart';
  ///
  /// void main() => runApp(const AutocompleteExampleApp());
  ///
  /// class AutocompleteExampleApp extends StatelessWidget {
  ///   const AutocompleteExampleApp({Key? key}) : super(key: key);
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return const MaterialApp(
  ///       home: RawAutocompleteSplit(),
  ///     );
  ///   }
  /// }
  ///
  /// const List<String> _options = <String>[
  ///   'aardvark',
  ///   'bobcat',
  ///   'chameleon',
  /// ];
  ///
  /// class RawAutocompleteSplit extends StatefulWidget {
  ///   const RawAutocompleteSplit({Key? key}) : super(key: key);
  ///
  ///   @override
  ///   RawAutocompleteSplitState createState() => RawAutocompleteSplitState();
  /// }
  ///
  /// class RawAutocompleteSplitState extends State<RawAutocompleteSplit> {
  ///   final TextEditingController _textEditingController = TextEditingController();
  ///   final FocusNode _focusNode = FocusNode();
  ///   final GlobalKey _autocompleteKey = GlobalKey();
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       appBar: AppBar(
  ///         // This is where the real field is being built.
  ///         title: TextFormField(
  ///           controller: _textEditingController,
  ///           focusNode: _focusNode,
  ///           decoration: const InputDecoration(
  ///             hintText: 'Split RawAutocomplete App',
  ///           ),
  ///           onFieldSubmitted: (String value) {
  ///             RawAutocomplete.onFieldSubmitted<String>(_autocompleteKey);
  ///           },
  ///         ),
  ///       ),
  ///       body: Align(
  ///         alignment: Alignment.topLeft,
  ///         child: RawAutocomplete<String>(
  ///           key: _autocompleteKey,
  ///           focusNode: _focusNode,
  ///           textEditingController: _textEditingController,
  ///           optionsBuilder: (TextEditingValue textEditingValue) {
  ///             return _options.where((String option) {
  ///               return option.contains(textEditingValue.text.toLowerCase());
  ///             }).toList();
  ///           },
  ///           optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
  ///             return Material(
  ///               elevation: 4.0,
  ///               child: ListView(
  ///                 children: options.map((String option) => GestureDetector(
  ///                   onTap: () {
  ///                     onSelected(option);
  ///                   },
  ///                   child: ListTile(
  ///                     title: Text(option),
  ///                   ),
  ///                 )).toList(),
  ///               ),
  ///             );
  ///           },
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  /// {@end-tool}
  /// {@endtemplate}
  ///
  /// If this parameter is not null, then [textEditingController] must also be
  /// not null.
  final FocusNode? focusNode;

  /// list of autocomplete options
  final List<T>? options;

  /// defines wether the [TextFormField] is going to be readOnly or editable
  final bool readOnly;

  /// defines the [InputDecoration] for the returned [TextFormField]
  final InputDecoration? decoration;

  Iterable<T> _defaultOptionsBuilder(TextEditingValue textEditingValue) {
    return options!.where((T option) {
      final String? _firstString =
          displayStringForOption(option)?.toLowerCase();
      if (_firstString!.isEmpty) return false;

      return _firstString.contains(textEditingValue.text.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<T>(
      textEditingController: controller ?? TextEditingController(),
      focusNode: focusNode ?? FocusNode(),
      displayStringForOption: (T option) => displayStringForOption(option)!,
      fieldViewBuilder: fieldViewBuilder ??
          (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return _AutocompleteField(
              focusNode: focusNode,
              textEditingController: textEditingController,
              onFieldSubmitted: onFieldSubmitted,
              readOnly: readOnly,
              decoration: decoration,
            );
          },
      optionsBuilder: optionsBuilder ?? _defaultOptionsBuilder,
      optionsViewBuilder: optionsViewBuilder ??
          (BuildContext context, AutocompleteOnSelected<T> onSelected,
              Iterable<T> options) {
            return _AutocompleteOptions<T>(
              displayStringForOption: (T options) =>
                  displayStringForOption(options)!,
              onSelected: onSelected,
              options: options,
            );
          },
      onSelected: onSelected,
    );
  }
}

// The default Material-style Autocomplete text field.
class _AutocompleteField extends StatelessWidget {
  const _AutocompleteField({
    Key? key,
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
    required this.readOnly,
    required this.decoration,
  }) : super(key: key);

  final FocusNode focusNode;

  final VoidCallback onFieldSubmitted;

  final TextEditingController textEditingController;

  final bool readOnly;

  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      onFieldSubmitted: (String value) => onFieldSubmitted(),
      style: Theme.of(context).textTheme.bodyText2,
      enabled: !readOnly,
      readOnly: readOnly,
      decoration: decoration,
    );
  }
}

// The default Material-style Autocomplete options.
class _AutocompleteOptions<T extends Object> extends StatelessWidget {
  const _AutocompleteOptions({
    Key? key,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
  }) : super(key: key);

  final AutocompleteOptionToString<T> displayStringForOption;

  final AutocompleteOnSelected<T> onSelected;

  final Iterable<T> options;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () => onSelected(option),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(displayStringForOption(option)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
