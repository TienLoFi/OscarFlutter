import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oscar_ballot/blocs/blocs.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';

class AuthLoginPage extends StatefulWidget {
  _AuthLoginState createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLoginPage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final userBloc = BlocProvider.getBloc<UserBloc>();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void _showAlertDialog() {
    // Create the AlertDialog
    AlertDialog alert =  AlertDialog(
      title: Text("Invalid credentials"),
      content: Text("Email or password is incorrect."),
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

  void pushToRegisterPage()
  {
      Routes.navigate(context, Routes.authRegister, {});
  }

  void pushToPasswordRemindPage()
  {
      Routes.navigate(context, "/auth/password_remind", {});
  }

  void pushToMainPage()
  {
      Routes.navigate(context, Routes.siteMain, {});
  }

  void signInWithEmailAndPassword() async {
    try {
       userBloc.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ).then((value) => {
        if (value) {
          pushToMainPage()
        } else {
          _showAlertDialog()
        }
      });
      
    } on PlatformException catch (e) {
      print(e.code);
      _showAlertDialog();
    }
  }

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(height: 16.0),
                // Login Title
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Consts.primaryColor
                  ),
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
                ),
                SizedBox(height: 12.0),
                // Password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Hide password
                  validator: (value) {
                     if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                      return null;
                  },
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                  },
                  child: Button(
                  width: 188.0,
                  title: 'Login',
                  action: () {
                    if (formKey.currentState!.validate()) {
                      signInWithEmailAndPassword();
                    }
                  })
                ),
                // Enter Button
                SizedBox(height: 16.0),
                // Link "Not a Member? REGISTER HERE"
                TextButton(
                  onPressed: () {
                    pushToRegisterPage();
                  },
                  child: Text("Not a Member? REGISTER HERE"),
                ),
                // Link "Reset Password"
                TextButton(
                  onPressed: () {
                    pushToPasswordRemindPage();
                  },
                  child: Text("Forgot password? PASSWORD RECOVERY"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

