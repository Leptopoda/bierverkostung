// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'user_settings.dart';

class _CropProfileWeb extends StatelessWidget {
  final String imagePath;

  const _CropProfileWeb({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  static final _cropController = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings_userManagement_cropImage,
        ),
      ),
      body: FutureBuilder<Uint8List>(
        future: PickedFile(imagePath).readAsBytes(),
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          if (snapshot.hasData) {
            return Crop(
              controller: _cropController,
              image: snapshot.data!,
              onCropped: (croppedData) {
                Navigator.pop(context, croppedData);
              },
              initialSize: 0.5,
              aspectRatio: 1,
              withCircleUi: true,
            );
          } else if (snapshot.hasError) {
            return SomethingWentWrong(
              error: snapshot.error.toString(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: _buildButtons(context),
    );
  }

  static Widget _buildButtons(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.restore_outlined),
            tooltip:
                AppLocalizations.of(context)!.settings_userManagement_reset,
            onPressed: () {
              _cropController.aspectRatio = 1;
            },
          ),
          TextButton(
            onPressed: () {
              _cropController.crop();
            },
            child: Text(AppLocalizations.of(context)!.alert_continue),
          ),
        ],
      );
}

/* class _CropProfile extends StatelessWidget {
  const _CropProfile({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  static CropController controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  // @override
  void dispose() {
    controller.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context)!.settings_userManagement_cropImage),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CropImage(
              controller: controller,
              image: Image.network(imagePath),
            ),
          ),
        ),
        bottomNavigationBar: _buildButtons(context),
      );

  Widget _buildButtons(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.restore_outlined),
            tooltip:
                AppLocalizations.of(context)!.settings_userManagement_reset,
            onPressed: () {
              controller.aspectRatio = 1.0;
              controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
            },
          ),
          TextButton(
            onPressed: () => _finished(context),
            child: Text(AppLocalizations.of(context)!.alert_continue),
          ),
        ],
      );

  Future<void> _finished(BuildContext context) async {
    final _image = await controller.croppedBitmap(quality: FilterQuality.low);
    final ByteData? _assetData = await _image.toByteData();
    final Uint8List? _data = _assetData?.buffer
        .asUint8List(_assetData.offsetInBytes, _assetData.lengthInBytes);
    _data ?? File(imagePath).writeAsBytes(_data!);
    Navigator.pop(context, _data);
  }
} */
