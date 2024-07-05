import 'package:flutter/material.dart';
import 'package:oscar_ballot/blocs/blocs.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/models/user.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/services/api.dart';


class UserSidebar extends StatefulWidget {
  @override
  _UserSidebarState createState() => _UserSidebarState();
}

class _UserSidebarState extends State<UserSidebar> {
  String? _name;
  String? _email;
  UserBloc _userBloc = BlocProvider.getBloc<UserBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Call a function to reload data when the screen is first built
      _fetchData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load data here
    _fetchData();
  }

  Future<void> _fetchData() async {
    final result = await Api().getMyProfile();
    if (result['status']) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        setState(() {
          User user = _userBloc.prefBloc.user();
          _name = user.name;
          _email = user.email;
        });
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_name??"Jame Bond"),
            accountEmail: Text(_email??"jamebond@oscarballot.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'), // Avatar image
            ),
            decoration: BoxDecoration(
              color: Consts.primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Change Password'),
            onTap: () {
              Routes.navigate(context, Routes.profileChangePassword, {});
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Change Profile'),
            onTap: () {
              Routes.navigate(context, Routes.profileChangeProfile, {});
            },
          ),
    ListTile(
            leading: Icon(Icons.person),
            title: Text('Movies'),
            onTap: () {
              Routes.navigate(context, Routes.moviesSideBar, {});
            },
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              _userBloc.signOut();
              Routes.navigate(context, Routes.authLogin, {});
            },
          ),
          // Add more list tiles for additional sidebar items
        ],
      ),
    );
  }
}