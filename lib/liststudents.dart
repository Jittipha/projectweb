// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        body: Container(
            padding: const EdgeInsets.all(30),
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
            height: 70,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            height: 700,
            color: Colors.greenAccent,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Student").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                      children: snapshot.data!.docs.map((Student) {
                    return Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(Student["Photo"]),
                            radius: 25,
                          ),
                        ),
                        title: Text(
                          Student["Name"],
                          style: const TextStyle(fontSize: 20),
                        ),
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
