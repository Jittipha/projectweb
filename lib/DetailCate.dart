// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectweb/Background/Bg-DetailStudent.dart';
import 'package:responsive_builder/responsive_builder.dart';

class detailcate extends StatefulWidget {
  detailcate({Key? key, required this.Precate}) : super(key: key);
  // ignore: non_constant_identifier_names
  QueryDocumentSnapshot Precate;

  @override
  State<detailcate> createState() => _detailcateState();
}

// ignore: camel_case_types
class _detailcateState extends State<detailcate> {
  late String Status;
  late String Bigtextstatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Background(
          child: Container(
              padding: const EdgeInsets.all(60),
              child: ScreenTypeLayout(
                desktop: Builddesktop(context),
                tablet: Buildtablet(),
                mobile: Buildmobile(),
              )),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget Builddesktop(BuildContext context) => Row(children: [
        Container(
            padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
            width: MediaQuery.of(context).size.width * 0.45,
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.all(8), // Border width
                  decoration: BoxDecoration(
                      color: Colors.greenAccent[400],
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(200), // Image radius
                      child: Image.network(widget.Precate["Image"],
                          fit: BoxFit.cover),
                    ),
                  ),
                ))),
        // CircleAvatar(
        //     radius: 200,
        //     backgroundColor: Colors.greenAccent[700],
        //     child: CircleAvatar(
        //       radius: 195,
        //       backgroundImage: NetworkImage(widget.Precate["Image"]),
        //     )))),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name   :   " + widget.Precate["Name"],
                      style: const TextStyle(fontSize: 35),
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description   :   " + widget.Precate["Description"],
                      style: const TextStyle(fontSize: 35),
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Host   :  ",
                      style: TextStyle(fontSize: 35),
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.lightBlueAccent[100],
                      child: CircleAvatar(
                        radius: 48,
                        backgroundImage:
                            NetworkImage(widget.Precate['Student'][0]['Photo']),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(
                      widget.Precate['Student'][0]["Name"],
                      style: const TextStyle(fontSize: 35),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Status = 'correct';
                              Bigtextstatus = 'CORRECT!';
                              showAlert(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.greenAccent[400],
                              ),
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'CORRECT',
                                    // textScaleFactor: 2,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                              height: 60,
                              width: 150,
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                            onTap: () {
                              Bigtextstatus = 'INCORRECT!';
                              Status = 'incorrect';
                              showAlert(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.redAccent,
                              ),
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'INCORRECT',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                              height: 60,
                              width: 150,
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blueGrey),
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'BACK',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                              height: 60,
                              width: 150,
                            )),
                      ],
                    ))
              ],
            ))
      ]);

  // ignore: non_constant_identifier_names
  Widget Buildmobile() => const Center(
          child: Text(
        "โปรดขยายหน้าจอ !!",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ));

  // ignore: non_constant_identifier_names
  Widget Buildtablet() => const Center(
          child: Text(
        "โปรดขยายหน้าจอ !!",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ));

  showAlert(context) {
    // set up the button
    Widget okButton = FlatButton(
        child: const Text("YES"),
        onPressed: () async {
          // ignore: non_constant_identifier_names
          if (Status == 'correct') {
            addtoCategory();
            addtoNoti(Status);
            DeletePrecate();
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            addtoNoti(Status);
            DeletePrecate();
            Navigator.pop(context);
            Navigator.pop(context);
          }
        });

    Widget cancleButton = FlatButton(
      child: const Text("NO"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Bigtextstatus),
      content: Text("This category is " + Status + ". Right?"),
      actions: [cancleButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ignore: non_constant_identifier_names
  void addtoCategory() async {
    await FirebaseFirestore.instance.collection("Category").doc().set({
      'Name': widget.Precate["Name"],
      'Description': widget.Precate["Description"],
      'Image': widget.Precate["Image"]
    });
  }

  // ignore: non_constant_identifier_names
  addtoNoti(Status) async {
    // ignore: non_constant_identifier_names
    String Time = DateFormat("hh:mm:ss").format(DateTime.now());
    String date = DateFormat("dd/MM/yyyy").format(DateTime.now());
    await FirebaseFirestore.instance.collection("Notification").doc().set({
      'Name': widget.Precate["Name"],
      'Photo': widget.Precate["Image"],
      'Description': widget.Precate["Description"],
      'Status': 'edited',
      'StatusofApproved': Status,
      'Type': '2',
      'Time': Time,
      'date': date,
      'Student_id': [widget.Precate['Student'][0]['Student_id']]
    });
  }

  // ignore: non_constant_identifier_names
  void DeletePrecate() async {
    await FirebaseFirestore.instance
        .collection("PreCategories")
        .doc(widget.Precate.id)
        .delete();
  }
}
