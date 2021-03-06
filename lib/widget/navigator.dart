import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:projectweb/ApproveCategories.dart';
import 'package:projectweb/Home.dart';
import 'package:projectweb/Login/login.dart';
import 'package:projectweb/liststudents.dart';

class Navigatorbar extends StatefulWidget {
  const Navigatorbar({Key? key}) : super(key: key);

  @override
  State<Navigatorbar> createState() => _NavigatorbarState();
}

class _NavigatorbarState extends State<Navigatorbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            // color: Color.fromARGB(255, 183, 181, 181),
            child:  RaisedButton(
                color: Colors.white60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Homepage()));
                },
                child: const Text(
                  "โพสต์กิจกรรม",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 22),
                )),
          ),
          SizedBox(
            width: 10
          ),
          //     const SizedBox(
          //   width: 40,
          // ),
          Container(
            // color: Color.fromARGB(255, 183, 181, 181),
            // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            // width: MediaQuery.of(context).size.width * 0.2,
            child: RaisedButton(
                color: Colors.white60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),),
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
          ),
           SizedBox(
            width: 10
          ),
          // const SizedBox(
          //   width: 40,
          // ),
          Container(
            // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            // width: MediaQuery.of(context).size.width * 0.2,
            child: RaisedButton(
                color: Colors.white60,
                 shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ApprovedCate()));
                },
                child: const Text(
                  "ตรวจสอบหมวดหมู่",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      
                      fontWeight: FontWeight.w400),
                )),
          ),
           SizedBox(
            width: 10
          ),
          Container(
              // width: MediaQuery.of(context).size.width * 0.15,
              ),
          // ignore: deprecated_member_use
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            // width: MediaQuery.of(context).size.width * 0.10,

            child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 24.0,
                ),
                onPressed: () {
                  GetStorage box = GetStorage();
                  box.remove('email');
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                label: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Color.fromARGB(255, 14, 10, 0), fontSize: 18),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 224, 229, 227)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          side: const BorderSide(color: Colors.black))),
                )),
          ),
        ],
      ),
    );
  }
}
