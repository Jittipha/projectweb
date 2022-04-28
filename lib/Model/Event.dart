import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Event {
  String? name;

  Event({this.name});

  Event.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot['Name'];
  }
}
