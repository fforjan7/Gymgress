import 'package:flutter/material.dart';

class ChartInfo {
  DateTime date;
  double weight;

  ChartInfo({
    @required this.date,
    @required this.weight,
  });

  ChartInfo.fromMap(Map<String, dynamic> map) {
    date = DateTime.parse(map['date']);
    weight = map['weight'];
  }
}
