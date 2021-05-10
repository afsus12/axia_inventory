import 'package:axia_inventory/recherche2.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';
import 'ajouterUtilisateur.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'gestion.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'consultation1.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'listedesdepotes.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class DataFromAPI extends StatefulWidget {
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
  final String aname;

  final String email;
  final String url;

  DataFromAPI({Key key, this.aname,this.email,this.url}) : super(key: key);
}

class _DataFromAPIState extends State<DataFromAPI> {
  Future getUserData() async {
    var response = await http.get(
      Uri.parse('https://${widget.url}/api/users/getusers'),headers: {"Accept": "application/json"});
  
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(u["protmUser"], u["deCode"], u["cbcreateur"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Gestion des utilisateurs'),
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
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Search Here...',
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ajouterUtilisateur(aname: "${widget.aname}")),
                    );
                  });
                },
                child: Text(
                  'Ajouter',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                child: SizedBox(
                  width: 600,
                  height: 600,
                  child: Card(
                    child: FutureBuilder(
                        future: getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text('wait..'),
                              ),
                            );
                          } else
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) {
                                  return ListTile(
                                    title: Text(snapshot.data[i].protmUser),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DepotFromAPI()),
                                        );
                                      });
                                    },
                                  );
                                });
                        }),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class User {
  final String protmUser, deCode, cbcreateur;

  User(this.protmUser, this.deCode, this.cbcreateur);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
