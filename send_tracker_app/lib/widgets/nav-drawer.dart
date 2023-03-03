import 'package:flutter/material.dart';
import 'package:send_tracker_app/screens/add-send-screen.dart';
import 'package:send_tracker_app/screens/add-workout-screen.dart';
import 'package:send_tracker_app/screens/history-screen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(""),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('assets/logo.png'))),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Send'),
            onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddSendScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Workout'),
            onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddWorkoutScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HistoryScreen()))
            },
          ),
        ],
      ),
    );
  }
}
