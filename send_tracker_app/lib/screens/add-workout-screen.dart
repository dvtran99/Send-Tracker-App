import 'package:flutter/material.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({Key? key}) : super(key: key);

  @override
  AddWorkoutScreenState createState() => AddWorkoutScreenState();
}

class AddWorkoutScreenState extends State<AddWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Workout'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(
                width: 150,
                height: 30,
                child: ElevatedButton(
                    onPressed: () {
                      print('Pressed!');
                    },
                    child: Text("Add Exercise")),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 150,
                height: 30,
                child: ElevatedButton(
                    onPressed: () {
                      print('Pressed!');
                    },
                    child: Text("Add Session")),
              ),
            ],
          ),
        ));
  }
}
