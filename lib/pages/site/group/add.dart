import 'package:flutter/material.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';

class SiteGroupAddPage extends StatefulWidget {
  @override
  _SiteGroupAddPageState createState() => _SiteGroupAddPageState();
}

class _SiteGroupAddPageState extends State<SiteGroupAddPage> {
  final GlobalKey<FormState> _siteAddGroupFormKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _groupNumberController = TextEditingController();
  TextEditingController _groupPasswordController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  void _createGroup()
  {
      Api().siteGroupAdd(
        _nameController.text,
        _descController.text,
        1,
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
        title: Text('Add Group'),
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
          key: _siteAddGroupFormKey,
          child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
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
              SizedBox(height: 16.0),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    _descController.text = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                },
                child: Button(
                  width: 188.0,
                  title: 'Create',
                  action: () {
                    if (_siteAddGroupFormKey.currentState!.validate()) {
                      _createGroup();
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