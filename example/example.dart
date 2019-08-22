import 'package:flutter/material.dart';
import '../lib/donut_chart_view.dart';
import 'dart:math' as math;

class DonutExample extends StatefulWidget {
  @override
  _DonutExampleState createState() => _DonutExampleState();
}

class _DonutExampleState extends State<DonutExample> {
  var random = new math.Random();
  var data;

  @override
  void initState() {
    data = [
      DonutChartModel(
          name: 'OVO',
          total: random.nextInt(100),
          startColor: Colors.purple,
          endColor: Colors.purpleAccent),
      DonutChartModel(
          name: 'Go Pay',
          total: random.nextInt(100),
          startColor: Colors.green,
          endColor: Colors.greenAccent),
      DonutChartModel(
          name: 'Texo',
          total: random.nextInt(100),
          startColor: Colors.blueAccent,
          endColor: Colors.lightBlueAccent),
      DonutChartModel(
          name: 'DKI Debit',
          total: random.nextInt(100),
          startColor: Colors.deepOrange,
          endColor: Colors.orange),
      DonutChartModel(
          name: 'BNI Kredit',
          total: random.nextInt(100),
          startColor: Colors.yellow,
          endColor: Colors.yellowAccent)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DonutChartView(data),
    );
  }
}
