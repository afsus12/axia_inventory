import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'gestion3.dart';
import 'consultation1.dart';
import 'api.dart';
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

class ListTileSwitchExample extends StatefulWidget {
  @override
  _gestion createState() => _gestion();
  final String aname;

  ListTileSwitchExample({Key key, this.aname}) : super(key: key);
}

class _gestion extends State<ListTileSwitchExample> {
  List<bool> _switchValues = List.generate(7, (_) => false);
  int admin;

  @override
  Widget build(BuildContext context) {
    List data = List();
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Ce Employé peut faire : ',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            ListTileSwitch(
              value: _switchValues[0],
              leading: Image.asset(
                'images/in1.png',
                height: 50,
                width: 50,
              ),
              onChanged: (value) {
                setState(() {
                  _switchValues[0] = value;
                  if (_switchValues[0] == true) {
                    admin = 1;
                  } else {
                    admin = 0;
                  }
                });
              },
              switchActiveColor: Colors.indigo,
              title: const Text(
                'Entré en stock ',
              ),
            ),
            ListTileSwitch(
              value: _switchValues[1],
              leading: Image.asset(
                'images/out2.png',
                height: 50,
                width: 50,
              ),
              onChanged: (value) {
                setState(() {
                  _switchValues[1] = value;
                  if (_switchValues[1] == true) {
                    admin = 1;
                  } else {
                    admin = 0;
                  }
                });
              },
              switchActiveColor: Colors.indigo,
              title: const Text(
                'Sortie du stock',
              ),
            ),
            ListTileSwitch(
              value: _switchValues[2],
              leading: Image.asset(
                'images/exchange2.png',
                height: 50,
                width: 50,
              ),
              onChanged: (value) {
                setState(() {
                  _switchValues[2] = value;
                  if (_switchValues[2] == true) {
                    admin = 1;
                  } else {
                    admin = 0;
                  }
                });
              },
              switchActiveColor: Colors.indigo,
              title: const Text(
                'Transfert du stock',
              ),
            ),
            ListTileSwitch(
              value: _switchValues[3],
              leading: Image.asset(
                'images/inventory2.png',
                height: 50,
                width: 50,
              ),
              onChanged: (value) {
                setState(() {
                  _switchValues[3] = value;
                  if (_switchValues[3] == true) {
                    admin = 1;
                  } else {
                    admin = 0;
                  }
                });
              },
              switchActiveColor: Colors.indigo,
              title: const Text(
                'Inventaire',
              ),
            ),
            ListTileSwitch(
              value: _switchValues[4],
              leading: Image.asset(
                'images/his2.png',
                height: 50,
                width: 50,
              ),
              onChanged: (value) {
                setState(() {
                  _switchValues[4] = value;
                  if (_switchValues[4] == true) {
                    admin = 1;
                  } else {
                    admin = 0;
                  }
                });
              },
              switchActiveColor: Colors.indigo,
              title: const Text(
                'Consultation historiques',
              ),
            ),
            FlatButton(
              child: Text('Ajouter'),
              color: Color(0xffec524b),
              textColor: Colors.white,
              minWidth: 100,
              height: 50,
              onPressed: () async {
                var cb = "${widget.aname}";

                var rsp = await role(admin, cb);
                print(rsp);

                if (rsp.statusCode == 200) {
                  var jsondata = jsonDecode(rsp.body);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
