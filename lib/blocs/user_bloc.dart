import 'dart:async';
// ignore: library_prefixes
import 'dart:convert' as JSON;
import 'package:oscar_ballot/blocs/blocs.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:http/http.dart' as http;
import 'package:oscar_ballot/services/api.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:oscar_ballot/models/user.dart';

class UserBloc extends BlocBase {
  PreferencesBloc _prefBloc = BlocProvider.getBloc<PreferencesBloc>();
  final _onAuthStateChanged = BehaviorSubject<User>.seeded(User());
  final FacebookLogin _facebookSignIn = FacebookLogin();
  final TwitterLogin _twitterLogin = TwitterLogin(
    apiKey: Consts.TWITTER_CONSUMER_KEY,
    apiSecretKey: Consts.TWITTER_CONSUMER_SCRET,
    redirectURI: '/'
  );
  User? _user;
  bool _isLoggedIn = false;
  String? _accessToken;
  User get user => _user!;
  PreferencesBloc get prefBloc => _prefBloc;

  Stream<User> get onAuthStateChanged => _onAuthStateChanged.stream;

  set user(User usr) {
    _user = usr;
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;

  String get accessToken => _accessToken!;

  UserBloc() : super() {
    initialize();
    _onAuthStateChanged.listen((usr) {
      if (usr.name.isEmpty) {
        _isLoggedIn = false;
        notifyListeners();
        Routes.navigate(navigatorKey.currentContext!, Routes.authLogin, {});
        return;
      }

      _isLoggedIn = true;
      notifyListeners();
    });
  }

  void initialize() async {
    await _prefBloc.isAvailable;
    if (_prefBloc.isExpired()) {
       signOut();
       return;
    }
    _user = _prefBloc.user();
    _accessToken = _prefBloc.accessToken();
    if (_user?.id != 0) {
      _isLoggedIn = true;
    }

  }

  Future<FacebookLoginResult> signInWithFacebook() async {
    final FacebookLoginResult result = await _facebookSignIn.logIn();
    if (result.status == FacebookLoginStatus.success) {
      final FacebookAccessToken accessToken = result.accessToken!;
      final fbLogin = await Api().loginFacebook(accessToken.token);
      print(fbLogin);

      // New user => update info using data from Facebook
      if (fbLogin["first_name"] == null && fbLogin["last_name"] == null) {
        Uri uri = Uri.parse('https://graph.facebook.com/v7.0/${accessToken.userId}?fields=first_name,last_name,picture&size=medium&access_token=${accessToken.token}');
        final graphResponse = await http.get(uri);
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        await Api().updateInfo(
          firstName: profile['first_name'],
          lastName: profile['last_name'],
        );
      }
      final res = await Api().getMyProfile();
      _user = User(
        id: res['id'],
        name: res['name'],
        email: res['email'],
        avatar: res['avatar'],
      );
      _prefBloc.setUser(_user!);

    }
    _onAuthStateChanged.add(_user!);
    return result;
  }

  Future<bool> signInWithTwitter() async {
    final AuthResult result = await _twitterLogin.login();
    switch (result.status!) {
      case TwitterLoginStatus.loggedIn:

        await Api().loginTwitter(result.authToken!);

        return true;
      case TwitterLoginStatus.cancelledByUser:
        print('Login cancelled by user.');
        return false;
      case TwitterLoginStatus.error:
        print('Login error: ${result.errorMessage}');
        return false;
    }

  }
Future<bool> signInWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  final res = await Api().loginEmailPassword(email, password);
  if (res['status']) {
    // Checking and using null-safe operators to avoid exceptions
    final userId = res['user']['id'];
    final userEmail = res['user']['email'];
    final userName = res['user']['name'];
    final token = res['token'];
    final expiryDate = res['expiry_date'];

    // Ensure these values are not null
    if (userId != null && userEmail != null && userName != null && token != null && expiryDate != null) {
      _user = User(
        id: int.parse(userId),
        email: userEmail,
        name: userName,
      );
      _accessToken = token;
      _prefBloc.setUser(_user!);
      _prefBloc.setAccessToken(_accessToken!);
      _prefBloc.setExpiryDate(expiryDate);
      _onAuthStateChanged.add(_user!);
    } else {
      // Handle the case where any of these are null
      print('Error: One or more fields in the response are null');
      return false;
    }
  }

  return res['status'];
}
  Future<void> signOut() async {
    _isLoggedIn = false;
    _accessToken = null;
    _user = null;
    _prefBloc.remove('user');
    _prefBloc.remove('access_token');
    _prefBloc.remove('expiry_date');
  }

}
