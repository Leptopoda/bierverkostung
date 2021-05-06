// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

const kTabletBreakpoint = 720.0;
const kDesktopBreakpoint = 1440.0;
const kListViewWidth = 300.0;
const kSideMenuWidth = 250.0;

double width(BuildContext context) => MediaQuery.of(context).size.width;

bool isMobile(BuildContext context) {
  if (MediaQuery.of(context).size.width >= kTabletBreakpoint) {
    return false;
  } else {
    return true;
  }
}
