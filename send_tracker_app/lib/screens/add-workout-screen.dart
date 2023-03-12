import 'package:flutter/material.dart';
import 'package:send_tracker_app/widgets/exercise-form.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({Key? key}) : super(key: key);

  @override
  AddWorkoutScreenState createState() => AddWorkoutScreenState();
}

class AddWorkoutScreenState extends State<AddWorkoutScreen> {
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
                    onPressed: () {
                      formData.forEach((key, value) {
                        String type = value[1];
                        String name = value[2];
                        int sets = int.tryParse(value[3]) == null
                            ? 0
                            : int.parse(value[3]);
                        int reps = int.tryParse(value[4]) == null
                            ? 0
                            : int.parse(value[4]);
                        int weight = int.tryParse(value[5]) == null
                            ? 0
                            : int.parse(value[5]);
                        print(
                            "Index: $key / Type $type / Name $name / Sets $sets / Reps $reps / Weight $weight");
                      });
                    },
                    child: Text("Add Session")),
              ),
            ],
          ),
        ));
  }
}
