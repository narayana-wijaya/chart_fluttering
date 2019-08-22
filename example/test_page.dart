import 'package:flutter/material.dart';
import 'package:chart_fluttering/donut_chart_view.dart';
import 'dart:math' as math;

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var random = new math.Random();

  var data;

  @override
  void initState() {
    data = [
      DonutChartModel(name: 'OVO', total: random.nextInt(100), startColor: Colors.purple, endColor: Colors.purpleAccent),
      DonutChartModel(name: 'Go Pay', total: random.nextInt(100), startColor: Colors.green, endColor: Colors.greenAccent),
      DonutChartModel(name: 'Texo', total: random.nextInt(100), startColor: Colors.blueAccent, endColor: Colors.lightBlueAccent),
      DonutChartModel(name: 'DKI Debit', total: random.nextInt(100), startColor: Colors.deepOrange, endColor: Colors.orange),
      DonutChartModel(name: 'BNI Kredit', total: random.nextInt(100), startColor: Colors.yellow, endColor: Colors.yellowAccent)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabContent(data),
    );
  }
}
