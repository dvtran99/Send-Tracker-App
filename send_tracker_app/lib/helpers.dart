import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

import 'dart:math';

class Helpers {
  static String today() {
    var now = DateTime.now();
    var formatter = DateFormat("MMddyyyy");
    return formatter.format(now);
  }

  static List<dynamic> dataToPoints(List<Map> data, String columnName) {
    var points = [];

    for (var i = 0; i < data.length; i++) {
      points.add(FlSpot(9.0 - i, data[i][columnName].toDouble()));
    }

    return points;
  }

  static List<dynamic> yPoints(List<Map> data, String columnName) {
    var yData = [];

    for (var datum in data) {
      yData.add(datum[columnName].toDouble());
    }

    return yData;
  }
}
