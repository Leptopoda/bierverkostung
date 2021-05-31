<a href="http://weblate.rimikis.de/engage/bierverkostung/">
<img src="http://weblate.rimikis.de/widgets/bierverkostung/-/svg-badge.svg" alt="Translation Progress" />
</a>


# Bierverkostung
This project aims to improve an abandoned [project](https://bitbucket.org/jufickel/bierverkostung).

It will consist of three parts
 - Trinksprüche/Spiele
 - Bierverkostung
 - Konsum Tracking

## Platforms
Currently Supported platforms:
- Android
- iOS/iPadOS
- Web

Regarding Desktop support like Linux or Windows firebase currently does not support those platforms. 
We'll need to wait for this to tackle propper desktop support. MacOS is theoratiacally supported but we'll finalize the implementation with the other desktop support.

## Hosted
This project is already hosted on https://saufen.rimikis.de. Check it out as more features will arrive.

## Translation
The app is translated on https://weblate.rimikis.de/projects/bierverkostung.

## Versioning
For now we use a fairly uncommon versioning scheme. Until 1.0.0 we increment the minor version when work on a big new feature starts and increment accordingly until finished.
We'll switch to a more common versioning system once ready for production.

## Getting Started

### Flutter

This project is build using flutter.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Firebase

We encurage you to setup a local Firebase development enviornment.

Enter the Firebase directory
```
cd firebase.local
```

Download the necessary tools (npm needed)
```
npm install -g firebase
```

Start the local emulators
```
firebase emulators:start
```

Build the app with the local config pre applied
```
flutter run --dart-define=local_firebase=true
```
Need a custom domain/ip? 
```
flutter run --dart-define=local_firebase_ip=10.0.0.2
```

### Local Testing
Before creating a PR be shure to test your changes!

Use emulators or real devices. Testing the web version can be done like this:
```
flutter build web --release
```
and in the output dir run
```
python -m http.server 8000
```

## Credits 
- This app is inspired by the app [Bierverkostung by Jürgen Fickel](https://bitbucket.org/jufickel/bierverkostung)
- Application Icon: [drunken_duck (via openClipart.org)](https://openclipart.org/detail/2214/beer)
- Error page Icon: [Big_Ryan](https://www.gettyimages.de/detail/illustration/unicorn-lizenfreie-illustration/165601541)
- Playing cards: [Byron Knoll](https://commons.m.wikimedia.org/wiki/Category:Playing_cards_set_by_Byron_Knoll)
- Authors: see [AUTHORS](AUTHORS)
- Libraries: see [LIBRARIES.md](LIBRARIES.md)


# Lizenz/Licence

Copyright 2021 Leptopoda

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
