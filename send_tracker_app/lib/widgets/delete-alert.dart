import 'package:flutter/material.dart';
import 'package:send_tracker_app/models/exercise.dart';
import 'package:send_tracker_app/models/send.dart';

class DeleteAlert extends StatelessWidget {
  final String type;
  final Exercise exercise;
  final Send send;

  const DeleteAlert(
      {Key? key,
      required this.type,
      this.exercise =
          const Exercise(id: 0, date: '', type: '', name: '', volume: 0),
      this.send = const Send(
          id: 0, date: '', location: '', color: '', grade: 0, styles: '')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete $type"),
      content: Container(
        height: type == 'send' ? 180 : 140,
        child: Column(
          children: [
            Text("Are you sure you want to delete this $type?"),
            SizedBox(height: 20),
            if (type == 'send') ...[
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Text(
                    "Date: ${send.date.substring(0, 2)}/${send.date.substring(2, 4)}/${send.date.substring(4)}"),
              ),
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Text("Location: ${send.location}"),
              ),
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Text("Color: ${send.color}"),
              ),
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Text("Grade: V${send.grade}"),
              ),
              Container(
                height: 40,
                alignment: Alignment.topLeft,
                child: Row(children: [
                  Flexible(
                    child: Text("Styles: ${send.styles}"),
                  )
                ]),
              ),
            ] else if (type == "exercise") ...[
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Text(
                    "Date: ${exercise.date.substring(0, 2)}/${exercise.date.substring(2, 4)}/${exercise.date.substring(4)}"),
              ),
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Text("Group: ${exercise.type}"),
              ),
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Text("Exercise: ${exercise.name}"),
              ),
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Text("Volume: ${exercise.volume}"),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, "Cancel"),
            child: const Text("Cancel")),
        TextButton(
            onPressed: () => Navigator.pop(context, "OK"),
            child: const Text("OK")),
      ],
    );
  }
}
