// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';

import 'package:bierverkostung/shared/error_page.dart';

import '../l10n/localization_helper.dart';

void main() {
  testWidgets('Error page displays the error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const L10nHelper(
        child: SomethingWentWrong(error: 'Error Test'),
      ),
    );

    final Finder errorFinder = find.textContaining('Error Test');

    expect(errorFinder, findsOneWidget);
  });
}
