import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
import 'utilisateurspost.dart';

class ajouterUtilisateur extends StatefulWidget {
  @override
  _ajouterUtilisateurState createState() => _ajouterUtilisateurState();
}

Future<DataModel> submitData(String name, String decode) async {
  var response = await http.post(
      Uri.https('192.168.1.34:8000/', 'api/users/getusers'),
      body: {"name": name, "decode": decode});
  var data = response.body;
  print(data);

  if (response.statusCode == 4) {
    String responseString = response.body;
    dataModelFromJson(responseString);
  } else
    return null;
}

class _ajouterUtilisateurState extends State<ajouterUtilisateur> {
  DataModel _dataModel;
  TextEditingController protmUserController = TextEditingController();
  TextEditingController decodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String selectedName;
    List data = List();
    Future<DataModel> submitData(String protmUser, String decode) async {
      var response = await http.post(
          Uri.https('192.168.1.34:8000/', 'api/users/getusers'),
          body: {"protmUser": protmUser, "decode": decode});
      var data = response.body;
      print(data);

      if (response.statusCode == 4) {
        String responseString = response.body;
        dataModelFromJson(responseString);
      } else
        return null;
    }

    Future getAllName() async {
      var response = await http.get(
          Uri.parse('https://192.168.1.34:8000/api/Depot/selection/elitex47'),
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
                  MaterialPageRoute(builder: (context) => Menu()),
                );
              });
            },
          )
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('yassine'),
              accountEmail: new Text('afsayassine@gmail.com'),
              decoration: BoxDecoration(
                  color: const Color(0xFF00897b),
                  image: DecorationImage(
                      image: AssetImage("images/asd.jpg"), fit: BoxFit.fill)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: new AssetImage('images/avataaars.png'),
              ),
            ),
            new ListTile(
                leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 24,
                      minHeight: 20,
                      maxWidth: 28,
                      maxHeight: 28,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child:
                          Image.asset('images/homeicon.png', fit: BoxFit.fill),
                    )),
                title: new Text('Acceuil'),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );
                  });
                }),
            new ListTile(
                title: new Text('Entrée en stock'),
                leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                      maxWidth: 29,
                      maxHeight: 29,
                    ),
                    child: Container(
                        child:
                            Image.asset('images/in1.png', fit: BoxFit.fill))),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Entre()),
                    );
                  });
                }),
            new ListTile(
                title: new Text('Sortie du Stock'),
                leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 24,
                      minHeight: 21,
                      maxWidth: 28,
                      maxHeight: 28,
                    ),
                    child: Container(
                        margin: EdgeInsets.only(left: 1),
                        child:
                            Image.asset('images/out2.png', fit: BoxFit.fill))),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Sortie()),
                    );
                  });
                }),
            new ListTile(
                title: new Text('Transfert du Stock'),
                leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 21,
                      minHeight: 21,
                      maxWidth: 26,
                      maxHeight: 26,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child:
                          Image.asset('images/exchange2.png', fit: BoxFit.fill),
                    )),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tran()),
                    );
                  });
                }),
            new ListTile(
                title: new Text('Inventaire'),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                    maxWidth: 28,
                    maxHeight: 26,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child:
                        Image.asset('images/inventory2.png', fit: BoxFit.cover),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => inventaire()),
                    );
                  });
                }),
            new ListTile(
                title: new Text("Consultation d'historique"),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                    maxWidth: 28,
                    maxHeight: 28,
                  ),
                  child: Image.asset('images/his2.png', fit: BoxFit.cover),
                ),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Consultation()),
                    );
                  });
                }),
            Divider(
              color: Colors.grey,
            ),
            new ListTile(
                title: new Text('Gestion des utilisateurs'),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 27,
                    minHeight: 24,
                    maxWidth: 32,
                    maxHeight: 30,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Image.asset('images/usr.png', fit: BoxFit.cover),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DataFromAPI()),
                    );
                  });
                }),
            new ListTile(
                title: new Text('Parametre'),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                    maxWidth: 30,
                    maxHeight: 25,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child:
                        Image.asset('images/parametre.png', fit: BoxFit.cover),
                  ),
                ),
                onTap: () {}),
            new ListTile(
                title: new Text('log out'),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 25,
                    minHeight: 25,
                    maxWidth: 30,
                    maxHeight: 28,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Image.asset('images/IMg4.png', fit: BoxFit.cover),
                  ),
                ),
                onTap: () {}),
          ],
        ),
      ),
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
                        padding: const EdgeInsets.only(left: 20, top: 20),
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
                        child: Text('Email :'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80, top: 20),
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
                            controller: decodeController,
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
                        padding: const EdgeInsets.only(left: 53, top: 20),
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
                              hintText: 'Enter your  password',
                              hintStyle: TextStyle(
                                  color: Color(0xFF8B8B8B), fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Entrepôt :            '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Container(
                          width: 200,
                          height: 35,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                  width: 0.6, style: BorderStyle.solid),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                hint: Text(
                                  'selectioner un entrepôt',
                                  style: TextStyle(
                                      color: Color(0xFF8B8B8B), fontSize: 12),
                                ),
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 33,
                                value: selectedName,
                                items: data.map((list) {
                                  return DropdownMenuItem(
                                    child: Text(list['deIntitule']),
                                    value: list['deIntitule'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedName = value;
                                  });
                                },
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
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
                            String protmUser = protmUserController.text;
                            String decode = decodeController.text;
                            DataModel data =
                                await submitData(protmUser, decode);
                            setState(() {
                              _dataModel = data;
                            });
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
