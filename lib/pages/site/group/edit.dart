import 'package:flutter/material.dart';
import 'package:oscar_ballot/blocs/blocs.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/models/user.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';

class SiteGroupEditPage extends StatefulWidget {
  final int groupId;
  SiteGroupEditPage({this.groupId = 0});
  @override
  _SiteGroupEditPageState createState() => _SiteGroupEditPageState();
}

class _SiteGroupEditPageState extends State<SiteGroupEditPage> {
  UserBloc userBloc = BlocProvider.getBloc<UserBloc>();
  bool _isGroupLeader = false;
  bool _isGroupCreator = false;
  Map<String, dynamic> _group = {};
  List<dynamic> _members = [];
  String _searchQuery = '';
  final GlobalKey<FormState> _siteEditGroupFormKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _groupNumberController = TextEditingController();
  TextEditingController _groupPasswordController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Call a function to reload data when the screen is first built
      _fetchData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load data here
    _fetchData();
  }

  void _saveGroup()
  {
      Api().siteGroupUpdate(
        widget.groupId,
        _nameController.text,
        _descController.text,
        _groupNumberController.text,
        _groupPasswordController.text
      ).then((value) => {
        if (value['status']) {
            Navigator.pop(context, true)
        }
      });
  }

  Future<void> _fetchData() async {
    final res = await Api().siteGroupDetail(widget.groupId);
    if (res['status']) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        setState(() {
          _nameController.text = res['data']['name'];
          _groupNumberController.text = res['data']['group_number'];
          _groupPasswordController.text = res['data']['group_password'];
          _descController.text = res['data']['desc'];
          _members = res['data']['members'];
          User user = userBloc.user;
          if (user.id == int.parse(res['data']['user_id'])) {
            _isGroupCreator = true;
          }
          if (user.id == int.parse(res['data']['leader_id'])) {
            _isGroupLeader = true;
          }
        });
      }

    }
  }

  void _removeMember(int groupId, int userId) async
  {
    final res = await Api().siteGroupRemoveMember(groupId, userId);
    if (res['status']) {
      _fetchData();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Edit'),
        backgroundColor: Consts.primaryColor,
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Change the color of the back button here
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_siteEditGroupFormKey.currentState!.validate()) {
                _saveGroup();
              }
              
            },
          ),
        ],
      ),
      body:SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: 
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _siteEditGroupFormKey,
                        child: Column(children: [
                            Text(
                                'Group Info',
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(labelText: "Name"),
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
                                controller: _groupNumberController,
                                decoration: InputDecoration(labelText: "Group Number"),
                                onChanged: (value) {
                                  setState(() {
                                    _groupNumberController.text = value;
                                  });
                                },
                                validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Group Number must not be empty';
                                    }
                                    return null;
                                }, 
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _groupPasswordController,
                                decoration: InputDecoration(labelText: "Group Password"),
                                onChanged: (value) {
                                  setState(() {
                                    _groupPasswordController.text = value;
                                  });
                                },
                                validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Group Password must not be empty';
                                    }
                                    return null;
                                }, 
                              ),
                              SizedBox(height: 16.0),
                              TextField(
                                controller: _descController,
                                decoration: InputDecoration(labelText: 'Description'),
                              ),
                        ],) 
                      ),
                      
                      SizedBox(height: 24.0),
                      Text(
                        'Members(${_members.length})',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search by name, email',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                      
                    ]
                  )
              )
            ),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _members.length, // Replace with actual member count
                itemBuilder: (BuildContext context, int index) {
                  var member = _members[index];
                  int groupId = int.parse(member['group_id']);
                  int userId = int.parse(member['user_id']);
                  if (_searchQuery.isNotEmpty &&
                      !member['email'].toLowerCase().contains(_searchQuery) &&
                      !member['name'].toLowerCase().contains(_searchQuery)) {
                    return Container();
                  }
                  // Replace with member information
                  return ListTile(
                    title: Text(member['name']),
                    subtitle: Text(member['email'] + '\n'+ 'Score: ${member['score']??0}' + '\n'+ 'Status: ${member['status'] == 1?'Active' : 'Pending'}'),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                        icon: Icon(Icons.delete),
                          onPressed: () {
                            _removeMember(groupId, userId);
                          },
                        ),
                      ],
                    ),
                    titleTextStyle: TextStyle(
                      color: Consts.primaryColor,
                      fontWeight: FontWeight.bold
                    ),
                    iconColor: Colors.red,
                  );
                },
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                      },
                      child: 
                       Visibility(
                          visible: _isGroupCreator || _isGroupLeader,
                          child: Button(
                            width: 250.0,
                            title: 'Invite Member',
                            action: () {
                              Routes.navigate(context, "/site/group/invite_member/${widget.groupId}", {});
                            }
                          )
                        )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}