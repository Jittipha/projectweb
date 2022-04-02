import 'package:flutter/material.dart';
import 'package:projectweb/Home.dart';
import 'package:projectweb/liststudents.dart';

class Navigatorbar extends StatelessWidget {
  const Navigatorbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      height: 100,
      color: Colors.greenAccent,
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
                style: TextStyle(color: Colors.black, fontSize: 18),
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
                "นักศีกษา",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
          const SizedBox(
            width: 40,
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                "ตรวจสอบหมวดหมู่",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
        ],
      ),
    );
  }
}
