import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Student {
  String? name;

  Student({this.name});

  Student.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot['Name'];
  }
}
