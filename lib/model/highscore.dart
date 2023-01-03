// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Highscore {
  final List<dynamic> first;
  final List<dynamic> second;
  final List<dynamic> third;
  Highscore({
    required this.first,
    required this.second,
    required this.third,
  });

  Highscore copyWith({
    List<dynamic>? first,
    List<dynamic>? second,
    List<dynamic>? third,
  }) {
    return Highscore(
      first: first ?? this.first,
      second: second ?? this.second,
      third: third ?? this.third,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first': first,
      'second': second,
      'third': third,
    };
  }

  factory Highscore.fromMap(Map<String, dynamic> map) {
    return Highscore(
      first: List<dynamic>.from((map['first'] as List<dynamic>)),
      second: List<dynamic>.from((map['second'] as List<dynamic>)),
      third: List<dynamic>.from((map['third'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Highscore.fromJson(String source) =>
      Highscore.fromMap(json.decode(source) as Map<String, dynamic>);
      
  factory Highscore.fromQueryDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;
    data['id'] = id;

    return Highscore.fromMap(data);
  }

  @override
  String toString() =>
      'Highscore(first: $first, second: $second, third: $third)';

  @override
  bool operator ==(covariant Highscore other) {
    if (identical(this, other)) return true;

    return listEquals(other.first, first) &&
        listEquals(other.second, second) &&
        listEquals(other.third, third);
  }

  @override
  int get hashCode => first.hashCode ^ second.hashCode ^ third.hashCode;
}
