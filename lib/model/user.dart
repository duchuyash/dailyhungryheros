// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String nickname;
  final int heart;
  final int exp;
  UserModel({
    required this.email,
    required this.nickname,
    required this.heart,
    required this.exp,
  });

  static int mytime = 0;

  UserModel copyWith({
    String? email,
    String? nickname,
    int? heart,
    int? exp,
  }) {
    return UserModel(
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      heart: heart ?? this.heart,
      exp: exp ?? this.exp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'nickname': nickname,
      'heart': heart,
      'exp': exp,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      nickname: map['nickname'] as String,
      heart: map['heart'] as int,
      exp: map['exp'] as int,
    );
  }
  factory UserModel.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;
    data['id'] = id;

    return UserModel.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, nickname: $nickname, heart: $heart, exp: $exp)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.nickname == nickname &&
        other.heart == heart &&
        other.exp == exp;
  }

  @override
  int get hashCode {
    return email.hashCode ^ nickname.hashCode ^ heart.hashCode ^ exp.hashCode;
  }
}
