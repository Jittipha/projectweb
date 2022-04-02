import 'package:flutter/material.dart';
import 'package:projectweb/widget/navigator.dart';
import 'package:responsive_builder/responsive_builder.dart';


class liststudent extends StatefulWidget {
  const liststudent({Key? key}) : super(key: key);

  @override
  State<liststudent> createState() => _liststudentState();
}

class _liststudentState extends State<liststudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(30),
            child: ScreenTypeLayout(
              desktop: Builddesktop(),
              tablet: Buildtablet(),
              mobile: Buildmobile(),
            )));
  }

  Widget Builddesktop() => Column(
        children: [Navigatorbar(), Text("listevent of desktop")],
      );
  Widget Buildmobile() => Column(
        children: [Text("listevent of desktop mobile")],
      );
  Widget Buildtablet() => Column(
        children: [Text("listevent of desktop tablet")],
      );
}
