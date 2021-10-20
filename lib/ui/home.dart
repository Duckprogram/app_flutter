import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';

import 'bottombar/my_page.dart';
import 'bottombar/notification_page.dart';
import 'bottombar/search_page.dart';
import 'bottombar/home_page.dart';
import 'bottombar/market_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List _pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages = [
      HomePage(),
      SearchPage(),
      MarketPage(),
      NotificationPage(),
      MyPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  // color: Colors.grey.shade400,
                ),
                title: Text('홈'),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                title: Text('검색'),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag,
                ),
                title: Text('마켓'),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                ),
                title: Text('알림'),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                ),
                title: Text('My'),
                backgroundColor: Colors.white),
          ]),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
