// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'statistiken_list.dart';

/// PieChart on select Notifier
///
/// Notifies its subscribers about a selected [Beer] in the [StatsList]
class _PieChartNotifier extends ChangeNotifier {
  int _selected = -1;

  int get selected => _selected;

  set selected(int value) {
    _selected = value;
    notifyListeners();
  }
}
