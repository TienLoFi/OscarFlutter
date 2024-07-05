import 'package:flutter/material.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';

class SiteGroupInviteMemberPage extends StatefulWidget {
  final int groupId;
  SiteGroupInviteMemberPage({this.groupId = 0});
  @override
  _SiteGroupInviteMemberPageState createState() => _SiteGroupInviteMemberPageState();
}

class _SiteGroupInviteMemberPageState extends State<SiteGroupInviteMemberPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  List<bool> _isCheckedList = [];

  void _searchMember() async {
    var res = await Api().siteGroupSearchMember(_searchController.text);
    if (res['status']) {
      _searchResults = [];
      setState(() {
        _searchResults = res['data'];
        _isCheckedList = List.filled(_searchResults.length, false);
      });

    }
    
  }

  void _sendInvitation() async {
    List<int> memberIds = [];
    for (int i = 0; i < _isCheckedList.length; i++) {
      if (_isCheckedList[i]) {
        memberIds.add(int.parse(_searchResults[i]['id']));
      }
      
    }
    var res = Api().siteGroupSendInvite(memberIds, widget.groupId);
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String errorMessage) {
    // Create the AlertDialog
    AlertDialog alert =  AlertDialog(
      title: Text("Error"),
      content: Text(errorMessage),
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

  void _clearInput() {
    setState(() {
      _searchController.clear();
      _searchResults.clear();
      _isCheckedList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite Member'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter Email or Name',
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchMember();
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  var member = _searchResults[index];
                  String name = "${member['name']}(${member['email']})";
                  return ListTile(
                    title: Text(name),
                    leading: Checkbox(
                      value: _isCheckedList[index],
                      onChanged: (value) {
                        setState(() {
                          _isCheckedList[index] = value!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _sendInvitation,
                  child: Text('Send'),
                ),
                ElevatedButton(
                  onPressed: _clearInput,
                  child: Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
