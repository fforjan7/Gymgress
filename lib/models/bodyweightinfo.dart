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
      'id' : id,
      'date': date,
      'weight': weight,
    };
    return map;
  }

  BodyweightInfo.fromMap(Map<String,dynamic> map){
    id = map['id'];
    date = map['date'];
    weight = map['weight'];
  }
}
