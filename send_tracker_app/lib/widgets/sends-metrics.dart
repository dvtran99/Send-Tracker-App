import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:send_tracker_app/database.dart';
import 'package:send_tracker_app/helpers.dart';

class SendsMetrics extends StatefulWidget {
  const SendsMetrics({Key? key}) : super(key: key);

  @override
  SendsMetricsState createState() => SendsMetricsState();
}

class SendsMetricsState extends State<SendsMetrics> {
  late DataBase db;

  List<FlSpot> totalSendsPoints = [];
  List<FlSpot> avgSendsPoints = [];

  List<double> totalSendsYData = [];
  List<double> avgSendsYData = [];

  @override
  void initState() {
    super.initState();
    db = DataBase();
    db.initializeDB().whenComplete(() async {
      // Load and format total sends data
      List<Map> totalSendsData = await db.totalSendsPerDay();
      totalSendsPoints = Helpers.dataToPoints(totalSendsData, 'COUNT(id)')
              .map((item) => item as FlSpot)
              ?.toList() ??
          [];
      totalSendsYData = Helpers.yPoints(totalSendsData, 'COUNT(id)')
              .map((item) => item as double)
              ?.toList() ??
          [];
      totalSendsYData.sort();

      // Load and format average sends data
      List<Map> avgSendsData = await db.averageSendsPerDay();
      avgSendsPoints = Helpers.dataToPoints(avgSendsData, 'AVG(grade)')
              .map((item) => item as FlSpot)
              ?.toList() ??
          [];
      avgSendsYData = Helpers.yPoints(avgSendsData, 'AVG(grade)')
              .map((item) => item as double)
              ?.toList() ??
          [];
      avgSendsYData.sort();

      setState(() {});
    });
  }

  final List<Color> gradientColors = [
    Color(0xFF50E4FF),
    Color(0xFF2196F3),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Total Sends (Last 10 Sessions)", style: TextStyle(fontSize: 20)),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: false,
                  verticalInterval: 1,
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                minY:
                    totalSendsYData.isNotEmpty ? totalSendsYData.first - 1 : 0,
                maxY:
                    totalSendsYData.isNotEmpty ? totalSendsYData.last + 1 : 10,
                minX: 0,
                maxX: 9,
                lineBarsData: [
                  LineChartBarData(
                    spots: totalSendsPoints,
                    isCurved: true,
                    barWidth: 2.5,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: gradientColors
                            .map((color) => color.withOpacity(0.3))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text("Average Sends (Last 10 Sessions)",
            style: TextStyle(fontSize: 20)),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: false,
                  verticalInterval: 1,
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                minY: avgSendsPoints.isNotEmpty ? avgSendsYData.first - 1 : 0,
                maxY: avgSendsPoints.isNotEmpty ? avgSendsYData.last + 1 : 10,
                minX: 0,
                maxX: 9,
                lineBarsData: [
                  LineChartBarData(
                    spots: avgSendsPoints,
                    isCurved: true,
                    barWidth: 2.5,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: gradientColors
                            .map((color) => color.withOpacity(0.3))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
