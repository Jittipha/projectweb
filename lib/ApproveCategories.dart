import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectweb/widget/navigator.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ApprovedCate extends StatefulWidget {
  const ApprovedCate({Key? key}) : super(key: key);

  @override
  State<ApprovedCate> createState() => _ApprovedCateState();
}

class _ApprovedCateState extends State<ApprovedCate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Container(
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.greenAccent[400],
            ),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            height: 550,
            width: 850,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("PreCategories")
                  .orderBy('Name', descending: true)
                  .limit(10)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                      children: snapshot.data!.docs.map((PreCate) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: ListTile(
                        // trailing: Row(
                        //   children: [
                        //   //  GestureDetector(
                        //   //    child: const CircleAvatar(
                        //   //      radius: 30,
                        //   //      backgroundColor: Colors.white,
                        //   //      child: Icon(
                        //   //        Icons.check_circle_outline_outlined,
                        //   //        size: 25,
                        //   //      ),
                        //   //    )
                        //   //  )
                        //   ],
                        // ),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            GestureDetector(
                                child: const CircleAvatar(
                              radius: 30,
                              backgroundColor:  Colors.greenAccent,
                              child: Icon(
                                Icons.check_circle_outline_outlined,
                                size: 60,
                              ),
                            )),
                            GestureDetector(
                                child: const CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.close_rounded,
                                size: 56,
                              ),
                            )), // icon-2
                          ],
                        ),

                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 55,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(PreCate["Image"]),
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
          ),
          ListTile(
            title: const Text(
              "See more..",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              setState(() {});
            },
          ),
        ],
      ));

  Widget Buildtablet() => Column();

  Widget Buildmobile() => Column();
}
