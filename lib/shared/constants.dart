// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

@Deprecated('Use master detail scaffold instead')
const double kTabletBreakpoint = 720.0;
@Deprecated('Use master detail scaffold instead')
const double kDesktopBreakpoint = 1440.0;
@Deprecated('Use master detail scaffold instead')
const double kListViewWidth = 300.0;
@Deprecated('Use master detail scaffold instead')
const double kSideMenuWidth = 250.0;

@Deprecated('Use master detail scaffold instead')
double width(BuildContext context) => MediaQuery.of(context).size.width;

@Deprecated('Use master detail scaffold instead')
bool isMobile(BuildContext context) {
  if (MediaQuery.of(context).size.width >= kTabletBreakpoint) {
    return false;
  } else {
    return true;
  }
}
