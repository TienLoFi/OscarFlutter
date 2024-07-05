import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';

class AuthPasswordRemindPage extends StatefulWidget {
  _AuthPasswordRemindState createState() => _AuthPasswordRemindState();
}

class _AuthPasswordRemindState extends State<AuthPasswordRemindPage> {
  bool _isLoading = false;
  bool _isFormEnabled = true;
  final GlobalKey<FormState> _passwordRemindFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void pushToLoginPage()
  {
      Routes.navigate(context, Routes.authLogin, {});
  }

  void pushToPasswordResetPage()
  {
      var email = _emailController.text;
      Routes.navigate(context, "/auth/password_reset/$email", {});
  }

  void passwordRemind() async
  {
    setState(() {
      _isLoading = true;
      _isFormEnabled = false;
    });
    try {
      final res = await Api().passwordRemind( _emailController.text);
      if (res['status']) {
        pushToPasswordResetPage();
      }
      setState(() {
        _isLoading = false;
      });
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
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: _passwordRemindFormKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and Slogan
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png', // Path to the logo image
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 8.0),
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
                SizedBox(height: 20.0),
                Visibility(
                  visible: _isLoading,
                  child: CircularProgressIndicator(),
                ),
                SizedBox(height: 32.0),
                // Reset Password Title
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Consts.primaryColor
                  ),
                ),
                SizedBox(height: 16.0),
                // Description
                Text(
                  'Please enter your email to reset your password',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email must not be empty';
                    }
                    return null;
                  },
                  enabled: _isFormEnabled,
                ),
                SizedBox(height: 16.0),
                // Send Button
                GestureDetector(
                  onTap: () {
                  },
                  child: Button(
                    width: 188.0,
                    title: 'Send',
                    action: () {
                      if (_passwordRemindFormKey.currentState!.validate()) {
                        passwordRemind();
                      }
                    }
                  )
                ),
                SizedBox(height: 16.0),
                 // Link "Back to login page"
                TextButton(
                  onPressed: () {
                    pushToLoginPage();
                  },
                  child: Text("BACK TO LOGIN"),
                ),
                SizedBox(height: 16.0),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}