import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../models/chartInfo.dart';

class Chart extends StatefulWidget {
  final List<ChartInfo> data;
  Chart({this.data});

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartInfo, DateTime>> series = [
      charts.Series(
        id: 'chart',
        data: this.widget.data,
        domainFn: (series, _) => series.date,
        measureFn: (series, _) => series.weight,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
    ];
    return charts.TimeSeriesChart(series, animate: true);
  }
}
