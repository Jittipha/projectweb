import 'package:flutter/material.dart';
import 'package:projectweb/ApproveCategories.dart';
import 'package:projectweb/Home.dart';
import 'package:projectweb/liststudents.dart';

class Navigatorbar extends StatelessWidget {
  const Navigatorbar({Key? key}) : super(key: key);

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
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
              )),
        ],
      ),
    );
  }
}
