import 'dart:convert';
import 'dart:io';

import 'package:chart_date_test/chart_date_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Chartdatetimemodel> getChart() async {
    final request = await http.get(
      Uri.parse("https://oforu.talenavi.com/api/test/charts"),
    );
    if (request.statusCode == 200) {
      return Chartdatetimemodel.fromJson(jsonDecode(request.body));
    } else {
      print(request.statusCode);
      throw HttpException('request error code ${request.statusCode}');
    }
  }
}
