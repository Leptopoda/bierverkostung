// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/settings/group_settings/group_management.dart';

/// Screen to manage users
///
/// this screen displays a list of users and lets them kick others
@Deprecated("We've included this into the [GroupScreen]")
// ignore: unused_element
class _ManageUsers extends StatelessWidget {
  final Group groupData;
  const _ManageUsers({
    required this.groupData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!
            .settings_groupManagement_manageMembers),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _GroupMemberList(members: groupData.members)),
          SizedBox(
            height: 120,
            child: Column(
              children: <Widget>[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 40),
                  ),
                  onPressed: () async {
                    final bool? _confirmation = await showDialog<bool?>(
                      context: context,
                      builder: (_) => const _LeaveGroupDialog(),
                    );
                    if (_confirmation ?? false) {
                      await CloudFunctionsService.removeGroup(
                        AuthService.getUser!.uid,
                      );
                    }
                  },
                  icon: const Icon(Icons.logout_outlined),
                  label: Text(AppLocalizations.of(context)!
                      .settings_groupManagement_leaveGroup),
                ),
                const SizedBox(height: 5),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 40),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const _AddUser(),
                    ),
                  ),
                  icon: const Icon(Icons.group_add_outlined),
                  label: Text(AppLocalizations.of(context)!
                      .settings_groupManagement_addUser),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Leave Group Dialog
///
/// ensures the deleate action is wanted
class _LeaveGroupDialog extends StatelessWidget {
  const _LeaveGroupDialog({Key? key}) : super(key: key);

  @override
  AlertDialog build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
          AppLocalizations.of(context)!.settings_groupManagement_leaveGroup),
      content: Text(
        AppLocalizations.of(context)!
            .settings_groupManagement_leaveGroup_description,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(AppLocalizations.of(context)!.alert_escape),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(AppLocalizations.of(context)!.alert_continue),
        ),
      ],
    );
  }
}

/// Group member list Widget
///
/// This Widget displays a list of group members with
/// the ability do delete one.
class _GroupMemberList extends StatelessWidget {
  final List<String> members;

  const _GroupMemberList({
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: members.length,
      itemBuilder: (BuildContext context, int index) {
        return _GroupMemberItem(member: members[index]);
      },
    );
  }
}

/// Group Member Item Widget
///
/// Card that displays the given [member].
/// Members are dismissible via swipes.
class _GroupMemberItem extends StatelessWidget {
  const _GroupMemberItem({
    Key? key,
    required this.member,
  }) : super(key: key);

  final String member;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: const Card(
        color: ColorName.red,
        child: ListTile(
          trailing: Icon(Icons.delete_outline),
        ),
      ),
      confirmDismiss: (direction) => showDialog<bool?>(
        context: context,
        builder: (_) => _GroupMemberDeleteDialog(member: member),
      ),
      direction: DismissDirection.endToStart,
      key: ValueKey<String>(member),
      onDismissed: (direction) => CloudFunctionsService.removeGroup(member),
      child: Card(
        child: ListTile(
          title: Text(member),
        ),
      ),
    );
  }
}

/// Group Member Delete Dialog
///
/// ensures the deleate action is wanted
class _GroupMemberDeleteDialog extends StatelessWidget {
  final String member;

  const _GroupMemberDeleteDialog({
    required this.member,
    Key? key,
  }) : super(key: key);

  @override
  AlertDialog build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
          AppLocalizations.of(context)!.settings_groupManagement_deleteUser),
      content: Text(
        AppLocalizations.of(context)!
            .settings_groupManagement_deleteUser_description(member),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(AppLocalizations.of(context)!.alert_escape),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(AppLocalizations.of(context)!.alert_continue),
        ),
      ],
    );
  }
}
