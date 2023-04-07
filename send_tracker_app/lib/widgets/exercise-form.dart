import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExerciseForm extends StatefulWidget {
  final void Function(List<String>) onData;
  // TODO: Re-add index when multiple exercise forms are generated at once
  // final int index;

  // const ExerciseForm({Key? key, required this.index, required this.onData})
  //     : super(key: key);

  const ExerciseForm({Key? key, required this.onData}) : super(key: key);

  @override
  ExerciseFormState createState() => ExerciseFormState();
}

class ExerciseFormState extends State<ExerciseForm> {
  TextStyle textTheme = TextStyle(fontSize: 20);

  String typeValue = 'Chest';
  String exerciseValue = 'DB Bench Press';

  final setsController = TextEditingController();
  final repsController = TextEditingController();
  final weightController = TextEditingController();

  // Types of exercises for each muscle group
  Map<String, List<DropdownMenuItem<String>>> exerciseMap = {
    'Chest': [
      DropdownMenuItem(
        value: 'DB Bench Press',
        child: Text('DB Bench Press'),
      ),
      DropdownMenuItem(
        value: 'Chest Dips',
        child: Text('Chest Dips'),
      ),
      DropdownMenuItem(
        value: 'Incline DB Press',
        child: Text('Incline DB Press'),
      ),
    ],
    'Back': [
      DropdownMenuItem(
        value: 'BB Row',
        child: Text('BB Row'),
      ),
      DropdownMenuItem(
        value: 'Weighted Pullups',
        child: Text('Weighted Pullups'),
      ),
      DropdownMenuItem(
        value: 'Seated Cable Row',
        child: Text('Seated Cable Row'),
      ),
      DropdownMenuItem(
        value: 'DB Shrug',
        child: Text('DB Shrug'),
      ),
    ],
    'Leg': [
      DropdownMenuItem(
        value: 'Squats',
        child: Text('Squats'),
      ),
      DropdownMenuItem(
        value: 'Leg Press',
        child: Text('Leg Press'),
      ),
      DropdownMenuItem(
        value: 'Calf Raises',
        child: Text('Calf Raises'),
      ),
      DropdownMenuItem(
        value: 'DB RDL',
        child: Text('DB RDL'),
      ),
    ],
    'Shoulder': [
      DropdownMenuItem(
        value: 'BB Overhead Press',
        child: Text('BB Overhead Press'),
      ),
      DropdownMenuItem(
        value: 'Lateral Raises',
        child: Text('Lateral Raises'),
      ),
      DropdownMenuItem(
        value: 'Rear Delt Flys',
        child: Text('Rear Delt Flys'),
      ),
    ],
    'Bicep': [
      DropdownMenuItem(
        value: 'BB Curls',
        child: Text('BB Curls'),
      ),
      DropdownMenuItem(
        value: 'Weighted Chinups',
        child: Text('Weighted Chinups'),
      ),
      DropdownMenuItem(
        value: 'Incline DB Curls',
        child: Text('Incline DB Curls'),
      ),
    ],
    'Tricep': [
      DropdownMenuItem(
        value: 'BB Skull Crushers',
        child: Text('BB Skull Crushers'),
      ),
      DropdownMenuItem(
        value: 'Overhead Tricep Ext',
        child: Text('Overhead Tricep Ext'),
      ),
      DropdownMenuItem(
        value: 'Rope Pulldowns',
        child: Text('Rope Pulldowns'),
      ),
    ],
    'Core': [
      DropdownMenuItem(
        value: 'Rope Crunches',
        child: Text('Rope Crunches'),
      ),
      DropdownMenuItem(
        value: 'Leg Raises',
        child: Text('Leg Raises'),
      ),
      DropdownMenuItem(
        value: 'Bicycle Crunches',
        child: Text('Bicycle Crunches'),
      ),
    ],
  };

  List<DropdownMenuItem<String>> get typeItems {
    return [
      DropdownMenuItem(
        value: 'Chest',
        child: Text('Chest'),
      ),
      DropdownMenuItem(
        value: 'Back',
        child: Text('Back'),
      ),
      DropdownMenuItem(
        value: 'Leg',
        child: Text('Leg'),
      ),
      DropdownMenuItem(
        value: 'Shoulder',
        child: Text('Shoulder'),
      ),
      DropdownMenuItem(
        value: 'Bicep',
        child: Text('Bicep'),
      ),
      DropdownMenuItem(
        value: 'Tricep',
        child: Text('Tricep'),
      ),
      DropdownMenuItem(
        value: 'Core',
        child: Text('Core'),
      ),
    ];
  }

  void submitData() {
    widget.onData([
      // widget.index.toString(),
      typeValue,
      exerciseValue,
      setsController.text,
      repsController.text,
      weightController.text
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Muscle group dropdown
        SizedBox(
          height: 50,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Type"),
              DropdownButton(
                  focusNode: FocusNode(canRequestFocus: false),
                  value: typeValue,
                  items: typeItems,
                  onChanged: (String? newValue) {
                    setState(() {
                      typeValue = newValue!;
                      exerciseValue = exerciseMap[typeValue]![0].value!;
                      submitData();
                    });
                  }),
            ],
          ),
        ),
        // Exercise dropdown
        SizedBox(
          height: 50,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Exercise"),
              DropdownButton(
                  focusNode: FocusNode(canRequestFocus: false),
                  value: exerciseValue,
                  items: exerciseMap[typeValue],
                  onChanged: (String? newValue) {
                    setState(() {
                      exerciseValue = newValue!;
                      submitData();
                    });
                  }),
            ],
          ),
        ),
        // Sets text field
        SizedBox(
          height: 50,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sets"),
              SizedBox(
                  height: 40,
                  width: 40,
                  child: TextField(
                    controller: setsController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      submitData();
                    },
                  ))
            ],
          ),
        ),
        // Reps text field
        SizedBox(
          height: 50,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reps"),
              SizedBox(
                  height: 40,
                  width: 40,
                  child: TextField(
                    controller: repsController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      submitData();
                    },
                  ))
            ],
          ),
        ),
        // Weight text field
        SizedBox(
          height: 50,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Weight"),
              SizedBox(
                  height: 40,
                  width: 40,
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      submitData();
                    },
                  ))
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    setsController.dispose();
    repsController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
