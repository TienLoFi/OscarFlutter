import 'package:flutter/material.dart';
import 'package:oscar_ballot/blocs/blocs.dart';

class BlocWrapper extends StatelessWidget {
  const BlocWrapper({Key? key, this.child = const SizedBox()}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => AppBloc()),
        Bloc((i) => UserBloc()),
        Bloc((i) => PreferencesBloc()),
      ],
      dependencies: [],
      child: child
    );
  }
}
