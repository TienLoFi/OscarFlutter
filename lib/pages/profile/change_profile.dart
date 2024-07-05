import 'package:flutter/material.dart';
import 'package:oscar_ballot/blocs/blocs.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/models/user.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';


class ProfileChangeProfilePage extends StatefulWidget {
  @override
  _ProfileChangeProfilePageState createState() => _ProfileChangeProfilePageState();
}

class _ProfileChangeProfilePageState extends State<ProfileChangeProfilePage> {
  final GlobalKey<FormState> changeProfileFormKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  UserBloc _userBloc = BlocProvider.getBloc<UserBloc>();
  _ProfileChangeProfilePageState() {
    initialize();
  }

  void initialize() async
  {
    final result = await Api().getMyProfile();
    print(result);
    User user =  _userBloc.user;
    _nameController.text = user.name = result['data']['name'];
    _emailController.text = user.email = result['data']['email'];
    _userBloc.prefBloc.setUser(user);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Profile'),
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
        key: changeProfileFormKey,
        child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {
                setState(() {
                  _nameController.text = value;
                });
              },
              validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name must not be empty';
                  }
                  return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                setState(() {
                  _emailController.text = value;
                });
              },
              validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email must not be empty';
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
                      if (changeProfileFormKey.currentState!.validate()) {
                        Api().changProfile(
                          name: _nameController.text,
                          email: _emailController.text
                        ).then((value) => {
                           if (value['status']) {
                              initialize(),
                              Navigator.of(context).pop()
                           }
                        });
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