import 'package:flutter/material.dart';
import 'widgets/nav-drawer.dart';
import 'widgets/sends-metrics.dart';
import 'database.dart';

import 'package:fl_chart/fl_chart.dart';
import 'helpers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  late DataBase handler;

  @override
  void initState() {
    super.initState();
    handler = DataBase();
    handler.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late DataBase db;

  @override
  void initState() {
    super.initState();
    db = DataBase();
    db.initializeDB().whenComplete(() async {
      print("INITIALIZED!");
      setState(() {});
    });
  }

  String graphValue = 'sends';

  List<DropdownMenuItem<String>> get graphItems {
    return [
      DropdownMenuItem(
        value: 'sends',
        child: Text('Sends'),
      ),
      DropdownMenuItem(
        value: 'exercises',
        child: Text('Exercises'),
      ),
      DropdownMenuItem(
        value: 'queries',
        child: Text('Queries'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Send Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Metrics", style: TextStyle(fontSize: 20)),
                    DropdownButton(
                        focusNode: FocusNode(canRequestFocus: false),
                        value: graphValue,
                        items: graphItems,
                        onChanged: (String? newValue) {
                          setState(() {
                            graphValue = newValue!;
                          });
                        }),
                  ],
                ),
              ),
              if (graphValue == 'queries') ...[
                ElevatedButton(
                  onPressed: () async {
                    var totSends = await db.totalSendsPerDay();
                    print(totSends);
                  },
                  child: const Text("Query tot_send"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var avgSends = await db.averageSendsPerDay();
                    print(avgSends);
                  },
                  child: const Text("Query avg_send"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var totChestVolume = await db.totalVolumePerDay('Chest');
                    print(totChestVolume);
                    var totBackVolume = await db.totalVolumePerDay('Back');
                    print(totBackVolume);
                    var totLegVolume = await db.totalVolumePerDay('Leg');
                    print(totLegVolume);
                    var totShoulderVolume =
                        await db.totalVolumePerDay('Shoulder');
                    print(totShoulderVolume);
                  },
                  child: const Text("Query tot_volume"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    List<Map> totalSendsData = await db.totalSendsPerDay();
                    List<FlSpot> totalSendsPoints =
                        Helpers.dataToPoints(totalSendsData, 'COUNT(id)')
                                .map((item) => item as FlSpot)
                                ?.toList() ??
                            [];
                    print(totalSendsPoints);
                  },
                  child: const Text("Get fl spots"),
                ),
              ] else if (graphValue == 'sends') ...[
                SendsMetrics(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
