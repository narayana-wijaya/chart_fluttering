import 'package:flutter/material.dart';
import 'dart:math' as math;

//class PieChartView extends StatefulWidget {
//  List<DummyChartModel> model;
//
//
//  @override
//  _PieChartViewState createState() => _PieChartViewState();
//}
//
//class _PieChartViewState extends State<PieChartView>
//    with TickerProviderStateMixin {
//  TabController tabController;
//  var random = new math.Random();
//  List<DummyChartModel> data;
//
//  TextStyle tabLabelStyle = TextStyle(
//      fontSize: 12,
//      fontFamily: 'OpenSans',
//      fontWeight: FontWeight.w600,
//      height: 1);
//
//  @override
//  void initState() {
//    data = [
//      DummyChartModel(name: 'OVO', total: random.nextInt(100), startColor: Colors.purple, endColor: Colors.purpleAccent),
//      DummyChartModel(name: 'Go Pay', total: random.nextInt(100), startColor: Colors.green, endColor: Colors.greenAccent),
//      DummyChartModel(name: 'Texo', total: random.nextInt(100), startColor: Colors.blueAccent, endColor: Colors.lightBlueAccent),
//      DummyChartModel(name: 'DKI Debit', total: random.nextInt(100), startColor: Colors.deepOrange, endColor: Colors.orange),
//      DummyChartModel(name: 'BNI Kredit', total: random.nextInt(100), startColor: Colors.yellow, endColor: Colors.yellowAccent)
//    ];
//    super.initState();
//    tabController = TabController(length: 5, vsync: this);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      decoration: BoxDecoration(
//          border: Border.all(color: Colors.grey, width: 0.5),
//          borderRadius: BorderRadius.circular(8)),
//      margin: EdgeInsets.all(20),
//      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//      child: DefaultTabController(
//          length: 5,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              TabBar(
//                controller: tabController,
//                isScrollable: true,
//                tabs: [
//                  Tab(child: Text('DAILY', style: tabLabelStyle)),
//                  Tab(child: Text('WEEKLY', style: tabLabelStyle)),
//                  Tab(child: Text('MONTHLY', style: tabLabelStyle)),
//                  Tab(child: Text('3 MONTHLY', style: tabLabelStyle)),
//                  Tab(child: Text('6 MONTHLY', style: tabLabelStyle)),
//                ],
//                indicatorColor: BaseColor.primaryButton,
//                labelColor: BaseColor.primaryButton,
//                unselectedLabelColor: BaseDarkTextColor.hint,
//              ),
//              Container(
//                height: 411,
//                child: TabBarView(controller: tabController,
//                    physics: AlwaysScrollableScrollPhysics(),
//                    children: [
//                      TabContent(data),
//                      TabContent(data),
//                      TabContent(data),
//                      TabContent(data),
//                      TabContent(data),
//                    ]),
//              )
//            ],
//          )),
//    );
//  }
//}

class TabContent extends StatelessWidget {
  List<DummyChartModel> data;

  TabContent(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: 214,
                  width: 214,
                  child: CustomPaint(
                    painter: TexoPieChart(data),
                  ),
                ),
              ),
              Center(
                child: Text('120'),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 25)),
          Wrap(
            spacing: 0,
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.start,
            runSpacing: 0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: data.map((source) {
              return LegendView(source.name, color: source.startColor);
            }).toList(),
          )
        ],
      ),
    );
  }
}

class LegendView extends StatelessWidget {
  String label;
//  String color;
  bool isCircle;
  Color color;

  LegendView(this.label, {this.color, this.isCircle = true});

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 360;
    return Chip(
      labelPadding: EdgeInsets.only(left: 4, top: 0),
      backgroundColor: Colors.white,
      label: Text(
        label,
        maxLines: 2,
      ),
      avatar: Container(
//        padding: EdgeInsets.only(top: 4 * widthRatio),
        child: isCircle
            ? CircleAvatar(
                backgroundColor: color,
                radius: 6 * widthRatio,
              )
            : Container(
                color: color,
                height: 12 * widthRatio,
                width: 12 * widthRatio,
              ),
      ),
    );
  }
}

class TexoPieChart extends CustomPainter {

  List<DummyChartModel> data;

  TexoPieChart(this.data);

  double width = 30;
  double gap;
  double startAngl;

  @override
  void paint(Canvas canvas, Size size) {
//    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    canvas.translate(size.width/2, size.height/2);
    final center = new Offset(0, 0);
    final rect = new Rect.fromCenter(center: center, height: size.height, width: size.width);
    gap = data.length == 1 ? 0 : 0.01 * math.pi;

    int totalTrx = data.first.total;
    data.skip(1).forEach((model){
      totalTrx += model.total;
    });

    startAngl = 0;

    for (DummyChartModel model in data) {
      double arcAngle =  (model.total / totalTrx) * 2 * math.pi;

      final gradient = new SweepGradient(
        startAngle: startAngl,
        endAngle: startAngl + arcAngle,
        tileMode: TileMode.clamp,
        colors: [model.startColor, model.endColor],
      );

      final paint = new Paint()
        ..shader = gradient.createShader(rect)
        ..strokeCap = StrokeCap.butt  // StrokeCap.round is not recommended.
        ..style = PaintingStyle.stroke
        ..strokeWidth = width;

      final radius = math.min(size.width / 2, size.height / 2) - (width / 2);
      final startAngle = startAngl;
      final sweepAngle = arcAngle - gap;
      canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
          startAngle, sweepAngle, false, paint);

      double centerArc = startAngle + arcAngle/2;
      double y = (radius + width + 6) * math.sin(centerArc);
      double x = (radius + width + 6) * math.cos(centerArc);

      TextSpan text = TextSpan(text: '${(100*model.total/totalTrx).round()} %');
      TextPainter tp = TextPainter(text: text,textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      tp.layout();

//      final paintLine = new Paint()
////        ..style = PaintingStyle.stroke
////        ..color = Colors.black87
////        ..strokeWidth = 0.5;

      x = x + 100 < 100 ? x - tp.width : x;
      Offset point = Offset(x, math.min(y, size.height - tp.height));
      tp.paint(canvas, point);

      startAngl = startAngl + arcAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) { return false; }
}

class DummyChartModel {
  String name;
  int total;
  Color startColor;
  Color endColor;

  DummyChartModel({@required this.name, @required this.total, @required this.startColor, @required this.endColor});
}

