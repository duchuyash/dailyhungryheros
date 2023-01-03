// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Question {
  final String id;
  final String question;
  final List<String> answers;
  final int correct;
  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.correct,
  });

  Question copyWith({
    String? id,
    String? question,
    List<String>? answers,
    int? correct,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correct: correct ?? this.correct,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'answers': answers,
      'correct': correct,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      question: map['question'],
      answers: List<String>.from(map['answers']),
      correct: map['correct'],
    );
  }

  factory Question.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;
    data['id'] = id;

    return Question.fromMap(data);
  }
  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(id: $id, question: $question, answers: $answers, correct: $correct)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.question == question &&
        listEquals(other.answers, answers) &&
        other.correct == correct;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        answers.hashCode ^
        correct.hashCode;
  }
}
