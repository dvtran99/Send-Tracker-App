import 'package:flutter/material.dart';
import 'package:send_tracker_app/widgets/exercise-form.dart';
import 'package:send_tracker_app/widgets/confirmation-alert.dart';
import 'package:send_tracker_app/models/exercise.dart';
import 'package:send_tracker_app/helpers.dart';
import 'package:send_tracker_app/database.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({Key? key}) : super(key: key);

  @override
  AddWorkoutScreenState createState() => AddWorkoutScreenState();
}

class AddWorkoutScreenState extends State<AddWorkoutScreen> {
  late DataBase db;

  @override
  void initState() {
    super.initState();
    db = DataBase();
    db.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }

  var exercises = <ExerciseForm>[];
  Map formData = <int, List<String>>{};

  void _onData(List<String> data) {
    formData[int.parse(data[0])] = data;
  }

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
                height: 250.0 * exercises.length,
                width: 300,
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ExerciseForm(index: index, onData: _onData),
                        CloseButton(
                          onPressed: () {
                            setState(() {
                              exercises.removeAt(index);
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 150,
                height: 30,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        exercises.add(ExerciseForm(
                            index: exercises.length, onData: _onData));
                      });
                    },
                    child: Text("Add Exercise")),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 150,
                height: 30,
                child: ElevatedButton(
                    onPressed: () async {
                      String result = await showDialog(
                          context: context,
                          builder: (BuildContext context) => ConfirmationAlert(
                                type: "send",
                              ));
                      if (result == "OK") {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Text("Add Session")),
              ),
            ],
          ),
        ));
  }
}
