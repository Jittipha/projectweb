
// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projectweb/widget/navigator.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Container(
            padding: const EdgeInsets.all(60),
            child: ScreenTypeLayout(
              desktop: Builddesktop(),
              tablet: Buildtablet(),
              mobile: Buildmobile(),
            )));
  }

  Widget Builddesktop() => Column(
        children: [Navigatorbar(),
         Text("listevent of desktop")],
      );
  Widget Buildmobile() => Column(
        children: [Navigatorbar(),Text("listevent of desktop mobile")],
      );
  Widget Buildtablet() => Column(
        children: [Navigatorbar(),Text("listevent of desktop tablet")],
      );
}
