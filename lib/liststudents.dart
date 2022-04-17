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
  int finaldata = 0;
  int stagelimit = 0;
  int limit = 7;
  int Length = 0;
  double height = 77 * 7;
  @override
  void initState() {
    super.initState();
    getheightforlength();
  }

  Future<void> addheight() async {
    print(limit);
    print(height);
    if (Length - limit >= 0) {
      height = height + 390;
    } else if (Length - limit < 0) {
      int a = 5 - (limit - Length);
      print(a);
      int sum = 77 * a;
      height = height + sum;
      finaldata = 2;
    }
    print(height);
  }

  Future<void> getheightforlength() async {
    Length = await GetArrayLength();
  }

  Future<int> GetArrayLength() async {
    QuerySnapshot snaps =
        await FirebaseFirestore.instance.collection("Student").get();
    return snaps.docs.length;
  }

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
  Widget Builddesktop() => SingleChildScrollView(
          child: Column(
        children: [
          const Navigatorbar(),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "STUDENTS",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.greenAccent[400],
            ),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            height: height,
            width: 650,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Student")
                  .orderBy('Name', descending: true)
                  .limit(limit)
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
                          backgroundColor: Colors.black,
                          radius: 55,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(Student["Photo"]),
                            radius: 23,
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
          ),
          Container(
              child: finaldata == 0
                  ? ListTile(
                      title: const Text(
                        "See more..",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        setState(() {
                          stagelimit = 1;
                          limit = limit + 5;
                          addheight();
                        });
                      },
                    )
                  : Container()),
        ],
      ));
  Widget Buildmobile() => Column(
        children: [Text("liststudent of  mobile")],
      );
  Widget Buildtablet() => Column(
        children: [Text("liststudent of  tablet")],
      );
}
