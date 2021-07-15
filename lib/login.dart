import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

GlobalKey<FormState> globalformkey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  bool isvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Form(
                key: globalformkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        return val == "admin" ? null : "not valid";
                      },
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: "USERNAME",
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (val) {
                        return val == "password" ? null : "not valid";
                      },
                      obscureText: !isvisible,
                      style: TextStyle(fontSize: 20),
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (v) {
                        if (globalformkey.currentState.validate()) {
                          Get.off(() => Homepage());
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "PASSWORD",
                          suffixIcon: IconButton(
                            icon: Icon(isvisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isvisible = !isvisible;
                              });
                            },
                          ),
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 50),
                      child: ElevatedButton(
                          onPressed: () {
                            if (globalformkey.currentState.validate()) {
                              Get.off(() => Homepage());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.indigo[600],
                              padding: EdgeInsets.all(10)),
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20, letterSpacing: 1),
                          )),
                    )
                  ],
                ),
              ),
            )));
  }
}
