// ignore_for_file: deprecated_member_use, file_names, must_be_immutable, camel_case_types, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, duplicate_ignore, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectweb/Background/Bg-login.dart';
import 'package:projectweb/liststudents.dart';
import 'package:responsive_builder/responsive_builder.dart';

class detailstudent extends StatefulWidget {
  detailstudent({Key? key, required this.student}) : super(key: key);
  QueryDocumentSnapshot student;

  @override
  State<detailstudent> createState() => _detailstudentState();
}

class _detailstudentState extends State<detailstudent> {
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

  // ignore: non_constant_identifier_names
  Widget Builddesktop(BuildContext context) => Row(children: [
        Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            width: MediaQuery.of(context).size.width * 0.40,
            height: 400,
            child: Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                    radius: 250,
                    // backgroundColor: const Color.fromARGB(255, 8, 8, 8),
                    child: CircleAvatar(
                      radius: 185,
                      backgroundImage: NetworkImage(widget.student["Photo"]),
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
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name   :   " + widget.student["Name"],
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 35,
                      )),
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email   :   " + widget.student["Email"],
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 22,
                      )),
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Posts",
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  // height: 200,
                  // color: Colors.white,
                  child: Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Student")
                            .doc(widget.student.id)
                            .collection("Posts")
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SingleChildScrollView(
                              child: CircularProgressIndicator(),
                            );
                            // ignore: prefer_is_empty
                          } else if (snapshot.data?.docs.length == 0) {
                            return Center(
                                // padding: const EdgeInsets.fromLTRB(0, 50, 50, 0),
                                child: const Text(
                              "NOT HAVE EVENT.",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w300),
                            ));
                          } else {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs
                                  // ignore: non_constant_identifier_names
                                  .map((Postofstudent) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                              Colors.lightBlueAccent[100],
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                Postofstudent["Image"]),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          Postofstudent["Name"],
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                            fontSize: 15,
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        }),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(60, 10, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                    // textScaleFactor: 2,
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
    Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () async {
          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection("Student")
              .doc(widget.student.id)
              .collection("Joined")
              .get();
          snap.docs.forEach((data) async {
            await FirebaseFirestore.instance
                .collection("Event")
                .doc(data.id)
                .collection("Joined")
                .doc(widget.student.id)
                .delete();
          });
          DeleteNoti();
          DeleteContainStudent();
          DeleteComment();
          DeleteStudent();
          Navigator.pop(context);
          Navigator.pop(context);
          await Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new liststudent()),
          );

          // Navigator.push(
          //   context,
          //   new MaterialPageRoute(builder: (context) => new liststudent()),
          // );
          // Navigator.pop(context);
        });

    Widget cancleButton = FlatButton(
      child: const Text("CANCLE"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Student!"),
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
  void DeleteNoti() async {
    QuerySnapshot snapNoti = await FirebaseFirestore.instance
        .collection("Notification")
        .where("Student_id", arrayContainsAny: [widget.student.id]).get();
    snapNoti.docs.forEach((doc) async {
      await FirebaseFirestore.instance
          .collection("Notification")
          .doc(doc.id)
          .update({
        'Student_id': FieldValue.arrayRemove([widget.student.id])
      });
    });
  }

  // ignore: non_constant_identifier_names
  void DeleteContainStudent() async {
    QuerySnapshot snapcolCate = await FirebaseFirestore.instance
        .collection("Student")
        .doc(widget.student.id)
        .collection("Categories")
        .get();
    snapcolCate.docs.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("Student")
          .doc(widget.student.id)
          .collection("Categories")
          .doc(element.id)
          .delete();
    });
    QuerySnapshot snapcolJoin = await FirebaseFirestore.instance
        .collection("Student")
        .doc(widget.student.id)
        .collection("Joined")
        .get();
    snapcolJoin.docs.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("Student")
          .doc(widget.student.id)
          .collection("Joined")
          .doc(element.id)
          .delete();
    });
    QuerySnapshot snapcolPosts = await FirebaseFirestore.instance
        .collection("Student")
        .doc(widget.student.id)
        .collection("Posts")
        .get();
    snapcolPosts.docs.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("Student")
          .doc(widget.student.id)
          .collection("Posts")
          .doc(element.id)
          .delete();
    });
  }

  // ignore: non_constant_identifier_names
  void DeleteComment() async {
    await FirebaseFirestore.instance
        .collection("Comment")
        .where("sId", isEqualTo: widget.student.id)
        .get()
        .then((value) => {
              value.docs.forEach((element) async {
                await FirebaseFirestore.instance
                    .collection("Comment")
                    .doc(element.id)
                    .delete();
              })
            });
  }

  void DeleteStudent() async {
    await FirebaseFirestore.instance
        .collection("Student")
        .doc(widget.student.id)
        .delete();
  }
}
