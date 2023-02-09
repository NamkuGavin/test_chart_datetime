// To parse this JSON data, do
//
//     final chartdatetimemodel = chartdatetimemodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Chartdatetimemodel chartdatetimemodelFromJson(String str) =>
    Chartdatetimemodel.fromJson(json.decode(str));

String chartdatetimemodelToJson(Chartdatetimemodel data) =>
    json.encode(data.toJson());

class Chartdatetimemodel {
  Chartdatetimemodel({
    required this.data,
    required this.minY,
    required this.maxY,
    required this.intervalY,
    required this.performanceTitle,
  });

  List<Datum> data;
  int minY;
  int maxY;
  int intervalY;
  String performanceTitle;

  factory Chartdatetimemodel.fromJson(Map<String, dynamic> json) =>
      Chartdatetimemodel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        minY: json["min_y"],
        maxY: json["max_y"],
        intervalY: json["interval_y"],
        performanceTitle: json["performance_title"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "min_y": minY,
        "max_y": maxY,
        "interval_y": intervalY,
        "performance_title": performanceTitle,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.aOneDayReturns,
    required this.lastReturn,
  });

  String id;
  String name;
  List<AOneDayReturn> aOneDayReturns;
  double lastReturn;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        aOneDayReturns: List<AOneDayReturn>.from(
            json["a_one_day_returns"].map((x) => AOneDayReturn.fromJson(x))),
        lastReturn: json["last_return"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "a_one_day_returns":
            List<dynamic>.from(aOneDayReturns.map((x) => x.toJson())),
        "last_return": lastReturn,
      };
}

class AOneDayReturn {
  AOneDayReturn({
    required this.date,
    required this.aOneDayReturnReturn,
  });

  DateTime date;
  double aOneDayReturnReturn;

  factory AOneDayReturn.fromJson(Map<String, dynamic> json) => AOneDayReturn(
        date: DateTime.parse(json["date"]),
        aOneDayReturnReturn: json["return"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "return": aOneDayReturnReturn,
      };
}
