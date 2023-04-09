import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:send_tracker_app/database.dart';
import 'package:send_tracker_app/helpers.dart';

class ExercisesMetrics extends StatefulWidget {
  ExercisesMetrics({Key? key}) : super(key: key);

  @override
  ExercisesMetricsState createState() => ExercisesMetricsState();
}

class ExercisesMetricsState extends State<ExercisesMetrics> {
  late DataBase db;

  List<FlSpot> chestPoints = [];
  List<FlSpot> backPoints = [];
  List<FlSpot> legPoints = [];
  List<FlSpot> shoulderPoints = [];
  List<FlSpot> bicepPoints = [];
  List<FlSpot> tricepPoints = [];
  List<FlSpot> corePoints = [];

  List<double> chestYData = [];
  List<double> backYData = [];
  List<double> legYData = [];
  List<double> shoulderYData = [];
  List<double> bicepYData = [];
  List<double> tricepYData = [];
  List<double> coreYData = [];

  @override
  void initState() {
    super.initState();
    db = DataBase();
    db.initializeDB().whenComplete(() async {
      // Load and format chest data
      List<Map> chestData = await db.totalVolumePerDay('Chest');
      chestPoints = Helpers.dataToPoints(chestData, 'SUM(volume)')
              .map((item) => item as FlSpot)
              ?.toList() ??
          [];
      chestYData = Helpers.yPoints(chestData, 'SUM(volume)')
              .map((item) => item as double)
              ?.toList() ??
          [];
      chestYData.sort();

      // Load and format back data
      List<Map> backData = await db.totalVolumePerDay('Back');
      backPoints = Helpers.dataToPoints(backData, 'SUM(volume)')
              .map((item) => item as FlSpot)
              ?.toList() ??
          [];
      backYData = Helpers.yPoints(backData, 'SUM(volume)')
              .map((item) => item as double)
              ?.toList() ??
          [];
      backYData.sort();

      // Load and format leg data
      List<Map> legData = await db.totalVolumePerDay('Leg');
      legPoints = Helpers.dataToPoints(legData, 'SUM(volume)')
              .map((item) => item as FlSpot)
              ?.toList() ??
          [];
      legYData = Helpers.yPoints(legData, 'SUM(volume)')
              .map((item) => item as double)
              ?.toList() ??
          [];
      legYData.sort();

      // Load and format shoulder data
      List<Map> shoulderData = await db.totalVolumePerDay('Shoulder');
      shoulderPoints = Helpers.dataToPoints(shoulderData, 'SUM(volume)')
              .map((item) => item as FlSpot)
              ?.toList() ??
          [];
      shoulderYData = Helpers.yPoints(shoulderData, 'SUM(volume)')
              .map((item) => item as double)
              ?.toList() ??
          [];
      shoulderYData.sort();

      // Load and format bicep data
      List<Map> bicepData = await db.totalVolumePerDay('Bicep');
      bicepPoints = Helpers.dataToPoints(bicepData, 'SUM(volume)')
              .map((item) => item as FlSpot)
              ?.toList() ??
          [];
      bicepYData = Helpers.yPoints(bicepData, 'SUM(volume)')
              .map((item) => item as double)
              ?.toList() ??
          [];
      bicepYData.sort();

      // Load and format tricep data
      List<Map> tricepData = await db.totalVolumePerDay('Tricep');
      tricepPoints = Helpers.dataToPoints(tricepData, 'SUM(volume)')
              .map((item) => item as FlSpot)
              ?.toList() ??
          [];
      tricepYData = Helpers.yPoints(tricepData, 'SUM(volume)')
              .map((item) => item as double)
              ?.toList() ??
          [];
      tricepYData.sort();

      // Load and format core data
      List<Map> coreData = await db.totalVolumePerDay('Core');
      corePoints = Helpers.dataToPoints(coreData, 'SUM(volume)')
              .map((item) => item as FlSpot)
              ?.toList() ??
          [];
      coreYData = Helpers.yPoints(coreData, 'SUM(volume)')
              .map((item) => item as double)
              ?.toList() ??
          [];
      coreYData.sort();

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
        Text("Chest Volume (Last 10 Sessions)", style: TextStyle(fontSize: 20)),
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
                minY: chestYData.isNotEmpty ? chestYData.first - 10 : 0,
                maxY: chestYData.isNotEmpty ? chestYData.last + 10 : 10,
                minX: 0,
                maxX: 9,
                lineBarsData: [
                  LineChartBarData(
                    spots: chestPoints,
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
        Text("Back Volume (Last 10 Sessions)", style: TextStyle(fontSize: 20)),
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
                minY: backYData.isNotEmpty ? backYData.first - 10 : 0,
                maxY: backYData.isNotEmpty ? backYData.last + 10 : 10,
                minX: 0,
                maxX: 9,
                lineBarsData: [
                  LineChartBarData(
                    spots: backPoints,
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
        Text("Leg Volume (Last 10 Sessions)", style: TextStyle(fontSize: 20)),
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
                minY: legYData.isNotEmpty ? legYData.first - 10 : 0,
                maxY: legYData.isNotEmpty ? legYData.last + 10 : 10,
                minX: 0,
                maxX: 9,
                lineBarsData: [
                  LineChartBarData(
                    spots: legPoints,
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
        Text("Shoulder Volume (Last 10 Sessions)",
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
                minY: shoulderYData.isNotEmpty ? shoulderYData.first - 10 : 0,
                maxY: shoulderYData.isNotEmpty ? shoulderYData.last + 10 : 0,
                minX: 0,
                maxX: 9,
                lineBarsData: [
                  LineChartBarData(
                    spots: shoulderPoints,
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
        Text("Bicep Volume (Last 10 Sessions)", style: TextStyle(fontSize: 20)),
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
                minY: bicepYData.isNotEmpty ? bicepYData.first - 10 : 0,
                maxY: bicepYData.isNotEmpty ? bicepYData.last + 10 : 10,
                minX: 0,
                maxX: 9,
                lineBarsData: [
                  LineChartBarData(
                    spots: bicepPoints,
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
        Text("Tricep Volume (Last 10 Sessions)",
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
                minY: tricepYData.isNotEmpty ? tricepYData.first - 10 : 0,
                maxY: tricepYData.isNotEmpty ? tricepYData.last + 10 : 10,
                minX: 0,
                maxX: 9,
                lineBarsData: [
                  LineChartBarData(
                    spots: tricepPoints,
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
        Text("Core Volume (Last 10 Sessions)", style: TextStyle(fontSize: 20)),
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
                minY: coreYData.isNotEmpty ? coreYData.first - 10 : 0,
                maxY: coreYData.isNotEmpty ? coreYData.last + 10 : 10,
                minX: 0,
                maxX: 9,
                lineBarsData: [
                  LineChartBarData(
                    spots: corePoints,
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
