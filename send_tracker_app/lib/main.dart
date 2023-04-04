import 'package:flutter/material.dart';

import 'widgets/nav-drawer.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Send Tracker'),
      ),
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
