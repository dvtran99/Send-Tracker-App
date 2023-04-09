import 'package:flutter/material.dart';
import 'widgets/nav-drawer.dart';
import 'widgets/sends-metrics.dart';
import 'widgets/exercises-metrics.dart';
import 'database.dart';

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
              if (graphValue == 'sends') ...[
                SendsMetrics(),
              ] else if (graphValue == 'exercises') ...[
                ExercisesMetrics(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
