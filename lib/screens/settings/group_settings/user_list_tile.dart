// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/settings/group_settings/group_management.dart';

/// User info List Tile
///
/// List Tile displaying the user information where possible.
class _UserListTile extends StatelessWidget {
  final String uid;
  const _UserListTile({
    required this.uid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService.userData(uid),
      builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: '${snapshot.error}',
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (!snapshot.hasData) {
              return Center(
                child: Text(AppLocalizations.of(context).noItemsFound),
              );
            }
            final UserData _userData = snapshot.data!;
            return ListTile(
              title: Text(_userData.nameToDisplay),
              trailing: (_userData.photoURL != null)
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(_userData.photoURL!),
                    )
                  : null,
            );
        }
      },
    );
  }
}
