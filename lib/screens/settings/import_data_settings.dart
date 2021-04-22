// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:bierverkostung/services/import_data.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImportDataSettings extends StatelessWidget {
  const ImportDataSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Data'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const Center(
            child: Text(
              'This feature allows you to import data from the old Bierverkostung app. '
              "Please note that we currently do'nt support scent. "
              "We'll also interpret null values on sliders as a 0 as that is how we used the app",
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _importData(),
            icon: const Icon(Icons.import_export_outlined),
            label: const Text('import data'),
          ),
        ],
      ),
    );
  }

  Future _importData() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );

    if (result != null) {
      final File _zipFile = File(result.files.single.path!);
      ImportDataService().importData(_zipFile);
    }
  }
}
