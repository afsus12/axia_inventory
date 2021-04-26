import 'package:axia_inventory/recherche2.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';
import 'ajouterUtilisateur.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class DataFromAPI extends StatefulWidget {
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  Future getUserData() async {
    var response = await http.get(
      Uri.parse('https://192.168.1.9:8000/api/users/getusers'),
    );
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
                          builder: (context) => ajouterUtilisateur()),
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
                                    subtitle: Text(snapshot.data[i].deCode),
                                    trailing: Text(snapshot.data[i].cbcreateur),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListTileSwitchExample()),
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
