// ignore_for_file: camel_case_types, file_names, must_be_immutable, non_constant_identifier_names, duplicate_ignore, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, await_only_futures, avoid_single_cascade_in_expression_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectweb/Home.dart';
import 'package:responsive_builder/responsive_builder.dart';

class datailEvent extends StatefulWidget {
  datailEvent({Key? key, required this.Event}) : super(key: key);
  QueryDocumentSnapshot Event;

  @override
  State<datailEvent> createState() => _datailEventState();
}

class _datailEventState extends State<datailEvent> {
  @override
  Widget build(BuildContext context) {
 return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Container(
           height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1508614999368-9260051292e5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                  fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.all(60),
            child: ScreenTypeLayout(
              desktop: Builddesktop(context),
              tablet: Buildtablet(),
              mobile: Buildmobile(),
            )));
  }

  Widget Builddesktop(BuildContext context) => Row(children: [
        Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            width: MediaQuery.of(context).size.width * 0.40,
            height: 400,
            child: Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                    radius: 250,
                    backgroundColor: Color.fromARGB(255, 247, 244, 244),
                    child: CircleAvatar(
                      radius: 185,
                      backgroundImage: NetworkImage(widget.Event["Image"]),
                    )))),
        Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 230, 233, 232),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(50.0),
            width: MediaQuery.of(context).size.width * 0.39,
            height: 700,
            child: ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name   :   " + widget.Event["Name"],
                      style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 35,)),
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description   :   " + widget.Event["Description"],
                      style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 22,)),
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                            radius: 40,
                            backgroundColor:
                                const Color.fromARGB(255, 15, 15, 15),
                            child: CircleAvatar(
                              radius: 38,
                              backgroundImage: NetworkImage(
                                  widget.Event["Host"][0]["Photo"]),
                            ))),
                    const SizedBox(
                      width: 30,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ผู้สร้างโพส   :   " +
                              widget.Event["Host"][0]["Name"],
                          style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 22,)),
                          // TextStyle(fontSize: 22),
                          textAlign: TextAlign.left,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Time   :   " + widget.Event["Time"],
                          style: const TextStyle(fontSize: 22),
                          textAlign: TextAlign.left,
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "date   :   " + widget.Event["date"],
                          style: const TextStyle(fontSize: 22),
                          textAlign: TextAlign.left,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(60, 20, 0, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              showAlertDialog(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.redAccent,
                              ),
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'DELETE',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  )),
                              height: 60,
                              width: 150,
                            )),
                        const SizedBox(
                          width: 50,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.greenAccent[400],
                              ),
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'BACK',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
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

  showAlertDialog(context) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () async {
          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection("Event")
              .doc(widget.Event.id)
              .collection("Joined")
              .get();
          snap.docs.forEach((data) {
            FirebaseFirestore.instance
                .collection("Event")
                .doc(widget.Event.id)
                .collection("Joined")
                .doc(data.id)
                .delete();
          });
          DeleteNotification();
          DeleteEventInstudentPost();
          DeleteComment();
          DeleteEvent();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new Homepage()),
          );
        });

    // ignore: deprecated_member_use
    Widget cancleButton = FlatButton(
      child: const Text("CANCLE"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Event!"),
      content: const Text("Are you sure?"),
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
  void DeleteNotification() async {
    await FirebaseFirestore.instance
        .collection("Notification")
        .doc(widget.Event.id)
        .delete();
  }

  // ignore: non_constant_identifier_names
  void DeleteEventInstudentPost() async {
    QuerySnapshot DeleteStudent = await FirebaseFirestore.instance
        .collection("Student")
        .doc(widget.Event["Host"][0]["Student_id"])
        .collection("Posts")
        .where("Event_id", isEqualTo: widget.Event.id)
        .get();
    DeleteStudent.docs.forEach((element) async {
      await FirebaseFirestore.instance
        ..collection("Student")
            .doc(widget.Event["Host"][0]["Student_id"])
            .collection("Posts")
            .doc(element.id)
            .delete();
    });
  }

  // ignore: non_constant_identifier_names
  void DeleteComment() async {
    await FirebaseFirestore.instance
        .collection("Comment")
        .where("eId", isEqualTo: widget.Event.id)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                FirebaseFirestore.instance
                    .collection("Comment")
                    .doc(element.id)
                    .delete();
              })
            });
  }

  void DeleteEvent() async {
    await FirebaseFirestore.instance
        .collection("Event")
        .doc(widget.Event.id)
        .delete();
  }
}
