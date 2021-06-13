import 'package:axia_inventory/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';

import 'consultation1.dart';
import 'api.dart';
import 'package:flutter/material.dart';

import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';

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

  final String email;
  final String url;

  ListTileSwitchExample({Key key, this.aname,this.email,this.url}) : super(key: key);
}

class _gestion extends State<ListTileSwitchExample> {
  List<bool> _switchValues = List.generate(7, (_) => false);
  int admin;

  @override
  Widget build(BuildContext context) {
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
