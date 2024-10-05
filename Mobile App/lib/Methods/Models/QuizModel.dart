import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizModel{
  String id, title, description, type, focusedtype, focusedid;
  Map<String,List<dynamic>> questions;
  Map<String,int> answers;
  List<int> points;
  List<String> took;
  int time, passed;
  ImageProvider imgurl;

  QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imgurl,
    required this.type,
    required this.questions,
    required this.answers,
    required this.points,
    required this.time,
    required this.passed,
    required this.took,
    required this.focusedtype,
    required this.focusedid,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      imgurl: NetworkImage(map["imgurl"]),
      type: map["type"],
      points: List<int>.from(map["points"]),
      took: List<String>.from(map["took"]),
      answers: Map<String,int>.from(map["answers"]),
      questions: Map<String,List<dynamic>>.from(map["questions"]),
      time: map['time'],
      passed: map['passed'],
      focusedid: map['focusedid'],
      focusedtype: map['focusedtype'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description':description,
      'imgurl': imgurl,
      'type': type,
      'points': List<int>.from(points),
      'took': List<String>.from(took),
      'answers': Map<String,int>.from(answers),
      'questions': Map<String,List<dynamic>>.from(questions),
      'time': time,
      'passed': passed,
      'focusedid': focusedid,
      'focusedtype': focusedtype,
    };
  }

}