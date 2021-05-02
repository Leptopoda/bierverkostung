// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import 'package:bierverkostung/services/import_data.dart';
import 'package:bierverkostung/models/users.dart';

class ImportDataSettings extends StatelessWidget {
  const ImportDataSettings({Key? key}) : super(key: key);

  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        const Center(
          child: Text(
            'This feature allows you to import data from the old Bierverkostung app. '
            "Please note that we currently do'nt support scent. "
            "We'll also interpret null values on sliders as a 0 as that is how we used the app",
            style: _text,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => _importData(context),
          icon: const Icon(Icons.import_export_outlined),
          label: const Text('import data'),
        ),
      ],
    );
  }

  Future _importData(BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );

    if (result != null) {
      final File _zipFile = File(result.files.single.path!);
      final UserData _user = Provider.of<UserData?>(context, listen: false)!;

      ImportDataService(user: _user).importData(_zipFile);
    }
  }
}
