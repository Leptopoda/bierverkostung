// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show User;

import 'package:bierverkostung/services/firebase/auth.dart';

import 'package:bierverkostung/models/stats.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/money_calc.dart';

class DatabaseService {
  String? groupID;
  DatabaseService({this.groupID});
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User user2 = AuthService().getUser()!;

  // Stats
  /// save Stat
  Future<void> saveStat(Map<String, dynamic> stat) async {
    await _firestore
        .collection('users')
        .doc(user2.uid)
        .collection('stats')
        .add(stat);
  }

  /// get stats stream
  Stream<List<Stat>> get stats {
    return _firestore
        .collection('users')
        .doc(user2.uid)
        .collection('stats')
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => Stat.fromMap(doc.data())).toList());
  }

  /// get cumputed stats stream
  Stream<List<Map<String, dynamic>>> get statsComputed {
    return _firestore
        .collection('users')
        .doc(user2.uid)
        .collection('stats-computed')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()).toList());
  }

  /// save NotificationToken
  Future<void> saveNotificationToken(Map<String, dynamic> token) async {
    await _firestore
        .collection('users')
        .doc(user2.uid)
        .collection('notification-token')
        .add(token);
  }

  // Tasting
  /// save Tasting
  Future<void> saveTasting(Map<String, dynamic> tasting) async {
    await _firestore
        .collection('groups')
        .doc((groupID != null) ? groupID : user2.uid)
        .collection('tastings')
        .add(tasting);
  }

  /// get tasting stream
  Stream<List<Tasting>> get tastings {
    return _firestore
        .collection('groups')
        .doc((groupID != null) ? groupID : user2.uid)
        .collection('tastings')
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => Tasting.fromMap(doc.data())).toList());
  }

  // Beer
  /// save Beer
  Future<void> saveBeer(Map<String, dynamic> beer) async {
    await _firestore
        .collection('groups')
        .doc((groupID != null) ? groupID : user2.uid)
        .collection('beers')
        .add(beer);
  }

  /// get beers stream
  Stream<List<Beer>> get beers {
    return _firestore
        .collection('groups')
        .doc((groupID != null) ? groupID : user2.uid)
        .collection('beers')
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => Beer.fromMap(doc.data())).toList());
  }

  // Money Calculations
  /// save money stat
  Future<void> saveMoneyCalc(Map<String, dynamic> money) async {
    await _firestore
        .collection('groups')
        .doc((groupID != null) ? groupID : user2.uid)
        .collection('money')
        .add(money);
  }

  /// get money stat stream
  Stream<List<MoneyCalc>> get moneyCalc {
    return _firestore
        .collection('groups')
        .doc((groupID != null) ? groupID : user2.uid)
        .collection('money')
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => MoneyCalc.fromJson(doc.data())).toList());
  }

  /// get computed money stat stream
  Stream<List<MoneyCalc>> get moneyCalcComp {
    return _firestore
        .collection('groups')
        .doc((groupID != null) ? groupID : user2.uid)
        .collection('money-computed')
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => MoneyCalc.fromJson(doc.data())).toList());
  }
}
