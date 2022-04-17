import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectweb/Home.dart';
import 'package:projectweb/liststudents.dart';

class Navigatorbar extends StatefulWidget {
  const Navigatorbar({Key? key}) : super(key: key);

  @override
  State<Navigatorbar> createState() => _NavigatorbarState();
}

class _NavigatorbarState extends State<Navigatorbar> {
  final TextEditingController _searchText = TextEditingController(text: "");
  List<AlgoliaObjectSnapshot> results = [];
  bool searching = false;
  _search() async {
    setState(() {
      searching = true;
    });

    Algolia algolia = const Algolia.init(
      applicationId: 'ZO4XKCM05Q',
      apiKey: 'b57d151dcd4821d1df6a23485e70ec2d',
    );

    AlgoliaQuery query = algolia.instance.index('Event');
    query = query.search(_searchText.text);

    results = (await query.getObjects()).hits;

    setState(() {
      searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.greenAccent[700],
              border: Border.all(color: Colors.black)),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Homepage()));
                      },
                      child: const Text(
                        "โพสต์กิจกรรม",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 22),
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const liststudent()));
                      },
                      child: const Text(
                        "นักศึกษา",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "ตรวจสอบหมวดหมู่",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      )),
                 
                ],
              ),
            
            ],
          ),
        ),
        Container(width: 650,
          child: TextField(
            controller: _searchText,
            decoration: const InputDecoration(hintText: "Search....."),
          ),
        ),
      ],
    );
  }
}
