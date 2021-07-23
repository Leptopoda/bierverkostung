// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

/// Group data model
///
/// holds the data describing a group
@JsonSerializable()
@immutable
class Group {
  final List<String> members;
  final int count;
  final String? name;

  const Group({
    required this.count,
    required this.members,
    this.name,
  });

  /// decodes a Json into a [Group] obbject
  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  /// encodes a Json from a [Group] obbject
  Map<String, dynamic> toJson() => _$GroupToJson(this);

  /// returns a modifies group object
  Group copyWith({
    List<String>? members,
    int? count,
    String? name,
  }) {
    return Group(
      members: members ?? this.members,
      count: count ?? this.count,
      name: name ?? this.name,
    );
  }
}
