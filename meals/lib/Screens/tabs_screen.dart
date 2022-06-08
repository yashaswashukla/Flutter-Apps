import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../Widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': CategoriesScreen(),
      'title': 'Categories',
    },
    {
      'page': FavoritesScreen(),
      'title': 'Your Favorites',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        //Top navigation bar can be assigned this way:

        //   DefaultTabController(
        //     length: 2,
        //     child:
        //   Scaffold(
        // appBar: AppBar(
        //   title: Text('Meals'),
        //     bottom: TabBar(
        //       tabs: <Widget>[
        //         Tab(
        //           icon: Icon(Icons.category),
        //           text: 'Categories',
        //         ),
        //         Tab(
        //           icon: Icon(Icons.star),
        //           text: 'Favorites',
        //         ),
        //       ],
        //     ),
        //   ),
        //   body: TabBarView(
        //     children: [
        //       CategoriesScreen(),
        //       FavoritesScreen(),
        //     ],
        //   ),
        // ),

        //If we want to get the bottom navigation bar we have to configure it differently also we have to change the state manually

        Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
