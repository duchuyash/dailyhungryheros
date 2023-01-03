// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Level {
  final int id;
  final int topic;

  Level({
    required this.id,
    required this.topic,
  });

  Level copyWith({
    int? id,
    int? topic,
  }) {
    return Level(
      id: id ?? this.id,
      topic: topic ?? this.topic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'topic': topic,
    };
  }

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      id: map['id'] as int,
      topic: map['topic'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Level.fromJson(String source) => Level.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Level(id: $id, topic: $topic)';

  @override
  bool operator ==(covariant Level other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.topic == topic;
  }

  @override
  int get hashCode => id.hashCode ^ topic.hashCode;
}
