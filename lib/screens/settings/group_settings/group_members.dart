// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/settings/group_settings/group_management.dart';

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
        color: Colors.red,
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
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppLocalizations.of(context)!.alert_escape),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.of(context)!.alert_continue),
        ),
      ],
    );
  }
}
