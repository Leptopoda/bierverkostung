# Bierverkostung
This project aims to improve an abandoned [project](https://bitbucket.org/jufickel/bierverkostung).

It will consist of three parts
 - Trinksprüche/Spiele
 - Bierverkostung
 - Konsum Tracking

## Platforms
We currently only support Android and Web. Although every package selected does also support iOS/iPadOS/MacOS i don't have a mac to text and build. Reach out to me if you want to help with this.
Regarding other Desktop support like Linux and Windows firebase currently does not support those platforms. 
We'll need to wait for this to tackle propper desktop support.

## Hosted
This project is already hosted on https://saufen.rimikis.de. Check it out as more features will arrive.

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

