// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/screens/bierverkostung/bierverkostung.dart';
import 'package:bierverkostung/screens/trinkspiele/trinkspiele.dart';
import 'package:bierverkostung/screens/statistiken/disp_statistiken.dart';

import 'package:bierverkostung/shared/constants.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemSelected(int index) {
    if (mounted) {
      _onPageChanged(index);
      _pageController.animateToPage(
        index,
        duration: kThemeAnimationDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  static const List<String> _pageTitles = [
    "Trinkspiele",
    "Bierverkostung",
    "Statistik",
  ];

  @override
  Widget build(BuildContext context) {
    const kSideMenuWidth = 250.0;
    return LayoutBuilder(
      builder: (context, dimens) {
        if (dimens.maxWidth >= kDesktopBreakpoint) {
          return Material(
            child: Row(
              children: [
                SizedBox(
                  width: kSideMenuWidth,
                  child: ListView(
                    children: [
                      ListTile(
                        selected: _selectedIndex == 0,
                        title: Text(_pageTitles[0]),
                        leading: const Icon(Icons.casino_outlined),
                        onTap: () => _onItemSelected(0),
                      ),
                      ListTile(
                        selected: _selectedIndex == 1,
                        title: Text(_pageTitles[1]),
                        leading: const Icon(Icons.home_outlined),
                        onTap: () => _onItemSelected(1),
                      ),
                      ListTile(
                        selected: _selectedIndex == 2,
                        title: Text(_pageTitles[2]),
                        leading: const Icon(Icons.show_chart),
                        onTap: () => _onItemSelected(2),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: buildBody(),
                ),
              ],
            ),
          );
        }
        if (dimens.maxWidth >= kTabletBreakpoint) {
          return Material(
            child: Row(
              children: [
                NavigationRail(
                  labelType: NavigationRailLabelType.all,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onItemSelected,
                  destinations: [
                    NavigationRailDestination(
                      icon: const Icon(Icons.casino_outlined),
                      label: Text(_pageTitles[0]),
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.home_outlined),
                      label: Text(_pageTitles[1]),
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.show_chart),
                      label: Text(_pageTitles[2]),
                    ),
                  ],
                ),
                Expanded(
                  child: buildBody(),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: const <Widget>[
              Trinkspiele(),
              Bierverkostung(),
              Statistiken(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemSelected,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.casino_outlined),
                label: _pageTitles[0],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: _pageTitles[1],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.show_chart),
                label: _pageTitles[2],
              ),
            ],
          ),
        );
      },
    );
  }

  IndexedStack buildBody() {
    return IndexedStack(
      index: _selectedIndex,
      children: const <Widget>[
        Trinkspiele(),
        Bierverkostung(),
        Statistiken(),
      ],
    );
  }
}
