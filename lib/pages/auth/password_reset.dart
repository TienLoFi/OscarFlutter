import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';

class AuthPasswordResetPage extends StatefulWidget {
  final String email;
  AuthPasswordResetPage({this.email = ''});
  @override
  _AuthResetPasswordState createState() => _AuthResetPasswordState();
}

class _AuthResetPasswordState extends State<AuthPasswordResetPage> {
  bool _isLoading = false;
  bool _isFormEnabled = true;
  final TextEditingController _verifyCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _passwordResetFormKey = GlobalKey<FormState>();
  void pushToMainPage() 
  {
    Routes.navigate(context, Routes.siteMain, {});
  }

  void _showAlertDialog(String messsage) {
    // Create the AlertDialog
    AlertDialog alert =  AlertDialog(
      title: Text("Error"),
      content: Text(messsage),
      actions: [
        // Add button to close the dialog
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Close"),
        ),
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void passwordReset() async
  {
     setState(() {
      _isLoading = true;
      _isFormEnabled = false;
    });
    try {
      final res = await Api().resetPassword(widget.email, _passwordController.text, _confirmPasswordController.text, _verifyCodeController.text);
      if (res['status']) {
        pushToMainPage();
      } else {
        _showAlertDialog(res['message']);
      }
      setState(() {
        _isLoading = false;
        _isFormEnabled = true;
      });
    } on PlatformException catch (e) {
      print(e.code);
       setState(() {
        _isFormEnabled = true;
        _isLoading = false;
      });
    }
  }
  
  void resendOTP() async
  {
    setState(() {
      _isLoading = true;
      _isFormEnabled = false;
    });
    try {
      final res = await Api().resendOTP(widget.email, "ACTION_FORGOT_PASSWORD");
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
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: _passwordResetFormKey,
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
                SizedBox(height: 12.0),
                // Verify Code
                TextFormField(
                  controller: _verifyCodeController,
                  decoration: InputDecoration(
                    labelText: 'Verification Code',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Verification Code must not be empty';
                    }
                    return null;
                  },
                  enabled: _isFormEnabled,
                ),
                SizedBox(height: 16.0),
                // Password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, 
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password must not be empty';
                    }
                    return null;
                  },// Hide password
                  enabled: _isFormEnabled,
                ),
                SizedBox(height: 12.0),
                // Password Confirmation
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Password Confirmation',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Hide password
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password Confirmation must not be empty';
                    }
                    return null;
                  },
                  enabled: _isFormEnabled,
                ),
                SizedBox(height: 16.0),
                // Change Button
                GestureDetector(
                  onTap: () {
                  },
                  child: Button(
                    width: 188.0,
                    title: 'Send',
                    action: () {
                      if (_passwordResetFormKey.currentState!.validate()) {
                        passwordReset();
                      }
                    }
                  )
                ),
                // Link "Didn't receive the verification code? SEND AGAIN"
                TextButton(
                  onPressed: () {
                    resendOTP();
                  },
                  child: Text("Didn't receive the verification code? SEND AGAIN"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}