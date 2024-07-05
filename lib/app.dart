import 'package:oscar_ballot/pages/auth/login.dart';
import 'package:oscar_ballot/pages/auth/password_remind.dart';
import 'package:oscar_ballot/pages/auth/password_reset.dart';
import 'package:oscar_ballot/pages/auth/register.dart';
import 'package:oscar_ballot/pages/splash.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:oscar_ballot/consts.dart';

final ThemeData kDefaultTheme = ThemeData(
  primaryColor: Consts.primaryColor,
  primarySwatch: Colors.orange,
  scaffoldBackgroundColor: Colors.white,
  canvasColor: Colors.white,
  disabledColor: Colors.black45,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  fontFamily: Consts.FONT_SF_PRO,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      color: Consts.darkColor,
      height: 1.0,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TextStyle(
      color: Consts.darkColor,
      height: 1.4,
      fontSize: 17.0,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      color: Consts.darkColor,
      height: 1.4,
      fontSize: 17.0,
      fontWeight: FontWeight.normal,
    ),
    titleLarge: TextStyle(
      color: Consts.darkColor,
      height: 1.0,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: Consts.textGreyColor,
      height: 1.0,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: Consts.textGreyColor,
      height: 1.0,
      fontSize: 13.0,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      color: Consts.darkColor,
      height: 1.0,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: Consts.darkColor,
      height: 1.0,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      color: Consts.textGreyColor,
      height: 1.0,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
  ),
);

///============ Main App Widget =============
class OscarBallotApp extends StatefulWidget {
  const OscarBallotApp({Key? key}) : super(key: key);
  @override
  OscarBallotAppState createState() => OscarBallotAppState();
}

class OscarBallotAppState extends State<OscarBallotApp> with WidgetsBindingObserver {
  final String title = 'Oscar Ballot';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: kDefaultTheme,
      home: SplashPage(),
      navigatorObservers: [
        routeObserver
      ],
      navigatorKey: navigatorKey,
      onGenerateRoute: Routes.fluro.generator
    );
  }
}