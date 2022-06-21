// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectweb/DetailCate.dart';
import 'package:projectweb/widget/navigator.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ApprovedCate extends StatefulWidget {
  const ApprovedCate({Key? key}) : super(key: key);

  @override
  State<ApprovedCate> createState() => _ApprovedCateState();
}

class _ApprovedCateState extends State<ApprovedCate> {
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
        await FirebaseFirestore.instance.collection("PreCategories").get();
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
              desktop: Builddesktop(context),
              tablet: Buildtablet(),
              mobile: Buildmobile(),
            )));
  }

  Widget Builddesktop(BuildContext context) => SingleChildScrollView(
          child: Column(
        children: [
          const Navigatorbar(),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "CATEGORIES",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          
         Container(
          height: height,
          width: 600,
          child:
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("PreCategories")
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
                      children: snapshot.data!.docs.map((PreCate) {
           
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
                              NetworkImage(PreCate['Image']),
                          radius: 23,
                        ),
                      ),
                      title: Text(
                       PreCate["Name"],
                        style: const TextStyle(fontSize: 22),
                      ),
                       subtitle: Text(
                          PreCate["Description"],
                          style: const TextStyle(fontSize: 16),
                          maxLines: 1,
                        ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailcate(
                                    Precate: PreCate)));
                      },
                  
                    ),
                  ),
                );
           }).toList()); } } )),
        
      
          // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Color.fromARGB(255, 96, 177, 162),
          //   ),
          //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          //   height: height,
          //   width: 700,
          //   child: StreamBuilder(
          //     stream: FirebaseFirestore.instance
          //         .collection("PreCategories")
          //         .orderBy('Name', descending: true)
          //         .limit(limit)
          //         .snapshots(),
          //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       } else {
          //         return ListView(
          //             children: snapshot.data!.docs.map((PreCate) {
          //           return Container(
          //             padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          //             child: ListTile(
          //               // trailing: Row(
          //               //   children: [
          //               //   //  GestureDetector(
          //               //   //    child: const CircleAvatar(
          //               //   //      radius: 30,
          //               //   //      backgroundColor: Colors.white,
          //               //   //      child: Icon(
          //               //   //        Icons.check_circle_outline_outlined,
          //               //   //        size: 25,
          //               //   //      ),
          //               //   //    )
          //               //   //  )
          //               //   ],
          //               // ),
          //               // trailing: Wrap(
          //               //   spacing: 12, // space between two icons
          //               //   children: <Widget>[
          //               //     GestureDetector(
          //               //         child: const CircleAvatar(
          //               //       radius: 30,
          //               //       backgroundColor: Colors.greenAccent,
          //               //       child: Icon(
          //               //         Icons.check_circle_outline_outlined,
          //               //         size: 60,
          //               //       ),
          //               //     )),
          //               //     GestureDetector(
          //               //         child: const CircleAvatar(
          //               //       radius: 28,
          //               //       backgroundColor: Colors.redAccent,
          //               //       child: Icon(
          //               //         Icons.close_rounded,
          //               //         size: 56,
          //               //       ),
          //               //     )), // icon-2
          //               //   ],
          //               // ),

          //               leading: CircleAvatar(
          //                 backgroundColor: Colors.black,
          //                 radius: 55,
          //                 child: CircleAvatar(
          //                   backgroundImage: NetworkImage(PreCate["Image"]),
          //                   radius: 23,
          //                 ),
          //               ),
          //               title: Text(
          //                 PreCate["Name"],
          //                 style: const TextStyle(fontSize: 22),
          //               ),
          //               subtitle: Text(
          //                 PreCate["Description"],
          //                 style: const TextStyle(fontSize: 16),
          //                 maxLines: 1,
          //               ),
          //               onTap: () {
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) =>
          //                             detailcate(Precate: PreCate)));
          //               },
          //             ),
          //           );
          //         }).toList());
          //       }
          //     },
          //   ),
          // ),
          Container(
              child: Length > 7
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
        
      ]));

  Widget Buildtablet() => const Center(
          child: Text(
        "โปรดขยายหน้าจอ",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ));

  Widget Buildmobile() => const Center(
          child: Text(
        "โปรดขยายหน้าจอ !!",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ));
}
