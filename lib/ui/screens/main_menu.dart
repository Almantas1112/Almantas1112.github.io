import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:gov_tech/ui/screens/services.dart';

import 'map.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
      mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
      largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
      useDrawer: true,
      selectedIndex: _selectedIndex,
      onSelectedIndexChange: (int index) => _pageChange(index),
      destinations: _navBar,
      body: (_) => _pages.elementAt(_selectedIndex),
      smallBody: (_) => _pages.elementAt(_selectedIndex),
    );
  }

  final List<Widget> _pages = [
    const MapScreen(),
    const ServicesScreen(),
  ];

  final List<NavigationDestination> _navBar = [
    const NavigationDestination(
      icon: Icon(Icons.map),
      label: 'Žemėlapis',
    ),
    const NavigationDestination(
      icon: Icon(Icons.home_repair_service),
      label: 'Paslaugos',
    ),
  ];

  _pageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
