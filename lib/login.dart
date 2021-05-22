import 'dart:convert';

import 'package:axia_inventory/api.dart';
import 'package:axia_inventory/customWidget.dart';
import 'package:axia_inventory/menu.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  String message = '';
  final protUserController = TextEditingController();
  final protPwdController = TextEditingController();
  @override
  void dispose() {
    protUserController.dispose();
    protPwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/sfsqf.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Center(
                child: Container(
                    child: Image(
                  image: AssetImage('images/logo2.png'),
                  width: 220,
                )),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: protUserController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'user cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                width: 10,
                                style: BorderStyle.solid,
                              )),
                          labelText: 'User Name',
                          hintText: 'Entre your username'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: protPwdController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'password cannot be empty';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 10,
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText: 'Password',
                          hintText: 'Enter your  password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
                    child: Center(
                      child: Container(
                        child: CustomButton(
                          btnText: 'Login',
                          onBtnPressed: () async {
                            if (_formKey.currentState.validate()) {
                              var protUser = protUserController.text;
                              var protPwd = protPwdController.text;
                              setState(() {
                                message = 'please wait ...';
                              });
                              var uri = '192.168.1.36:8000';
                              var rsp = await loginUser(protUser, protPwd, uri);
                              print(rsp);

                              if (rsp.statusCode == 200) {
                                var jsondata = jsonDecode(rsp.body);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Menu(
                                              aname: jsondata['name'],
                                              email: jsondata['email'],
                                              url: uri,
                                            )));
                              } else {
                                setState(() {
                                  message = 'invalid credentials';
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Text('$message')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
