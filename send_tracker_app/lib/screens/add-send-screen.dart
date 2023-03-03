import 'package:flutter/material.dart';

class AddSendScreen extends StatefulWidget {
  const AddSendScreen({Key? key}) : super(key: key);

  @override
  AddSendScreenState createState() => AddSendScreenState();
}

class AddSendScreenState extends State<AddSendScreen> {
  TextStyle textTheme = TextStyle(fontSize: 20);

  String gradeValue = 'V0';

  List<DropdownMenuItem<String>> get dropdownItems {
    return [
      DropdownMenuItem(
        value: 'V0',
        child: Text('V0'),
      ),
      DropdownMenuItem(
        value: 'V1',
        child: Text('V1'),
      ),
      DropdownMenuItem(
        value: 'V2',
        child: Text('V2'),
      ),
      DropdownMenuItem(
        value: 'V3',
        child: Text('V3'),
      ),
      DropdownMenuItem(
        value: 'V4',
        child: Text('V4'),
      ),
      DropdownMenuItem(
        value: 'V5',
        child: Text('V5'),
      ),
      DropdownMenuItem(
        value: 'V6',
        child: Text('V6'),
      ),
      DropdownMenuItem(
        value: 'V7',
        child: Text('V7'),
      ),
      DropdownMenuItem(
        value: 'V8',
        child: Text('V8'),
      ),
      DropdownMenuItem(
        value: 'V9',
        child: Text('V9'),
      ),
      DropdownMenuItem(
        value: 'V10+',
        child: Text('V10+'),
      ),
    ];
  }

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
          Text("Picture of Route", style: textTheme),
          SizedBox(height: 20),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Grade", style: textTheme),
                DropdownButton(
                    focusNode: FocusNode(canRequestFocus: false),
                    value: gradeValue,
                    items: dropdownItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        gradeValue = newValue!;
                      });
                    }),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text("Filters", style: textTheme),
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
