// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/shared/constants.dart';

class MasterDetailContainer extends StatefulWidget {
  final Widget master;
  final Widget? detail;
  final PreferredSizeWidget? appBar;
  final Widget? fab;

  const MasterDetailContainer({
    Key? key,
    required this.master,
    this.detail,
    this.fab,
    this.appBar,
  }) : super(key: key);

  @override
  _MasterDetailContainerState createState() => _MasterDetailContainerState();
}

class _MasterDetailContainerState extends State<MasterDetailContainer> {
  Widget? child;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      return _buildMobileLayout();
    } else {
      return _buildTabletLayout();
    }
  }

  Widget _detail() {
    if (widget.detail != null) {
      return widget.detail!;
    } else {
      return const Center(
        child: Text('noch nichts Ausgewählt'),
      );
    }
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: widget.appBar,
      body: widget.master,
      floatingActionButton: widget.fab,
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      appBar: widget.appBar,
      body: Row(
        children: <Widget>[
          Flexible(
            child: Material(
              elevation: 4.0,
              child: widget.master,
            ),
          ),
          Flexible(
            flex: 3,
            child: _detail(),
          ),
        ],
      ),
      floatingActionButton: widget.fab,
    );
  }

  /* void onTap(BuildContext context, Widget detail) {
    if (isMobile(context)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => detail,
        ),
      );
    } else {
      setState(() {
        child = detail;
      });
    }
  } */
}
