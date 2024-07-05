// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:oscar_ballot/blocs/blocs.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';


class ProfileChangePasswordPage extends StatefulWidget {
  @override
  _ProfileChangePasswordPageState createState() => _ProfileChangePasswordPageState();
}

class _ProfileChangePasswordPageState extends State<ProfileChangePasswordPage> {
  final GlobalKey<FormState> _changePasswordFormKey = GlobalKey<FormState>();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();
  UserBloc _userBloc = BlocProvider.getBloc<UserBloc>();

  void changePassword() async {
      final res = await Api().changePassword(
        passwordOld: _oldPasswordController.text,
        password: _newPasswordController.text,
        confirmPassword: _confirmNewPasswordController.text,
      );
      if (res['status']) {
        _userBloc.signOut();
      }

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
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
      body: Form(
        key: _changePasswordFormKey,
        child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                labelText: 'Old Password',
              ),
              onChanged: (value) {
                setState(() {
                  _oldPasswordController.text = value;
                });
              },
              obscureText: true, // Hide password
              validator: (value) {
                  if (value!.isEmpty) {
                    return 'Old Password must not be empty';
                  }
                  return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              onChanged: (value) {
                setState(() {
                  _newPasswordController.text = value;
                });
              },
              obscureText: true, // Hide password
              validator: (value) {
                  if (value!.isEmpty) {
                    return 'New Password must not be empty';
                  }
                  return null;
              },              
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _confirmNewPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
              ),
              onChanged: (value) {
                setState(() {
                  _confirmNewPasswordController.text = value;
                });
              },
              obscureText: true, // Hide password
              validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirm New Password must not be empty';
                  }
                  return null;
              },              
            ),
            SizedBox(height: 20.0),
            GestureDetector(
                  onTap: () {
                  },
                  child: Button(
                    width: 188.0,
                    title: 'Change',
                    action: () {
                      if (_changePasswordFormKey.currentState!.validate()) {
                        changePassword();
                        Routes.navigate(context, Routes.authLogin, {});
                      }
                    }
                  )
                ),
          ],
        ),
      ),
    ));
  }
}