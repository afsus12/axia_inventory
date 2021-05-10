import 'dart:ffi';
import 'package:axia_inventory/sidemenu.dart';
import 'package:flutter/material.dart';

import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'gestion3.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'consultation1.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'api.dart';

class ajouterUtilisateur extends StatefulWidget {
  @override
  _ajouterUtilisateurState createState() => _ajouterUtilisateurState();
  final String aname;
  final String email;
  final String url;

  ajouterUtilisateur({Key key, this.aname,this.email,this.url}) : super(key: key);
}

class _ajouterUtilisateurState extends State<ajouterUtilisateur> {
  TextEditingController protmUserController = TextEditingController();
  TextEditingController protmPwdController = TextEditingController();
  TextEditingController decodeController = TextEditingController();
  TextEditingController protmDescriptionController = TextEditingController();
  TextEditingController protmRightController = TextEditingController();
  TextEditingController protmEmailController = TextEditingController();
  TextEditingController protmUserprofilController = TextEditingController();
  TextEditingController protmAdministratorController = TextEditingController();
  TextEditingController cbcreateurController = TextEditingController();
  bool _isDisabled = false;
  int admin;

  @override
  Widget build(BuildContext context) {
    String selectedName;
    List data = List();

    Future getAllName() async {
      var response = await http.get(
          Uri.parse('https://${widget.url}/api/Depot/selection/${widget.aname}'),
          headers: {"Accept": "application/json"});
      var jsonBody = response.body;
      var jsonData = json.decode(jsonBody);
      setState(() {
        data = jsonData;
      });
      print(jsonData);
      return "success";
    }

    @override
    initState() {
      super.initState();
      getAllName();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Ajouter un utilisateur'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}")),
                );
              });
            },
          )
        ],
      ),
      drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}"),
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Center(
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Nom utilisateur :'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 17, top: 20),
                        child: Container(
                          width: 200,
                          height: 35,
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                              hintText: 'Nom utilisateur',
                              hintStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                            ),
                            controller: protmUserController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Password :'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, top: 20),
                        child: Container(
                          width: 200,
                          height: 35,
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                            ),
                            controller: protmPwdController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Description :'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 20),
                        child: Container(
                          width: 200,
                          height: 35,
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                              hintText: 'Description',
                              hintStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                            ),
                            controller: protmDescriptionController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Email :'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 75, top: 20),
                        child: Container(
                          width: 200,
                          height: 35,
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                            ),
                            controller: protmEmailController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Userprofil :'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, top: 20),
                        child: Container(
                          width: 200,
                          height: 35,
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                              hintText: 'Userprofil',
                              hintStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                            ),
                            controller: protmUserprofilController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Admin ou non :'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 23, top: 20),
                        child: Container(
                          width: 70,
                          height: 35,
                          child: Switch(
                              value: _isDisabled,
                              onChanged: (check) {
                                setState(() {
                                  _isDisabled = check;
                                  if (_isDisabled == true) {
                                    admin = 1;
                                  } else {
                                    admin = 0;
                                  }
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Depot :'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 73, top: 20),
                        child: Container(
                          width: 200,
                          height: 35,
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                              hintText: 'Depot',
                              hintStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                            ),
                            controller: decodeController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Container(
                        child: FlatButton(
                          child: Text('Ajouter'),
                          color: Color(0xffec524b),
                          textColor: Colors.white,
                          minWidth: 100,
                          height: 50,
                          onPressed: () async {
                            var cb = "${widget.aname}";
                            var user = protmUserController.text;
                            var pwde = protmPwdController.text;
                            var desc = protmDescriptionController.text;
                            var mail = protmEmailController.text;
                            var profil = protmUserprofilController.text;
                            var depo = decodeController.text;
                            var rsp = await loginUsdder(user, pwde, desc, mail,
                                profil, admin, depo, cb,"${widget.url}");
                            print(rsp);

                            if (rsp.statusCode == 200) {
                              var jsondata = jsonDecode(rsp.body);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
