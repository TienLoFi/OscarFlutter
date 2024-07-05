import 'package:flutter/material.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';

class SiteGroupJoinPage extends StatefulWidget {
  @override
  _SiteGroupJoinPageState createState() => _SiteGroupJoinPageState();
}

class _SiteGroupJoinPageState extends State<SiteGroupJoinPage> {
  final GlobalKey<FormState> _siteJoinGroupFormKey = GlobalKey<FormState>();
  TextEditingController _groupNumberController = TextEditingController();
  TextEditingController _groupPasswordController = TextEditingController();

  void _joinGroup()
  {
      Api().siteGroupJoin(
        _groupNumberController.text,
        _groupPasswordController.text
      ).then((value) => {
        if (value['status']) {
            Navigator.of(context).pop()
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Group'),
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
          key: _siteJoinGroupFormKey,
          child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Group Number'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _groupNumberController.text = value;
                  });
                },
                validator: (value) {
                    if (value!.isEmpty) {
                      return 'Group number must not be empty';
                    }
                    return null;
                },    
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Group Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _groupPasswordController.text = value;
                  });
                },
                validator: (value) {
                    if (value!.isEmpty) {
                      return 'Group password must not be empty';
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
                  title: 'Join',
                  action: () {
                    if (_siteJoinGroupFormKey.currentState!.validate()) {
                      _joinGroup();
                    }
                  }
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}