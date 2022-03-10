import 'package:flutter/material.dart';
import 'package:ox_flutter/home/pages/events/events.dart';
import 'package:ox_flutter/home/pages/menu/menu.dart';
import 'package:ox_flutter/home/pages/news/news.dart';
import 'package:ox_flutter/home/pages/tv/tv.dart';
import 'dart:math' as math;

import 'package:ox_flutter/utils/fade_indexed_stack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<ScrollController> _controllers = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];

  late final List<Widget> _pages = [
    News(scrollController: _controllers[0]),
    Tv(scrollController: _controllers[1]),
    Events(scrollController: _controllers[2]),
    Menu(scrollController: _controllers[3]),
  ];

  late Widget _currentPage;

  void _changePage(int index) {
    if (index == _selectedIndex) {
      _controllers[index].animateTo(0,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      return;
    }
    setState(() {
      _selectedIndex = index;
      _currentPage = _pages[_selectedIndex];
    });
  }

  @override
  void initState() {
    super.initState();
    _currentPage = _pages[_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(
          semanticLabel: 'Otwórz menu aplikacji',
        ),
        body: FadeIndexedStack(
          index: _selectedIndex,
          children: _pages,
          duration: Duration(milliseconds: 250),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedIndex: _selectedIndex,
          selectIndex: _changePage,
        ));
  }
}

class BottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) selectIndex;
  const BottomNavigationBar(
      {Key? key, required this.selectedIndex, required this.selectIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: selectIndex,
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined),
            label: 'GŁÓWNA',
            selectedIcon: Icon(Icons.newspaper),
          ),
          NavigationDestination(
            icon: Icon(Icons.smart_display_outlined),
            label: 'TELEWIZJA',
            selectedIcon: Icon(Icons.smart_display),
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            label: 'WYDARZENIA',
            selectedIcon: Icon(Icons.event_note),
          ),
          NavigationDestination(
            icon: Icon(Icons.widgets_outlined),
            label: 'MENU',
            selectedIcon: Icon(Icons.widgets),
          ),
        ]);
  }
}
