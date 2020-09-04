import '../models/bodyweightinfo.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BodyweightChart extends StatefulWidget {
  final List<BodyweightInfo> data;
  BodyweightChart({this.data});

  @override
  _BodyweightChartState createState() => _BodyweightChartState();
}

class _BodyweightChartState extends State<BodyweightChart> {
  
  List<charts.Series<BodyweightInfo, String>> series = [
    charts.Series(
      id: 'Bodyweight',
      data: data,
      domainFn: (series, _) => series.date.toIso8601String(),
      measureFn: (series, _) => series.weight,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}