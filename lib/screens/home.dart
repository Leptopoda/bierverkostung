// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import 'package:bierverkostung/shared/constants.dart';
import 'package:bierverkostung/services/local_storage.dart';
import 'package:bierverkostung/services/notifications.dart';
import 'package:bierverkostung/models/users.dart';

import 'package:bierverkostung/screens/bierverkostung/bierverkostung.dart';
import 'package:bierverkostung/screens/trinkspiele/trinkspiele.dart';
import 'package:bierverkostung/screens/statistiken/disp_statistiken.dart';

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
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    final UserData _user = Provider.of<UserData?>(context)!;
    final bool? isFirstLogin = await LocalDatabaseService().isFirstLogin();
    if (isFirstLogin != true) {
      NotificationService().askPermission(_user);
      LocalDatabaseService().setFirstLogin();
    }
    await NotificationService().initialise();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimens) {
        if (dimens.maxWidth >= kDesktopBreakpoint) {
          return _desktopView();
        }
        if (dimens.maxWidth >= kTabletBreakpoint) {
          return _tabletView();
        }
        return _mobileView();
      },
    );
  }

  Widget _desktopView() {
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
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _tabletView() {
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
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _mobileView() {
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
  }

  IndexedStack _buildBody() {
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
