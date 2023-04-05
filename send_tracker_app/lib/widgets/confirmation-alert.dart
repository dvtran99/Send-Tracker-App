import 'package:flutter/material.dart';

class ConfirmationAlert extends StatelessWidget {
  final String type;

  const ConfirmationAlert({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add $type"),
      content: Text("Are you sure you want to add this $type?"),
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
