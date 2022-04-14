// import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectweb/Detailstudent.dart';
import 'package:projectweb/widget/navigator.dart';
import 'package:responsive_builder/responsive_builder.dart';

class liststudent extends StatefulWidget {
  const liststudent({Key? key}) : super(key: key);

  @override
  State<liststudent> createState() => _liststudentState();
}

class _liststudentState extends State<liststudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Container(
            padding: const EdgeInsets.all(60),
            child: ScreenTypeLayout(
              desktop: Builddesktop(),
              tablet: Buildtablet(),
              mobile: Buildmobile(),
            )));
  }

  Widget Builddesktop() => Column(
        children: [
          const Navigatorbar(),
          const SizedBox(
            height: 60,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            height: 500,
            width: 700,
            color: Colors.greenAccent[400],
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Student")
                  .orderBy('Name', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                      children: snapshot.data!.docs.map((Student) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: ListTile(
                        // trailing: const Card(
                        //     child: InkWell(
                        //       onTap:() {

                        //       },
                        //   child:
                        //   Text("ลบผู้ใช้งาน"),
                        // )),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 55,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(Student["Photo"]),
                            radius: 20,
                          ),
                        ),
                        title: Text(
                          Student["Name"],
                          style: const TextStyle(fontSize: 22),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      detailstudent(student: Student)));
                        },
                      ),
                    );
                  }).toList());
                }
              },
            ),
          )
        ],
      );
  Widget Buildmobile() => Column(
        children: [Text("liststudent of  mobile")],
      );
  Widget Buildtablet() => Column(
        children: [Text("liststudent of  tablet")],
      );
}
