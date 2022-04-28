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
      decoration: BoxDecoration(
        color: Colors.greenAccent[700],
          border: Border.all(color: Colors.black)),
      height: 100,
      child: Row(
        children: [
          const SizedBox(
            width: 40,

          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Homepage()));
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
          const SizedBox(
            width: 1150,
          ),
          // ignore: deprecated_member_use
          ElevatedButton(
              onPressed: () {
                  GetStorage box = GetStorage();
                  box.remove('email');
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Color.fromARGB(255, 14, 10, 0), fontSize: 15),
                
              ),
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 224, 229, 227)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: const BorderSide(color: Colors.black)
              
              )
              ),
              )
          )
        ],
      ),

    );
  }
}
