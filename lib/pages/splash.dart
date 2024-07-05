import 'package:flutter/material.dart';
import 'package:oscar_ballot/blocs/blocs.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/pages/main.dart';
import 'package:oscar_ballot/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
 
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  bool isLoading = true;
  UserBloc userBloc = BlocProvider.getBloc<UserBloc>();
  @override
  void initState() {
    super.initState();
    initialize();
  }


  void initialize() async {
    // Trigger bloc Instantiate
    BlocProvider.getBloc<AppBloc>();
    await userBloc.prefBloc.isAvailable;
    _doneLoading();
  }

  void _doneLoading() async {
    if (!userBloc.isLoggedIn) {
      setState(() {
        isLoading = false;
        Routes.navigate(context, Routes.authLogin, {});
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SiteMainPage()),
      );
    }
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color of the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/logo.png', // Path to the logo image
              width: 150, // Width of the logo
              height: 150, // Height of the logo
            ),
            SizedBox(height: 20), // Spacing between the logo and the text
            // Text "Oscar Ballot Predictions" with color #FFE52D
            Text(
              'Oscar Ballot Predictions',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Consts.accentColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}