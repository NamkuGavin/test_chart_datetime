import 'package:chart_date_test/api_service.dart';
import 'package:chart_date_test/chart_date_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoad = false;
  List<AOneDayReturn>? aOneDayReturns;
  Chartdatetimemodel? _model;
  TooltipBehavior? toolTipBehaviour;

  Future getChart() async {
    try {
      setState(() {
        _isLoad = true;
      });
      Chartdatetimemodel model = await ApiService().getChart();
      setState(() {
        _model = model;
        aOneDayReturns = model.data[0].aOneDayReturns;
        _isLoad = false;
      });
    } catch (error) {
      print('no internet ' + error.toString());
    }
  }

  @override
  void initState() {
    toolTipBehaviour = TooltipBehavior(enable: true);
    getChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoad
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff8A8A8A).withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: SfCartesianChart(
                    tooltipBehavior: toolTipBehaviour,
                    primaryYAxis: NumericAxis(
                        labelFormat: '{value}',
                        // visibleMinimum: _model!.minY.toDouble(),
                        // visibleMaximum: _model!.maxY.toDouble(),
                        minimum: _model!.minY.toDouble(),
                        maximum: _model!.maxY.toDouble(),
                        interval: _model!.intervalY.toDouble(),
                        majorGridLines: MajorGridLines(width: 0),
                        minorGridLines: MinorGridLines(width: 0),
                        title: AxisTitle(text: "return")),
                    primaryXAxis: DateTimeAxis(
                      labelRotation: 50,
                      interval: 6,
                      intervalType: DateTimeIntervalType.months,
                      majorGridLines: MajorGridLines(width: 0),
                      minorGridLines: MinorGridLines(width: 0),
                      // labelStyle: TextStyle(fontSize: 10),
                      // visibleMinimum: DateFormat("yyyy-MM-dd").parse(aOneDayReturns![0].date.toString()),
                      dateFormat: DateFormat("dd-MMM-yyyy"),
                    ),
                    series: <CartesianSeries>[
                      LineSeries<AOneDayReturn, DateTime>(
                          enableTooltip: true,
                          color: Colors.blue,
                          dataSource: aOneDayReturns!,
                          emptyPointSettings:
                              EmptyPointSettings(mode: EmptyPointMode.drop),
                          xValueMapper: (AOneDayReturn exp, _) => exp.date,
                          yValueMapper: (AOneDayReturn exp, _) =>
                              exp.aOneDayReturnReturn),
                    ]),
              ));
  }
}
