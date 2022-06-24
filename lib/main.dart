// ignore_for_file: unused_import

import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectweb/ApproveCategories.dart';
import 'package:projectweb/DetailCate.dart';
import 'package:projectweb/Home.dart';
import 'package:projectweb/Login/login.dart';
import 'package:projectweb/liststudents.dart';
import 'package:projectweb/widget/navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDPoI2XRDn0ySr15I39mbZPsNzc6bdSJpM",
          authDomain: "my-project-application-7b7c7.firebaseapp.com",
          databaseURL:
              "https://my-project-application-7b7c7-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "my-project-application-7b7c7",
          storageBucket: "my-project-application-7b7c7.appspot.com",
          messagingSenderId: "570872108130",
          appId: "1:570872108130:web:3f073baa7442a567a46d3b",
          measurementId: "G-SEC920EMMD"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  Login(),
    );
  }
}
