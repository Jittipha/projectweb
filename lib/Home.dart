import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projectweb/DetailEvent.dart';
import 'package:projectweb/Login/login.dart';
import 'package:projectweb/liststudents.dart';
import 'package:projectweb/widget/navigator.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get_storage/get_storage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int length = 0;
  double height = 78;
  GetStorage box = GetStorage();
  @override
  void initState() {
    super.initState();
    print(box.read('email'));
    
    // if (box.read('email') == null) {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => const Login()));
    // }
    getheightforlength();
  }

  // Future<void> checkloginValue() async {

  //   if (box.read('email') != null) {
  //     print("NEXT");
  //   } else {

  //   }
  // }

  Future<void> getheightforlength() async {
    length = await getArrayLength();
    if (length > 7) {
      height = height * 7;
    } else {
      height = length * height;
    }
    setState(() {});
  }

  Future<int> getArrayLength() async {
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
              desktop: buildDesktop(),
              tablet: buildTablet(),
              mobile: buildMobile(),
            )));
  }

  Widget buildDesktop() => Column(children: [
        const Navigatorbar(),
        SizedBox(
          height: 60,
        ),
        // const SearchBar(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.greenAccent[400],
          ),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          height: height,
          width: 650,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Event').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                    children: snapshots.data!.docs.map((event) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 55,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(event["Image"]),
                          radius: 23,
                        ),
                      ),
                      title: Text(
                        event["Name"],
                        style: const TextStyle(fontSize: 22),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    datailEvent(Event: event)));
                      },
                    ),
                  );
                }).toList());
              }
            },
          ),
        )
      ]);

  Widget buildMobile() => Column(
        children: [Text("listevent of desktop mobile")],
      );
  Widget buildTablet() => Column(
        children: [Text("listevent of desktop tablet")],
      );
}
