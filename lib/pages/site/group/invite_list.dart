import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/services/api.dart';

class SiteGroupInviteListPage extends StatefulWidget {
   _SiteGroupEditPageState createState() => _SiteGroupEditPageState();
}

class _SiteGroupEditPageState extends State<SiteGroupInviteListPage> {
  List<Invite> _invites = [];
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
    final res = await Api().siteGroupInvitationList();
    if (res['status']) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        setState(() {
            _invites = [];
            List<dynamic> m_inviteList = res['data'];
            for (var mItem in m_inviteList) {
              Invite invite = Invite(inviteId: int.parse(mItem['invite_id']), inviterName: mItem['inviter_name'], inviterEmail: mItem['inviter_email'], groupName: mItem['group_name']);
              _invites.add(invite);
            }
        });
      };

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invitation List'),
        backgroundColor: Consts.primaryColor,
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Change the color of the back button here
        ),
      ),
      body: ListView.builder(
        itemCount: _invites.length,
        itemBuilder: (context, index) {
          return InviteItem(invite: _invites[index]);
        },
      ),
    );
  }
}

class InviteItem extends StatelessWidget {
  final Invite invite;

  InviteItem({required this.invite});
  void _acceptInvite(BuildContext context, int inviteId) async
  {
    final res = await Api().siteGroupAcceptInvite(inviteId);
    if (res['status']) {
      Navigator.of(context).pop();
    }
  }

  void _rejectInvite(BuildContext context, int inviteId) async
  {
    final res = await Api().siteGroupRejectInvite(inviteId);
    if (res['status']) {
      Navigator.of(context).pop();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invite.inviterName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(invite.inviterEmail),
                SizedBox(height: 8),
                Text('Invited you join: ${invite.groupName}'),
              ],
            ),
            SizedBox(width: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _acceptInvite(context, invite.inviteId);
                  },
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
                  child: Text('Accept'),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    _rejectInvite(context, invite.inviteId);
                  },
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                  child: Text('Reject'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Invite {
  final int inviteId;
  final String inviterName;
  final String inviterEmail;
  final String groupName;

  Invite({required this.inviteId, required this.inviterName, required this.inviterEmail, required this.groupName});
}
