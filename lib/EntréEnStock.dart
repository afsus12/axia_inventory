import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Entre extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Entre();
}

class _Entre extends State<Entre> {
  
  String _scanBarcode = 'Unknown';
  String selectedName;
  List data= List();

  Future getAllName()async{
  var response= await http.get(Uri.parse('https://192.168.1.8:8000/api/Depot/selection/elitex47'),headers:{"Accept":"application/json"});
  var jsonBody = response.body;
  var jsonData = json.decode(jsonBody);
  setState(() {
    data=jsonData;

  });
  print(jsonData);
  return "success";
  }

  @override
  initState() {
    super.initState();
    getAllName();
  }

Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff62959c),
          title: Text('Entrée en stock'),
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
                        child: Image.asset('images/homeicon.png',
                            fit: BoxFit.fill),
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
                          child: Image.asset('images/out2.png',
                              fit: BoxFit.fill))),
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
                        child: Image.asset('images/exchange2.png',
                            fit: BoxFit.fill),
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
                      child: Image.asset('images/inventory2.png',
                          fit: BoxFit.cover),
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
                  onTap: () {}),
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
                  onTap: () {}),
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
                      child: Image.asset('images/parametre.png',
                          fit: BoxFit.cover),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, right: 35, left: 35, bottom: 8),
              child: Container(
                margin: EdgeInsets.only(top: 30, bottom: 10),
                width: MediaQuery.of(context).size.width,
                height: 45,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(width: 0.6, style: BorderStyle.solid),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      hint: Text('Sélectionner un entrepôt'),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 33,
                      value: selectedName,
                      items: data.map((list) {
                        return DropdownMenuItem(
                          child:Text(list['deIntitule']),value: list['deIntitule'],) ;
                      }).toList(),
                      onChanged:(value){
                        setState(() {
                          selectedName=value;
                        });
                      }, 
                      
                   
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 15),
              child: Center(
                child: Image.asset(
                  'images/scan.png',
                  cacheWidth: 300,
                  cacheHeight: 120,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  child: FlatButton(
                    child: Text('Scanner code a barre'),
                    color: Color(0xffec524b),
                    textColor: Colors.white,
                    minWidth: 350,
                    height: 50,
                    onPressed: () {
                      setState(() {
                        scanBarcodeNormal();
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 15),
              width: 500,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xffAF5F422),
                      Color(0xffFFFFFF),
                    ]),
              ),
              child: Text(
                'Produit ajoutées',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                    maxWidth: 25,
                    maxHeight: 28,
                  ),
                  child: Image.asset('images/net.png', fit: BoxFit.fill)),
              title: new Text(
                  'Referance du produit : *******\nDesination : *******\nQuantitiéEnStock:350'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  child: FlatButton(
                    child: Text('pop up'),
                    color: Color(0xffec524b),
                    textColor: Colors.white,
                    minWidth: 350,
                    height: 50,
                    onPressed: () {
                      return Alert(
                          context: context,
                          title: "Bakou kaki",
                          desc:
                              "Referance du produit : *******\nDesination : *******\nQuantitiéEnStock:350",
                          content: Form(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Quantité"),
                                ),
                              ],
                            ),
                          ),
                          buttons: [
                            DialogButton(
                              child: Text("Valider"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            DialogButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ]).show();
                    },
                  ),
                ),
              ),
            ),
   Text(_scanBarcode)       ],
        ),
      ),
    );
  }
}
 