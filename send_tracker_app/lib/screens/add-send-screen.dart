import 'package:flutter/material.dart';
import 'package:send_tracker_app/widgets/confirmation-alert.dart';

class AddSendScreen extends StatefulWidget {
  const AddSendScreen({Key? key}) : super(key: key);

  @override
  AddSendScreenState createState() => AddSendScreenState();
}

class AddSendScreenState extends State<AddSendScreen> {
  TextStyle textTheme = TextStyle(fontSize: 20);

  String locationValue = 'Indoor';
  String gradeValue = 'V0';
  String colorValue = 'Red';
  String styleValue = 'Juggy';

  List<String> styles = <String>[];

  bool showCustomStyle = false;
  final customStyleController = TextEditingController();

  List<DropdownMenuItem<String>> get locationItems {
    return [
      DropdownMenuItem(
        value: 'Indoor',
        child: Text('Indoor'),
      ),
      DropdownMenuItem(
        value: 'Outdoor',
        child: Text('Outdoor'),
      ),
    ];
  }

  List<DropdownMenuItem<String>> get gradeItems {
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

  List<DropdownMenuItem<String>> get colorItems {
    return [
      DropdownMenuItem(
        value: 'Red',
        child: Text('Red'),
      ),
      DropdownMenuItem(
        value: 'Yellow',
        child: Text('Yellow'),
      ),
      DropdownMenuItem(
        value: 'Green',
        child: Text('Green'),
      ),
      DropdownMenuItem(
        value: 'White',
        child: Text('White'),
      ),
      DropdownMenuItem(
        value: 'Blue',
        child: Text('Blue'),
      ),
      DropdownMenuItem(
        value: 'Black',
        child: Text('Black'),
      ),
      DropdownMenuItem(
        value: 'Purple',
        child: Text('Purple'),
      ),
      DropdownMenuItem(
        value: 'Orange',
        child: Text('Orange'),
      ),
      DropdownMenuItem(
        value: 'Pink',
        child: Text('Pink'),
      ),
    ];
  }

  List<DropdownMenuItem<String>> get styleItems {
    return [
      DropdownMenuItem(
        value: 'Juggy',
        child: Text('Juggy'),
      ),
      DropdownMenuItem(
        value: 'Crimpy',
        child: Text('Crimpy'),
      ),
      DropdownMenuItem(
        value: 'Pinchy',
        child: Text('Pinchy'),
      ),
      DropdownMenuItem(
        value: 'Slopey',
        child: Text('Slopey'),
      ),
      DropdownMenuItem(
        value: 'Slabby',
        child: Text('Slabby'),
      ),
      DropdownMenuItem(
        value: 'Dynamicy',
        child: Text('Dynamicy'),
      ),
      DropdownMenuItem(
        value: 'Compressiony',
        child: Text('Compressiony'),
      ),
      DropdownMenuItem(
        value: 'Custom...',
        child: Text('Custom...'),
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
          SizedBox(
            height: 50,
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Location", style: textTheme),
                DropdownButton(
                    focusNode: FocusNode(canRequestFocus: false),
                    value: locationValue,
                    items: locationItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        locationValue = newValue!;
                      });
                    }),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Color", style: textTheme),
                DropdownButton(
                    focusNode: FocusNode(canRequestFocus: false),
                    value: colorValue,
                    items: colorItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        colorValue = newValue!;
                      });
                    }),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Grade", style: textTheme),
                DropdownButton(
                    focusNode: FocusNode(canRequestFocus: false),
                    value: gradeValue,
                    items: gradeItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        gradeValue = newValue!;
                      });
                    }),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Style", style: textTheme),
                DropdownButton(
                    focusNode: FocusNode(canRequestFocus: false),
                    value: styleValue,
                    items: styleItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        styleValue = newValue!;
                        if (styleValue == 'Custom...') {
                          showCustomStyle = true;
                          return;
                        }
                        if (!styles.contains(styleValue)) {
                          styles.add(styleValue);
                        }
                      });
                    }),
              ],
            ),
          ),
          if (showCustomStyle) ...[
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: TextField(
                      controller: customStyleController,
                      decoration: InputDecoration(hintText: 'Custom Style'),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (!styles.contains(customStyleController.text)) {
                              styles.add(customStyleController.text);
                              customStyleController.text = '';
                              showCustomStyle = false;
                              styleValue = 'Juggy';
                            }
                          });
                        },
                        child: Text(
                          '+',
                          style: textTheme,
                        )),
                  )
                ],
              ),
            ),
          ],
          SizedBox(height: 20),
          SizedBox(
            height: 50.0 * styles.length,
            width: 200,
            child: ListView.builder(
              itemCount: styles.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(styles[index]),
                      CloseButton(
                        onPressed: () {
                          setState(() {
                            styles.removeAt(index);
                          });
                        },
                      )
                    ],
                  ),
                );
              },
            ),
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
                    print("User pressed OK");
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: Text("Add Send")),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    customStyleController.dispose();
    super.dispose();
  }
}
