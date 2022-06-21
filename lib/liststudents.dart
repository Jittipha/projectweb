// import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:projectweb/Home.dart';

import 'package:projectweb/Model/Student.dart';
import 'package:projectweb/widget/navigator.dart';

import 'package:responsive_builder/responsive_builder.dart';

import 'Detailstudent.dart';

class liststudent extends StatefulWidget {
  const liststudent({Key? key}) : super(key: key);

  @override
  State<liststudent> createState() => _liststudentState();
}

class _liststudentState extends State<liststudent> {
  // ignore: prefer_final_fields
  TextEditingController _searchController = TextEditingController();
  GetStorage box = GetStorage();
  int finaldata = 0;
  int stagelimit = 0;
  int limit = 7;
  int length = 0;
  double height = 77;
  late Future resultsLoaded;
  List _allresult = [];
  List _resultList = [];
  @override
  void initState() {
    super.initState();
    Getdata();
    getheightforlength();
    _searchController.addListener((_onSearchChanged));
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = Getdata();
  }

  Getdata() async {
    var data = await FirebaseFirestore.instance
        .collection("Student")
        .orderBy('Name', descending: true)
        .get();
    setState(() {
      _allresult = data.docs;
    });
    searchResultList();
    return "complete";
  }

  _onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResult = [];
    if (_searchController.text != "") {
      for (var Snapshot in _allresult) {
        var name = Student.fromSnapshot(Snapshot).name!.toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResult.add(Snapshot);
        }
      }
    } else {
      showResult = List.from(_allresult);
    }
    setState(() {
      _resultList = showResult;
    });
  }

  // Future<void> addheight(int lengthresult) async {
  //   print(limit);
  //   print(height);
  //   if (Length - limit >= 0) {
  //     height = height + 390;
  //   } else if (Length - limit < 0) {
  //     int a = 5 - (limit - Length);
  //     print(a);
  //     int sum = 77 * a;
  //     height = height + sum;
  //     finaldata = 2;
  //   }
  //   print(height);
  // }

  Future<void> getheightforlength() async {
    length = await getArrayLength();
    if (length > 7) {
      height = height * 7;
    } else {
      height = length * height;
    }
    setState(() {});
    // Length = await GetArrayLength();
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
           height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1651147538420-06f5e0d3f1d9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                  fit: BoxFit.cover),
            ),
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
        height: 30,
      ),
      const Text(
        "STUDENTS",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 15,
      ),
      SizedBox(
        width: 550,
        child: TextField(
          cursorHeight: 10,
          autofocus: false,
          controller: _searchController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              labelText: 'Search.....',
              hintText: "Enter your Studentname"),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Expanded(
        child: Container(
          height: 10,
          width: 600,
          child: ListView.builder(
              itemCount: _resultList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 55,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(_resultList[index]['Photo']),
                          radius: 23,
                        ),
                      ),
                      title: Text(
                        _resultList[index]["Name"],
                        style: const TextStyle(fontSize: 22),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailstudent(
                                    student: _resultList[index])));
                      },
                      trailing: GestureDetector(
                        onTap: () => {showAlertDialog(context, index)},
                        child: Icon(
                          Icons.delete,
                          size: 35,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
      // Container(
      //     child: Length > 7
      //         ? ListTile(
      //             title: const Text(
      //               "See more..",
      //               style: TextStyle(fontSize: 20),
      //               textAlign: TextAlign.center,
      //             ),
      //             onTap: () {
      //               setState(() {
      //                 stagelimit = 1;
      //                 limit = limit + 5;
      //                 // addheight(_resultList.length);
      //                 Getdata();
      //               });
      //             },
      //           )
      //         : Container()),
    ],
  );
  Widget Buildmobile() => Center(
          child: Text(
        "โปรดขยายหน้าจอ !!",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ));
  Widget Buildtablet() => Center(
          child: Text(
        "โปรดขยายหน้าจอ !!",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ));

  showAlertDialog(context, index) {
    QueryDocumentSnapshot student = _resultList[index];
    // set up the button
    Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () async {
          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection("Student")
              .doc(student.id)
              .collection("Joined")
              .get();
          snap.docs.forEach((data) async {
            await FirebaseFirestore.instance
                .collection("Event")
                .doc(data.id)
                .collection("Joined")
                .doc(student.id)
                .delete();
          });
          DeleteNoti(student);
          DeleteContainStudent(student);
          DeleteComment(student);
          DeleteStudent(student);
          _resultList.remove(_resultList[index]);
          Navigator.pop(context);
          setState(() {});

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
  void DeleteNoti(student) async {
    QuerySnapshot snapNoti = await FirebaseFirestore.instance
        .collection("Notification")
        .where("Student_id", arrayContainsAny: [student.id]).get();
    snapNoti.docs.forEach((doc) async {
      await FirebaseFirestore.instance
          .collection("Notification")
          .doc(doc.id)
          .update({
        'Student_id': FieldValue.arrayRemove([student.id])
      });
    });
  }

  // ignore: non_constant_identifier_names
  void DeleteContainStudent(student) async {
    QuerySnapshot snapcolCate = await FirebaseFirestore.instance
        .collection("Student")
        .doc(student.id)
        .collection("Categories")
        .get();
    snapcolCate.docs.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("Student")
          .doc(student.id)
          .collection("Categories")
          .doc(element.id)
          .delete();
    });
    QuerySnapshot snapcolJoin = await FirebaseFirestore.instance
        .collection("Student")
        .doc(student.id)
        .collection("Joined")
        .get();
    snapcolJoin.docs.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("Student")
          .doc(student.id)
          .collection("Joined")
          .doc(element.id)
          .delete();
    });
    QuerySnapshot snapcolPosts = await FirebaseFirestore.instance
        .collection("Student")
        .doc(student.id)
        .collection("Posts")
        .get();
    snapcolPosts.docs.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("Student")
          .doc(student.id)
          .collection("Posts")
          .doc(element.id)
          .delete();
    });
  }

  // ignore: non_constant_identifier_names
  void DeleteComment(student) async {
    await FirebaseFirestore.instance
        .collection("Comment")
        .where("sId", isEqualTo: student.id)
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

  void DeleteStudent(student) async {
    await FirebaseFirestore.instance
        .collection("Student")
        .doc(student.id)
        .delete();
  }
}
