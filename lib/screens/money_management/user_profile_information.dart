// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/money_management/money_management.dart';

/// User Profile Information
///
/// Widget displaying the user information like Avatar or name.
class _UserProfileInformation extends StatelessWidget {
  final String uid;
  const _UserProfileInformation({
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

            return Row(
              children: [
                Text(_userData.nameToDisplay),
                if (_userData.photoURL != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_userData.photoURL!),
                  ),
              ],
            );
        }
      },
    );
  }
}
