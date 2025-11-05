import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Text(
              'Conference App Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),

          ListTile(
            leading: Icon(Icons.list),
            title: Text('Liste des conférences'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/list');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Ajouter une conférence'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/add');
            },
          ),
        ],
      ),
    );
  }
}