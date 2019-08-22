import 'package:flutter/material.dart';
import 'package:chart_fluttering/pie_chart_view.dart';
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
      DummyChartModel(name: 'OVO', total: random.nextInt(100), startColor: Colors.purple, endColor: Colors.purpleAccent),
      DummyChartModel(name: 'Go Pay', total: random.nextInt(100), startColor: Colors.green, endColor: Colors.greenAccent),
      DummyChartModel(name: 'Texo', total: random.nextInt(100), startColor: Colors.blueAccent, endColor: Colors.lightBlueAccent),
      DummyChartModel(name: 'DKI Debit', total: random.nextInt(100), startColor: Colors.deepOrange, endColor: Colors.orange),
      DummyChartModel(name: 'BNI Kredit', total: random.nextInt(100), startColor: Colors.yellow, endColor: Colors.yellowAccent)
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
