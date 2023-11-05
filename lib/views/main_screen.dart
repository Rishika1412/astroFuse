import 'package:flutter/material.dart';

import '../components/custom_app_bar.dart';
import 'home_screen.dart';
import 'other_screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const Screen(screenName: 'Chat'),
    const Screen(screenName: 'Live'),
    const Screen(screenName: 'Call'),
    const Screen(screenName: 'History'),
  ];
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldkey,
      appBar: customAppBar(),
      drawer: const Drawer(
        child: Center(child: Text('Side Drawer')),
      ),
      bottomNavigationBar: customBottomNavBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    ));
  }

  Widget customBottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Live'),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Call'),
        BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar), label: 'History'),
      ],
      onTap: (index) {
        setState(() => _selectedIndex = index);
      },
    );
  }
}
