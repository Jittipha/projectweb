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
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // ignore: prefer_final_fields
  TextEditingController _searchController = TextEditingController();
  int length = 0;
  double height = 78;
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

   
    getheightforlength();
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
        await FirebaseFirestore.instance.collection("Event").get();
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
                prefixIcon: Icon(Icons.search),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: OutlineInputBorder(),
                labelText: 'Search.....',
                hintText: "Enter your Eventname"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.greenAccent[400],
            ),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            height: height,
            width: 650,
            child: ListView.builder(
                itemCount: _resultList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
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
                      title: Text(
                        _resultList[index]["Name"],
                        style: const TextStyle(fontSize: 22),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    datailEvent(Event: _resultList[index])));
                      },
                    ),
                  );
                }))
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
}
