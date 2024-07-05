// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/main_header.dart';
import 'package:oscar_ballot/widgets/sidebars/user_sidebar.dart';

class SiteMyGroupsPage extends StatefulWidget {
  const SiteMyGroupsPage();
  @override
  _SiteMyGroupsPageState createState() => _SiteMyGroupsPageState();
}

class _SiteMyGroupsPageState extends State<SiteMyGroupsPage> {
  
  List<Group> _groups = [];
  int _page = 1;
  int _limit = 3000;
  int _status = 1;
  int _inviteListCount = 0;
  String _searchQuery = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Call a function to reload data when the screen is first built
      _fetchData();
    });
    
  }

  Future<void> _fetchData() async {
    final res = await Api().siteGroupIndex(_page, _limit, _status, _searchQuery);
    if (res['status']) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        setState(() {
          List<dynamic> mResults =  res['data']['result']['result']?? [];
          _inviteListCount = int.parse(res['data']['invite_list_count'].toString());
          _groups = [];
          for (var result in mResults) {
            Group group = Group(int.parse(result['id']), result['name'],  result['group_number'], result['leader_name'], result['leader_email'], int.parse(result['members'].toString()));
            _groups.add(group);
          }
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load data here
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserSidebar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainHeaderWidget(),
            SafeArea(
              child: 
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Visibility(
                        visible: _inviteListCount > 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'There are ${_inviteListCount} invitations',
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                  Routes.navigate(context, Routes.siteGroupInviteList, {});
                              },
                              style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
                              child: Text('View'),
                            ),
                          ]
                        )
                      ),
                
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search by name, leader name',
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ]
                  )
                )
            ),
            

            Expanded(
              child: ListView.builder(
                itemCount: _groups.length,
                itemBuilder: (context, index) {
                  final group = _groups[index];
                  if (_searchQuery.isNotEmpty &&
                      !group.name.toLowerCase().contains(_searchQuery) &&
                      !group.leaderName.toLowerCase().contains(_searchQuery)) {
                    return Container();
                  }
                  return GroupCard(group);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.group_add),
                        title: Text('Create Group'),
                        onTap: () {
                          // Handle action
                          Routes.navigate(context, Routes.siteGroupAdd, {});
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.group),
                        title: Text('Join Group'),
                        onTap: () {
                          // Handle action
                          Routes.navigate(context, Routes.siteGroupJoin, {});
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.cancel),
                        title: Text('Cancel'),
                        onTap: () {
                          // Handle action
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Group {
  final int groupId;
  final String name;
  final String groupNumber;
  final String leaderName;
  final String leaderEmail;
  final int memberCount;

  Group(this.groupId, this.name, this.groupNumber, this.leaderName, this.leaderEmail, this.memberCount);
}

class GroupCard extends StatelessWidget {
  final Group group;

  GroupCard(this.group);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: ListTile(
        title: Text(group.name),
        subtitle: Text('Leader: ${group.leaderName}(${group.leaderEmail}) \nMembers: ${group.memberCount}'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Consts.primaryColor,
        ),
        subtitleTextStyle: TextStyle(
          color: Color.fromARGB(255, 130, 131, 136),
          fontSize: 14
        ),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {
            Routes.navigate(context, "/site/group/detail/${group.groupId}", {});
          },
        ),
      ),
    );
  }
}