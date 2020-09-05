import 'package:flutter/material.dart';

class Exercise {
  int id;
  String path;
  int weight;
  DateTime date;

  Exercise({
    @required this.path,
    @required this.id,
    @required this.weight,
    @required this.date,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': path,
      'weight': weight,
      'date': date.toIso8601String(),
    };
    return map;
  }

  Exercise.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    path = map['name'];
    weight = map['weight'];
    date = DateTime.parse(map['date']);
  }
}
