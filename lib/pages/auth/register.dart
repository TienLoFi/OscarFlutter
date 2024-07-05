import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';

class AuthRegisterPage extends StatefulWidget {
  @override
  _AuthRegisterPageState createState() => _AuthRegisterPageState();
}


class _AuthRegisterPageState extends State<AuthRegisterPage> {
  bool _isLoading = false;
  bool _isFormEnabled = true;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  void pushToLoginPage()
  {
    Routes.navigate(context, Routes.authLogin, {});
  }

  void pushToVerifyOTP()
  {
    final email = _emailController.text;
    const action = "ACTION_VERIFY_EMAIL_AFTER_REGISTER";
    Routes.navigate(context, "/auth/verify_otp/$email/$action", {});
  }

  void registerUser() async {
    setState(() {
      _isLoading = true;
      _isFormEnabled = false;
    });
    try {
      final res = await Api().register(_nameController.text, _emailController.text, _passwordController.text, _confirmPasswordController.text);
      if (res['status']) {
        
        pushToVerifyOTP();
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
          key: _registerFormKey,
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
                // Register Title
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Consts.primaryColor
                  ),
                ),
                SizedBox(height: 16.0),
                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                  enabled: _isFormEnabled,
                ),
                SizedBox(height: 12.0),
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
                  enabled: _isFormEnabled,                  
                ),
                SizedBox(height: 12.0),
                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Hide password
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirm Password must not be empty';
                    }
                    return null;
                  },
                  enabled: _isFormEnabled,  
                ),
                SizedBox(height: 16.0),
                // Enter Button
                GestureDetector(
                  onTap: () {
                  },
                  child: Button(
                    width: 188.0,
                    title: 'Enter',
                    action: () {
                      if (_registerFormKey.currentState!.validate()) {
                        registerUser();
                      }
                    }
                  )
                ),

                SizedBox(height: 16.0),
                // Link "Not a Member? REGISTER HERE"
                TextButton(

                  onPressed: () {
                    pushToLoginPage();
                  },
                  child: Text("Have an account? PLEASE LOGIN"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}