import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projectweb/DetailEvent.dart';
import 'package:projectweb/Login/login.dart';
import 'package:projectweb/liststudents.dart';
import 'package:projectweb/widget/navigator.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get_storage/get_storage.dart';

import 'Model/Event.dart';

class Homepage extends StatefulWidget {
  Homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // ignore: prefer_final_fields
  TextEditingController _searchController = TextEditingController();
  int length = 0;
  double height = 70 * 7;
  GetStorage box = GetStorage();
  //ลิสทั้งหมดที่มัี
  List _allresult = [];
  //ลิสที่ค้นหาได้
  List _resultList = [];
  late Future resultsLoaded;
  //เม็ดตอธทำงานก่อน widget build
  @override
  void initState() {
    super.initState();
    print(box.read('email'));

    // getheightforlength();
    _searchController.addListener((_onSearchChanged));
  }

//เม็ดตอธทำงานก่อน widget build
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

//เม็ดตอธทำงานก่อน widget build
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //resultloaded เท่ากันค่าที่เม็ดตอธ getdata return มา
    //ซึ่งเท่ากับ complete
    resultsLoaded = Getdata();
  }

//ดึงข้อมูลทั้งหมดมาเก็บใน allresult
  Getdata() async {
    var data = await FirebaseFirestore.instance
        .collection('Event')
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
    //ในกล่อง Search มีค่า?
    if (_searchController.text != "") {
      for (var Snapshot in _allresult) {
        var name = Event.fromSnapshot(Snapshot).name!.toLowerCase();
        //เช็คตัวแปร Name ของ event ทั้งหมดว่ามีส่วนประกอยของข้อความที่ใส่ไปรึป่าว
        //เช่น ในtext คือ p แล้วเอา p ไปเช็คกับชื่อ event ทั้งหมด
        if (name.contains(_searchController.text.toLowerCase())) {
          showResult.add(Snapshot);
        }
      }
      //ในกล่อง Search ไม่ได้ใส่อะไร
    } else {
      //ให้ showresult เท่ากับ allresult คือ ถ้าไม่มีค่าในกล่อง search ให้โชว์event ทั้งหมด
      showResult = List.from(_allresult);
    }
    setState(() {
      //เอาค่าที่ได้มาใส่ใน resultlist
      _resultList = showResult;
    });
  }

  // Future<void> getheightforlength() async {
  //   length = await getArrayLength();
  //   if (length > 7) {
  //     height = height * 7;
  //   } else {
  //     height = length * height;
  //   }
  //   setState(() {});
  // }

  Future<int> getArrayLength() async {
    QuerySnapshot snaps =
        await FirebaseFirestore.instance.collection("Event").get();
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
              desktop: buildDesktop(),
              tablet: buildTablet(),
              mobile: buildMobile(),
            )));
  }

  Widget buildDesktop() => Column(children: [
        const Navigatorbar(),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "EVENTS",
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
                iconColor: Colors.black,
                prefixIcon: Icon(Icons.search),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                labelText: 'Search.....',
                hintText: "Enter your Eventname"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        // Container(
        //   height: 50,
        //   width: 900,
        //   color: Colors.white,
        // ),

        Expanded(
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.only(
            //     bottomLeft: const Radius.circular(10.0),
            //     bottomRight: const Radius.circular(10.0),
            //   ),
            //   color: Colors.greenAccent,
            // ),
            // padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            // height: height,
            // width: 900,
          child: Container(
          width: 600,
          child: ListView.builder(
              itemCount: _resultList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 55,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(_resultList[index]["Image"]),
                          radius: 23,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      title: Text(
                        _resultList[index]['Name'],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 23),
                      ),
                      subtitle: Text(
                        _resultList[index]['Description'],
                        maxLines: 1,
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: GestureDetector(
                        onTap: () => {showAlertDialog(context, index)},
                        child: Icon(
                          Icons.delete,
                          size: 35,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    datailEvent(Event: _resultList[index])));
                      },
                    ),
                  ),
                );
                // return Container(
                //   decoration: BoxDecoration(
                //     border: Border(
                //       bottom: BorderSide(color: Color.fromARGB(255, 153, 159, 161), width: 0.5),
                //     ),
                //   ),
                //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                //   child: ListTile(
                //     leading: CircleAvatar(
                //       backgroundColor: Colors.black,
                //       radius: 55,
                //       child: CircleAvatar(
                //         backgroundImage:
                //             NetworkImage(_resultList[index]["Image"]),
                //         radius: 23,
                //       ),
                //     ),
                //     title: Text(
                //       _resultList[index]["Name"],
                //       style: const TextStyle(fontSize: 22),
                //     ),
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   datailEvent(Event: _resultList[index])));
                //     },
                //   ),
                // );
              }),
        )),
      ]);

  Widget buildMobile() => Center(
          child: Text(
        "โปรดขยายหน้าจอ !!",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ));
  Widget buildTablet() => Center(
          child: Text(
        "โปรดขยายหน้าจอ !!",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ));

  showAlertDialog(context, index) {
    // set up the button
    // ignore: deprecated_member_use
    QueryDocumentSnapshot Event = _resultList[index];
    Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () async {
          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection("Event")
              .doc(Event.id)
              .collection("Joined")
              .get();
          snap.docs.forEach((data) {
            FirebaseFirestore.instance
                .collection("Event")
                .doc(Event.id)
                .collection("Joined")
                .doc(data.id)
                .delete();
          });
          DeleteNotification(Event);
          DeleteEventInstudentPost(Event);
          DeleteComment(Event);
          DeleteEvent(Event);
          _resultList.remove(_resultList[index]);
          Navigator.pop(context);
          setState(() {});
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
  void DeleteNotification(Event) async {
    await FirebaseFirestore.instance
        .collection("Notification")
        .doc(Event.id)
        .delete();
  }

  // ignore: non_constant_identifier_names
  void DeleteEventInstudentPost(Event) async {
    QuerySnapshot DeleteStudent = await FirebaseFirestore.instance
        .collection("Student")
        .doc(Event["Host"][0]["Student_id"])
        .collection("Posts")
        .where("Event_id", isEqualTo: Event.id)
        .get();
    DeleteStudent.docs.forEach((element) async {
      await FirebaseFirestore.instance
        ..collection("Student")
            .doc(Event["Host"][0]["Student_id"])
            .collection("Posts")
            .doc(element.id)
            .delete();
    });
  }

  // ignore: non_constant_identifier_names
  void DeleteComment(Event) async {
    await FirebaseFirestore.instance
        .collection("Comment")
        .where("eId", isEqualTo: Event.id)
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

  void DeleteEvent(Event) async {
    await FirebaseFirestore.instance.collection("Event").doc(Event.id).delete();
  }
}
