import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../models/chartInfo.dart';

class BodyweightChart extends StatefulWidget {
  final List<ChartInfo> data;
  BodyweightChart({this.data});

  @override
  _BodyweightChartState createState() => _BodyweightChartState();
}

class _BodyweightChartState extends State<BodyweightChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartInfo, DateTime>> series = [
      charts.Series(
        id: 'Bodyweight',
        data: this.widget.data,
        domainFn: (series, _) => series.date,
        measureFn: (series, _) => series.weight,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
    ];
    return charts.TimeSeriesChart(series, animate: true);
  }
}
