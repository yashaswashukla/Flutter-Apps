import 'package:flutter/material.dart';
import '../Screens/filters_screen.dart';

Widget _buildListTile(String title, IconData icon, Function tapHandler) {
  return ListTile(
    leading: Icon(
      icon,
      size: 26,
    ),
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    ),
    onTap: tapHandler,
  );
}

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildListTile(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          _buildListTile(
            'Filters',
            Icons.settings,
            () {
              Navigator.of(context)
                  .pushReplacementNamed(FilterScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
