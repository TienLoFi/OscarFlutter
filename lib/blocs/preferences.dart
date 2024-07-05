import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:oscar_ballot/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesBloc extends BlocBase {
  SharedPreferences? _prefs;

  Future<bool> get isAvailable => _completer.future;

  SharedPreferences get prefs => _prefs!;
  Completer<bool> _completer = Completer();

  PreferencesBloc() : super() {
    SharedPreferences.getInstance().then((prefs) async {
      _prefs = prefs;
      _completer.complete(true);
    });
  }

  void setUser(User user) {
    Map<String, dynamic> userInfo = {
        'id': user.id,
        'name': user.name,
        'email': user.email
      };
    _prefs!.setString('user', json.encode(userInfo));
  }

  User user() {
    Map<String, dynamic> userInfoJson = json.decode(_prefs!.getString('user')??'{}');
  
    return User.fromJson(userInfoJson);
  }

  void setAccessToken(String accessToken) {
    _prefs!.setString('access_token', accessToken);
  }

  String accessToken()
  {
    return _prefs!.getString('access_token')??'';

  }

  void setExpiryDate(String expiryDate)
  {
    _prefs!.setString('expiry_date', expiryDate);
  }

  bool isExpired()
  {
    String expiryDate = _prefs!.getString('expiry_date')??'';
    if (expiryDate.isEmpty) return false;
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime expirationDate = dateFormat.parse(expiryDate);
    DateTime now = DateTime.now();
    return now.isAfter(expirationDate) || now.isAtSameMomentAs(expirationDate);
  }

  void remove(String key)
  {
    _prefs!.remove(key);
  }

}
