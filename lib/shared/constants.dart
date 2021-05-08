// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

const double kTabletBreakpoint = 720.0;
const double kDesktopBreakpoint = 1440.0;
const double kListViewWidth = 300.0;
const double kSideMenuWidth = 250.0;

const String vapidKey =
    'BHzfRAVeY69M7uwBIzm8xiMaIZ0iDEbX9dgyvp87GKWWmlbXSt3arsWe9lQpjKF-OSM1RtOFTGnGrk-qnrYvF3s';

double width(BuildContext context) => MediaQuery.of(context).size.width;

bool isMobile(BuildContext context) {
  if (MediaQuery.of(context).size.width >= kTabletBreakpoint) {
    return false;
  } else {
    return true;
  }
}
