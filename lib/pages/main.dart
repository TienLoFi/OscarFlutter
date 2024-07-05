// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/pages/site/ballot/ballot.dart';
import 'package:oscar_ballot/pages/site/group/my_groups.dart';

class SiteMainPage extends StatefulWidget {
  @override
  _SiteMainPageState createState() => _SiteMainPageState();
}

class _SiteMainPageState extends State<SiteMainPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    SiteBallotPage(),
    SiteMyGroupsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.ballot),
              label: 'Ballot',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'My Groups',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Consts.primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  
}