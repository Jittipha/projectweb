// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:projectweb/widget/navigator.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchText = TextEditingController(text: "");
  int length = 0;
  double height = 78;

  // TextEditingController _searchController = TextEditingController();

  // Future? resultsLoaded;
  // List _allResults = [];
  // List _resultsList = [];
  // Events events = Events();

  // @override
  // void initState() {
  //   super.initState();
  //   _searchController.addListener(_onSearchChanged);
  // }

  // @override
  // void dispose() {
  //   _searchController.removeListener(_onSearchChanged);
  //   _searchController.dispose();
  //   super.dispose();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   resultsLoaded = getUsersPastTripsStreamSnapshots();
  // }

  // _onSearchChanged() {
  //   searchResultsList();
  // }

  // searchResultsList() {
  //   var showResults = [];
  //   var data =  FirebaseFirestore.instance.collection('Event').doc().get().then((value) => {
  //         setState(() {
  //           events.Image = value.data()?["Image"];

  //           events.Date = value.data()?["Name"];
  //         }),
  //       });

  //   if (_searchController.text != "") {
  //     for (var tripSnapshot in _allResults) {
  //       var title = data.title.toLowerCase();

  //       if (title.contains(_searchController.text.toLowerCase())) {
  //         showResults.add(tripSnapshot);
  //       }
  //     }
  //   } else {
  //     showResults = List.from(_allResults);
  //   }
  //   setState(() {
  //     _resultsList = showResults;
  //   });
  // }

  // getUsersPastTripsStreamSnapshots() async {
  //   var data = await FirebaseFirestore.instance.collection('userData').get();

  //   setState(() {
  //     _allResults = data.docs;
  //   });
  //   searchResultsList();
  //   return "complete";
  // }

  @override
  void initState() {
    super.initState();
    getheightforlength();
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
        // const Text("Past Trips", style: TextStyle(fontSize: 20)),
        // Padding(
        //   padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
        //   child: TextField(
        //     controller: _searchController,
        //     decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
        //   ),
        // ),
        // Expanded(
        //     child: ListView.builder(
        //   itemCount: _resultsList.length,
        //   itemBuilder: (BuildContext context, int index) =>
        //       buildTripCard(context, _resultsList[index]),
        // )),

        const Navigatorbar(),
        const SizedBox(
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             detailstudent(student: Student)));
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
