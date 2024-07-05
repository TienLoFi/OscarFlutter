import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oscar_ballot/blocs/blocs.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/models/user.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';

class AuthVerifyOTPPage extends StatefulWidget {
  final String email;
  final String action;
  AuthVerifyOTPPage({this.email = '', this.action = ''});
  @override
  _AuthVerifyOTPPageState createState() => _AuthVerifyOTPPageState();
}

class _AuthVerifyOTPPageState extends State<AuthVerifyOTPPage> {
  String _otp = "";
  bool _isLoading = false;
  bool _isFormEnabled = true;
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final userBloc = BlocProvider.getBloc<UserBloc>();
  
  void pushToMainPage() 
  {
    Routes.navigate(context, Routes.authLogin, {});
  }

  void makeVerifyOTP() async
  {
    setState(() {
      _isLoading = true;
      _isFormEnabled = false;
    });
    final res = await Api().verifyOTP(widget.email, widget.action, _otp);
    if (res['status']) {
      User user = User(
        id:  int.parse(res['user']['id']),
        email: res['user']['email'],
        name: res['user']['name']
      );
      userBloc.prefBloc.setUser(user);
      setState(() {
        _isLoading = false;
        _isFormEnabled = true;
      });
      pushToMainPage();
    }
    setState(() {
      _isLoading = false;
      _isFormEnabled = true;
    });
  }

  void resendOTP() async
  {
    setState(() {
      _isLoading = true;
      _isFormEnabled = false;
    });
    try {
      final res = await Api().resendOTP(widget.email, widget.action);
      if (res['status']) {
        setState(() {
          _isLoading = false;
          _isFormEnabled = true;
        });
      }

    } on PlatformException catch (e) {
      print(e.code);
       setState(() {
        _isFormEnabled = true;
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify code'),
        backgroundColor: Consts.primaryColor,
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Change the color of the back button here
        )
      ),
      body: 
      Form(
        key: _otpFormKey,
        child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Logo and Slogan
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Path to the logo image
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Oscar Ballot Predictions', // Your slogan text
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Consts.accentColor
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Visibility(
              visible: _isLoading,
              child: CircularProgressIndicator(),
            ),
            SizedBox(height: 20.0),
            // Description
            Text(
              'We have sent a confirmation code to your email. Please use it for confirmation.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Verification Code',
              ),
              onChanged: (value) {
                setState(() {
                  _otp = value;
                });
              },
              enabled: _isFormEnabled,
            ),
            SizedBox(height: 20.0),
            Button(
              width: 188.0,
              title: 'Login',
              action: () {
                if (_otpFormKey.currentState!.validate()) {
                  makeVerifyOTP();
                }
              }
            ),
            // Link "Didn't receive the verification code? SEND AGAIN"
            TextButton(
              onPressed: () {
              },
              child: Text("Didn't receive the verification code? SEND AGAIN"),
            ),
          ],
        ),
      ),
    ));
  }
}