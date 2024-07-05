import 'package:flutter/material.dart';

class AdminSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("John Doe"),
            accountEmail: Text("john.doe@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'), // Avatar image
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My profile'),
            onTap: () {
              // Handle Home tap
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Groups'),
            onTap: () {
              // Handle Settings tap
            },
          ),
          ListTile(
            leading: Icon(Icons.assistant),
            title: Text('Nominations'),
            onTap: () {
              // Handle Settings tap
            },
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              // Handle Settings tap
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              // Handle Settings tap
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Award Results'),
            onTap: () {
              // Handle Settings tap
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Users'),
            onTap: () {
              // Handle Settings tap
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            onTap: () {
              // Handle Settings tap
            },
          ),
        ],
      ),
    );
  }
}