// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'new_beer.dart';

/// Widget to add new Images to a beer
class _BeerImage extends StatefulWidget {
  final ValueChanged<List<String>> onChanged;
  const _BeerImage({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _BeerImageState createState() => _BeerImageState();
}

class _BeerImageState extends State<_BeerImage>
    with AutomaticKeepAliveClientMixin {
  final List<String> _imagePaths = [];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      // padding: const EdgeInsets.all(10),
      itemExtent: 100,
      itemCount: _imagePaths.length + 1,
      itemBuilder: (BuildContext context, int i) {
        if (i == 0) {
          return _beerImageSelectorCard();
        }

        return _beerImageCard(_imagePaths[i - 1]);
      },
    );
  }

  /// Creates a new Card displaying the Image at [path]
  Widget _beerImageCard(String path) {
    return Tooltip(
      message: AppLocalizations.of(context)!.beer_changeImage,
      child: InkWell(
        onTap: () => _changeImage(path),
        child: Card(
          color: Colors.amber,
          child: kIsWeb ? Image.network(path) : Image.file(File(path)),
        ),
      ),
    );
  }

  /// Creates the standard add image Card
  Widget _beerImageSelectorCard() {
    return Card(
      color: Colors.amber,
      child: IconButton(
        tooltip: AppLocalizations.of(context)!.beer_newImage,
        icon: const Icon(
          Icons.add,
          size: 50,
        ),
        onPressed: () => _getImage(),
      ),
    );
  }

  /// Fetches the image and adds it to the stack
  Future<void> _getImage() async {
    final String? _path = await showModalBottomSheet<String?>(
      shape: PickImageModal.shape,
      context: context,
      builder: (BuildContext context) => const PickImageModal(),
    );

    if (_path != null) {
      _imagePaths.insert(0, _path);
      setState(() {});
      widget.onChanged(_imagePaths);
    }
  }

  /// changes or removes the current Image at [path]
  Future<void> _changeImage(String path) async {
    final String? _path = await showModalBottomSheet<String?>(
      shape: PickImageModal.shape,
      context: context,
      builder: (BuildContext context) => PickImageModal(
        removeCallback: () {
          _imagePaths.remove(path);
          setState(() {});
        },
      ),
    );

    if (_path != null) {
      _imagePaths.insert(0, _path);
      _imagePaths.remove(path);
      setState(() {});
      widget.onChanged(_imagePaths);
    }
  }
}

/// Card used to display images
@Deprecated('now integrated into [_BeerImage]')
// ignore: unused_element
class _BeerImageCard extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _BeerImageCard({required this.onChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child: IconButton(
        tooltip: AppLocalizations.of(context)!.beer_newImage,
        icon: const Icon(
          Icons.add,
          size: 50,
        ),
        onPressed: () => _getImage(context),
      ),
    );
  }

  /// Fetches the image and adds it to the stack
  Future<void> _getImage(BuildContext context) async {
    final String? _path = await showModalBottomSheet<String?>(
      shape: PickImageModal.shape,
      context: context,
      builder: (BuildContext context) => const PickImageModal(),
    );

    if (_path != null) {
      onChanged(_path);
    }
  }
}
