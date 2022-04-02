import 'dart:html';

import 'package:flutter/material.dart';

class Navigatorbar extends StatefulWidget {
  const Navigatorbar({Key? key}) : super(key: key);

  @override
  State<Navigatorbar> createState() => _NavigatorbarState();
}

class _NavigatorbarState extends State<Navigatorbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.lightGreen,
      child: Row(
        children: [
          TextButton(onPressed: () {}, child: const Text("โพสต์กิจกรรม")),
          TextButton(onPressed: () {}, child: const Text("นักศีกษา")),
          TextButton(onPressed: () {}, child: const Text("ตรวจสอบหมวดหมู่")),
        ],
      ),
    );
  }
}
