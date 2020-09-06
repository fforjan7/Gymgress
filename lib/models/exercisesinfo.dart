import 'package:flutter/material.dart';

class ExerciseInfo {
  int id;
  int weight;
  DateTime date;

  ExerciseInfo({
    @required this.id,
    @required this.weight,
    @required this.date,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'weight': weight,
      'date': date.toIso8601String(),
    };
    return map;
  }

  ExerciseInfo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    weight = map['weight'];
    date = DateTime.parse(map['date']);
  }
}
