import 'package:oscar_ballot/app.dart';
import 'package:oscar_ballot/blocs.dart';
import 'package:oscar_ballot/config.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:flutter/material.dart';

void main() {
  Config.initRelease();
  Routes.createRoutes();

  runApp(BlocWrapper(child: OscarBallotApp()));
}