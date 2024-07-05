import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  AppBloc() {
    _homePage.add(0);
  }

  final BehaviorSubject<int> _homePage = BehaviorSubject<int>();

  Stream<int> get homePageStream => _homePage.stream;

  set homeIndex(int idx) {
    _homePage.add(idx);
  }

  @override
  void dispose() {
    _homePage.close();
    super.dispose();
  }
}
