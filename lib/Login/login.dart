// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, prefer_is_empty, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:projectweb/Home.dart';
import 'package:projectweb/Model/Admin.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  Admin admin = Admin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 219, 236, 225),
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20.0),
          ),
          width: 400.0,
          height: 400.0,
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Login Admin",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 0, 7, 4)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                emailFormField(),
                const SizedBox(
                  height: 20.0,
                ),
                passwordFormField(),
                const SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  width: 400,
                  height: 30,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();

                          QuerySnapshot CheckAdmin = await FirebaseFirestore
                              .instance
                              .collection("Admin")
                              .where("Email", isEqualTo: admin.Email)
                              .where("Password", isEqualTo: admin.password)
                              .get();
                          if (CheckAdmin.docs.length == 0) {
                            showAlertDialog(context);
                            formkey.currentState!.reset();
                          } else {
                            //เก็บค่าEmailที่มีอยู่ไปทุกๆหน้า
                            // GetStorage box = GetStorage();
                            // box.write('email', admin.Email);

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const Homepage()));
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromARGB(255, 247, 241, 241),
                            fontSize: 18),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 70, 107, 85)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side:
                                        const BorderSide(color: Colors.black))),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget OKButton = FlatButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context, 'Cancel');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Warning!!"),
      content: const Text("Email และ Password ของคุณไม่ถูกต้อง"),
      actions: [OKButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget emailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "Enter email",
          icon: const Icon(
            Icons.email,
            color: Colors.black,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
      validator: (value) {
        if (!validateREmail(value!)) {
          return 'อีเมลล์ไม่ถูกต้อง';
        }
        return null;
      },
      onSaved: (value) {
        admin.Email = value;
      },
    );
  }

  Widget passwordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "password",
          hintText: "Enter password",
          icon: const Icon(Icons.lock, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
      validator: (value) {
        if (!validateRpass(value!)) {
          return 'กรอกรหัสผ่านอย่างน้อย 7 ตัวเลข';
        }
        return null;
      },
      onSaved: (value) {
        admin.password = value;
      },
    );
  }

  bool validateREmail(String value) {
    RegExp regex = RegExp(r'[a-z]+@[a-z]+\.[a-z]{2,3}');
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool validateRpass(String value) {
    RegExp regexs = RegExp(r'[0-9]{6}');
    //RegExp regexs = RegExp(r'[A-Z0-9a-z]{8}');
    return (!regexs.hasMatch(value)) ? false : true;
  }
}
