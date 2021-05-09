import 'package:axia_inventory/sidemenu.dart';
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
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'gestion3.dart';
import 'consultation1.dart';

class Consultation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Consultation();
   final String aname;
  final String email;
  final String url;
  Consultation({Key key, this.aname, this.email,this.url}) : super(key: key);
}

class _Consultation extends State<Consultation> {
  String _scanBarcode = 'Unknown';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Consultation'),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, right: 35, left: 35, bottom: 8),
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
                        child: Text(list['deIntitule']),
                        value: list['deIntitule'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedName = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 15),
            child: Center(
              child: Image.asset(
                'images/scan.png',
                cacheWidth: 300,
                cacheHeight: 100,
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
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
