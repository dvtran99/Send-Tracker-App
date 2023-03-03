import 'package:flutter/material.dart';

class AddSendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Send'),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(height: 20),
          Text("Picture of Route"),
          SizedBox(height: 20),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
          SizedBox(height: 20),
          Text("Grade"),
          SizedBox(height: 20),
          Text("Filters"),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                print('Pressed!');
              },
              child: Text("Add")),
        ],
      )),
    );
  }
}
