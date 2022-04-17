import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchText = TextEditingController(text: "");
  List<AlgoliaObjectSnapshot> _results = [];
  bool _searching = false;

  _search() async {
    setState(() {
      _searching = true;
    });

    Algolia algolia = Algolia.init(
      applicationId: 'ZO4XKCM05Q',
      apiKey: 'b57d151dcd4821d1df6a23485e70ec2d',
    );

    AlgoliaQuery query = algolia.instance.index('Event');
    query = query.search(_searchText.text);

    _results = (await query.getObjects()).hits;

    setState(() {
      _searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Search'),
           backgroundColor: const Color(0xFF00BF6D),
        ),
      body: Container(
        // padding: const EdgeInsets.fromLTRB(15, 75, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _searchText,
              decoration: InputDecoration(hintText: "Search....."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  color: Colors.blue,
                  child: Text(
                    "Search",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  onPressed: _search,
                ),
              ],
            ),
            Expanded(
              child: _searching == true
                  ? Center(
                      child: Text(
                        "Searching, please wait...",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : _results.length == 0
                      ? Center(
                          child: Text(
                            "No results found.",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _results.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            AlgoliaObjectSnapshot snap = _results[index];

                            return Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 15, 10, 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                child: InkWell(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection("Student")
                                        .doc(FirebaseAuth
                                            .instance.currentUser?.uid)
                                        .collection("Posts")
                                        .where("Event_id",
                                            isEqualTo: snap.objectID)
                                        .get()
                                        .then((value) async => {
                                              if (value.docs.length == 0)
                                                {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("Event")
                                                      .doc(snap.objectID)
                                                      .collection("Joined")
                                                      .where("Student_id",
                                                          isEqualTo:
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser
                                                                  ?.uid)
                                                      .get()
                                                      .then((docsnapshot) => {
                                                            // ignore: avoid_print
                                                            print(docsnapshot
                                                                .docs.length),
                                                            if (docsnapshot.docs
                                                                    .length ==
                                                                0)
                                                              // ignore: avoid_print
                                                              {
                                                                // print(
                                                                //     "dont have"),
                                                                // Navigator.push(
                                                                //     context,
                                                                //     MaterialPageRoute(
                                                                //         builder:
                                                                //             (context) =>
                                                                //                 eventdetail(snap: snap)))
                                                              }
                                                            else
                                                              // ignore: avoid_print
                                                              {
                                                                // print("had"),
                                                                // Navigator.push(
                                                                //     context,
                                                                //     MaterialPageRoute(
                                                                //         builder:
                                                                //             (context) =>
                                                                //                 Leaveevent(snap: snap)))
                                                              }
                                                          })
                                                }
                                              else
                                                {print("Your Event")}
                                            });
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                        ),
                                        child: Image.network(snap.data["Image"],
                                            width: 300,
                                            height: 150,
                                            fit: BoxFit.fill),
                                      ),
                                      ListTile(
                                        title: Text(snap.data["Name"],
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}