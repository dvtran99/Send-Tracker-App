import 'package:flutter/material.dart';
import 'package:send_tracker_app/database.dart';
import 'package:send_tracker_app/models/exercise.dart';
import 'package:send_tracker_app/models/send.dart';
import 'package:send_tracker_app/widgets/delete-alert.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  late DataBase db;

  List<Exercise> exerciseList = [];
  List<Send> sendList = [];

  @override
  void initState() {
    super.initState();
    db = DataBase();
    db.initializeDB().whenComplete(() async {
      exerciseList = await db.getExercises();
      sendList = await db.getSends();
      setState(() {});
    });
  }

  String tableValue = 'sends';

  List<DropdownMenuItem<String>> get tableItems {
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
      appBar: AppBar(
        title: Text('History'),
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
                    Text("Table", style: TextStyle(fontSize: 20)),
                    DropdownButton(
                        focusNode: FocusNode(canRequestFocus: false),
                        value: tableValue,
                        items: tableItems,
                        onChanged: (String? newValue) {
                          setState(() {
                            tableValue = newValue!;
                          });
                        }),
                  ],
                ),
              ),
              if (tableValue == 'sends') ...[
                Container(
                  color: Colors.white,
                  child: Table(
                    columnWidths: {
                      // Adjust column widths to fit everything
                      0: FlexColumnWidth(1.25),
                      5: FlexColumnWidth(0.35)
                    },
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      // Column names
                      TableRow(children: [
                        Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: Text(
                            'Date',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: Text(
                            'Location',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: Text(
                            'Color',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: Text(
                            'Grade',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: Text(
                            'Styles',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 10,
                          alignment: Alignment.center,
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                      // Format send data to display in table
                      for (var send in sendList) ...[
                        TableRow(children: [
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              '${send.date.substring(0, 2)}/${send.date.substring(2, 4)}/${send.date.substring(4)}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              send.location,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              send.color,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              'V${send.grade}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var style in send.styles.split(';')) ...[
                                  Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(style,
                                            textAlign: TextAlign.center)),
                                  ),
                                ]
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () async {
                                String result = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DeleteAlert(type: "send", send: send));
                                if (result == "OK") {
                                  db.deleteSend(send.id);
                                  // Reload table with updated data
                                  sendList = await db.getSends();
                                  setState(() {});
                                }
                              },
                              child: Text(
                                'X',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ],
                  ),
                ),
              ] else if (tableValue == 'exercises') ...[
                Container(
                  color: Colors.white,
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(1.2),
                      1: FlexColumnWidth(0.9),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(0.75),
                      4: FlexColumnWidth(0.35)
                    },
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(
                        children: [
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              'Date',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              'Group',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              'Exercise',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              'Volume',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      // Format exercise data to display in table
                      for (var exercise in exerciseList) ...[
                        TableRow(children: [
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              '${exercise.date.substring(0, 2)}/${exercise.date.substring(2, 4)}/${exercise.date.substring(4)}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              exercise.type,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              exercise.name,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              '${exercise.volume}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () async {
                                String result = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DeleteAlert(
                                            type: "exercise",
                                            exercise: exercise));
                                if (result == "OK") {
                                  db.deleteExercise(exercise.id);
                                  // Reload table with updated data
                                  exerciseList = await db.getExercises();
                                  setState(() {});
                                }
                              },
                              child: Text(
                                'X',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ],
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
