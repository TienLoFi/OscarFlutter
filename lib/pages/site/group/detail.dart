import 'package:flutter/material.dart';
import 'package:oscar_ballot/blocs/blocs.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/models/user.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';
class SiteGroupDetailPage extends StatefulWidget {
  final int groupId;
  SiteGroupDetailPage({this.groupId = 0});
  @override
  _SiteGroupDetailPageState createState() => _SiteGroupDetailPageState();
}

class _SiteGroupDetailPageState extends State<SiteGroupDetailPage> {
  UserBloc userBloc = BlocProvider.getBloc<UserBloc>();
  Map<String, dynamic> _group = {};
  List<dynamic> _members = [];
  String _searchQuery = '';
  bool _isGroupMember = false;
  bool _isGroupLeader = false;
  bool _isGroupCreator = false;
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

  Future<void> _fetchData() async {
    final res = await Api().siteGroupDetail(widget.groupId);
    if (res['status']) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        setState(() {
          _group['name'] = res['data']['name'];
          _group['group_number'] = res['data']['group_number'];
          _group['leader_name'] = res['data']['leader_name'];
          _group['leader_email'] = res['data']['leader_email'];
          _group['leader_id'] = res['data']['leader_id'];
          _group['user_id'] = res['data']['user_id'];
          _group['desc'] = res['data']['desc'];
          _members = res['data']['members'];
          User user = userBloc.user;
          if (user.id == int.parse(_group['user_id'])) {
            _isGroupCreator = true;
          }
          if (user.id == int.parse(_group['leader_id'])) {
            _isGroupLeader = true;
          }
          _isGroupMember = _members.any((item) => int.parse(item['user_id']) == user.id);
        });
      };

    }
  }

  void _deleteGroup() async
  {
    final res = await Api().siteGroupDelete(widget.groupId);
    if (res['status']) {
        Navigator.of(context).pop();
    }
  }

  void _leaveGroup() async
  {
    final res = await Api().siteGroupLeave(widget.groupId);
    if (res['status']) {
       Navigator.of(context).pop();
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Detail'),
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
            icon: Icon(Icons.edit),
            onPressed: () {
              Routes.navigate(context, "/site/group/edit/${widget.groupId}", {}).then((result) {
                if (result != null && result == true) {
                  setState(() {
                    _fetchData();
                  });
                }
              });
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
                      Text(
                        _group['name']??'',
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text('Group Number: ${_group['group_number']}'),
                      SizedBox(height: 8.0),
                      Text('Leader: ${_group['leader_name']}(${_group['leader_email']})'),
                      SizedBox(height: 8.0),
                      Text('Description: ${_group['desc']}'),
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
                      )
                      
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
                  if (_searchQuery.isNotEmpty &&
                      !member['email'].toLowerCase().contains(_searchQuery) &&
                      !member['name'].toLowerCase().contains(_searchQuery)) {
                    return Container();
                  }
                  // Replace with member information
                  return ListTile(
                    title: Text(member['name']),
                    subtitle: Text(member['email']),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Score: ${member['score']??0}'),
                        Text('Status: ${member['status'] == 1?'Active' : 'Pending'}'),
                      ],
                    ),
                    titleTextStyle: TextStyle(
                      color: Consts.primaryColor,
                      fontWeight: FontWeight.bold
                    ),
                  );
                },
            )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: _isGroupCreator || _isGroupLeader,
                    child: ElevatedButton(
                      onPressed: () {
                          _deleteGroup();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text('Delete'),
                    ),
                  ),
            
                  SizedBox(width: 16), // Add space between buttons
                  Visibility(
                    visible: _isGroupMember || _isGroupLeader,
                    child: ElevatedButton(
                    onPressed: () {
                        _leaveGroup();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('Leave'),
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