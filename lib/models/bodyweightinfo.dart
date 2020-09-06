import 'package:flutter/foundation.dart';

class BodyweightInfo {
  int id;
  DateTime date;
  int weight;

  BodyweightInfo({
    @required this.id,
    @required this.date,
    @required this.weight,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'date': date.toIso8601String(),
      'weight': weight,
    };
    return map;
  }

  BodyweightInfo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    date = DateTime.parse(map['date']);
    weight = map['weight'];
  }
}
