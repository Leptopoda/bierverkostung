// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show jsonEncode;
import 'dart:developer' as developer show log;

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show User;

import 'package:bierverkostung/services/firebase/auth.dart';

import 'package:bierverkostung/models/stats.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/money_calc.dart';

class DatabaseService {
  const DatabaseService();
  // Firestore instance
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final User _user = AuthService.getUser()!;
  static final String? _groupID = AuthService.claims?['group_id'] as String?;

  static final _statRef = _firestore
      .collection('users')
      .doc(_user.uid)
      .collection('stats')
      .withConverter(
        fromFirestore: (snapshot, _) => Stat.fromJson(snapshot.data()!),
        toFirestore: (Stat stat, _) => stat.toJson(),
      );

  // Stats
  /// save Stat
  static Future<void> saveStat(Stat stat) async {
    try {
      await _statRef.add(stat);
    } catch (error) {
      developer.log(
        'error saving stat',
        name: 'leptopoda.bierverkostung.DatabaseService',
        error: jsonEncode(error.toString()),
      );
    }
  }

  /// get stats stream
  static Stream<List<Stat>> get stats {
    return _statRef
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()).toList());
  }

  /// get cumputed stats stream
  static Stream<List<Map<String, dynamic>>> get statsComputed {
    return _firestore
        .collection('users')
        .doc(_user.uid)
        .collection('stats-computed')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()).toList());
  }

  static final _tastingRef = _firestore
      .collection('groups')
      .doc(_groupID ?? _user.uid)
      .collection('tastings')
      .withConverter(
        fromFirestore: (snapshot, _) => Tasting.fromJson(snapshot.data()!),
        toFirestore: (Tasting stat, _) => stat.toJson(),
      );

  // Tasting
  /// save Tasting
  static Future<void> saveTasting(Tasting tasting) async {
    try {
      await _tastingRef.add(tasting);
    } catch (error) {
      developer.log(
        'error saving Tasting',
        name: 'leptopoda.bierverkostung.DatabaseService',
        error: jsonEncode(error.toString()),
      );
    }
  }

  /// get tasting stream
  static Stream<List<Tasting>> get tastings {
    return _tastingRef
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()).toList());
  }

  static final _beerRef = _firestore
      .collection('groups')
      .doc(_groupID ?? _user.uid)
      .collection('beers')
      .withConverter(
        fromFirestore: (snapshot, _) => Beer.fromJson(snapshot.data()!),
        toFirestore: (Beer stat, _) => stat.toJson(),
      );
  // Beer
  /// save Beer
  static Future<void> saveBeer(Beer beer) async {
    try {
      await _beerRef.add(beer);
    } catch (error) {
      developer.log(
        'error saving beer',
        name: 'leptopoda.bierverkostung.DatabaseService',
        error: jsonEncode(error.toString()),
      );
    }
  }

  /// get beers stream
  static Stream<List<Beer>> get beers {
    return _beerRef
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()).toList());
  }

  static final _moneyCalcRef = _firestore
      .collection('groups')
      .doc(_groupID ?? _user.uid)
      .collection('money')
      .withConverter(
        fromFirestore: (snapshot, _) => MoneyCalc.fromJson(snapshot.data()!),
        toFirestore: (MoneyCalc stat, _) => stat.toJson(),
      );

  // Money Calculations
  /// save money stat
  static Future<void> saveMoneyCalc(MoneyCalc money) async {
    try {
      await _moneyCalcRef.add(money);
    } catch (error) {
      developer.log(
        'error saving moneyCalc',
        name: 'leptopoda.bierverkostung.DatabaseService',
        error: jsonEncode(error.toString()),
      );
    }
  }

  /// get money stat stream
  static Stream<List<MoneyCalc>> get moneyCalc {
    return _moneyCalcRef
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()).toList());
  }

  /// get computed money stat stream
  static Stream<List<MoneyCalc>> get moneyCalcComp {
    return _firestore
        .collection('groups')
        .doc(_groupID ?? _user.uid)
        .collection('money-computed')
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => MoneyCalc.fromJson(doc.data())).toList());
  }

  /// save NotificationToken
  static Future<void> saveNotificationToken(Map<String, dynamic> token) async {
    try {
      await _firestore
          .collection('users')
          .doc(_user.uid)
          .collection('notification-token')
          .add(token);
    } catch (error) {
      developer.log(
        'error saving notification Tokenob',
        name: 'leptopoda.bierverkostung.DatabaseService',
        error: jsonEncode(error.toString()),
      );
    }
  }

  /// clears the locally cached data
  static Future<void> clearLocalCache() async {
    await _firestore.clearPersistence();
  }
}
