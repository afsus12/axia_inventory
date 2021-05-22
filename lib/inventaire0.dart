import 'package:axia_inventory/ajouterUtilisateur.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'menu.dart';
import 'inventairehistclass.dart';
import 'dart:ffi';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'sidemenu.dart';

class invacc extends StatefulWidget {
  @override
  _invaccState createState() => _invaccState();

  final String aname;
  final String email;
  final String url;
  invacc({Key key, this.aname, this.email, this.url}) : super(key: key);
}

class _invaccState extends State<invacc> {
  @override
  List<dynamic> data = List();
  final List<Hisinv> invHislist = <Hisinv>[];
  Future getAllName() async {
    var response = await http.get(
        Uri.parse(
            'https://${widget.url}/api/inventaire/getstoklist/${widget.aname}'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    var n = jsonData.length;
    for (var index = 0; index < n; index++) {
      var dateFormat;
      DateTime dateTime = DateTime.parse(jsonData[index]['is_date']);
      setState(() {
        invHislist
          ..add(Hisinv(
              jsonData[index]['pi_intitule'],
              jsonData[index]['fa_codefamille'],
              jsonData[index]['de_code'],
              dateTime,
              jsonData[index]['is_remarques'],
              jsonData[index]['is_valide'],
              jsonData[index]['cbcreateur']));
      });
    }

    print(jsonData);
    return "success";
  }

  void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      setState(() {
        invHislist.sort((a, b) => a.isDate.compareTo(b.isDate));
      });
    } else if (choice == Constants.SecondItem) {
      setState(() {
        invHislist.sort((a, b) => a.isValide.compareTo(b.isValide));
      });
    } else if (choice == Constants.ThirdItem) {
      print('I Third Item');
    }
  }

  @override
  initState() {
    final List<Hisinv> invHislist = <Hisinv>[];
    super.initState();
    getAllName();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Inventaire'),
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
                  MaterialPageRoute(
                      builder: (context) => Menu(
                          aname: "${widget.aname}",
                          email: "${widget.email}",
                          url: "${widget.url}")),
                );
              });
            },
          )
        ],
      ),
      drawer: ssd(
          aname: "${widget.aname}",
          email: "${widget.email}",
          url: "${widget.url}"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: FloatingActionButton(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  onPressed: () {},
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
          Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff2193b0),
                        Color(0xff6dd5ed),
                      ])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text('Historiques des inventaires',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 400)),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.filter_list_rounded,
                          color: Colors.black,
                        ),
                        onSelected: choiceAction,
                        itemBuilder: (BuildContext context) {
                          return Constants.choices.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  )
                ],
              )),
          Expanded(
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                  itemCount: invHislist.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    String formattedDate = DateFormat('yyyy/MM/dd \n kk:mm')
                        .format(invHislist[index].isDate);
                    double c_width = MediaQuery.of(context).size.width * 0.37;

                    return Container(
                        child: Card(
                            child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.fiber_manual_record,
                                color: Colors.blue,
                                size: 13,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                invHislist[index].piIntitule,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 5),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  VerticalDivider(),
                                  Column(
                                    children: [
                                      Text(
                                        formattedDate,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      invHislist[index].isValide == 1
                                          ? Text(
                                              'Valider',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green,
                                              ),
                                            )
                                          : Text('en attente',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.yellow[700],
                                              )),
                                      invHislist[index].isValide == 1
                                          ? Icon(
                                              Icons.done_outline_rounded,
                                              color: Colors.green,
                                              size: 25,
                                            )
                                          : Icon(Icons.pending,
                                              color: Colors.yellow[700]),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 25),
                        child: Table(
                          defaultColumnWidth: FixedColumnWidth(130),
                          children: [
                            TableRow(children: [
                              TableCell(
                                  child: SizedBox(
                                      child: Text('Code Depot:',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          )))),
                              TableCell(
                                child: SizedBox(
                                  child: Text(invHislist[index].deCode),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: SizedBox(
                                      child: Text('Commentaire:',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          )))),
                              TableCell(
                                child: SizedBox(
                                  child: AutoSizeText(
                                    invHislist[index].isRemarques,
                                    minFontSize: 15,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: SizedBox(
                                      child: Text('Collaborateur:',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          )))),
                              TableCell(
                                child: SizedBox(
                                  child: Text(
                                    invHislist[index].cbcreateur,
                                  ),
                                ),
                              ),
                            ]),
                            invHislist[index].faCodefamille != ''
                                ? TableRow(children: [
                                    TableCell(
                                        child: SizedBox(
                                            child: Text('Famille Code:',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                )))),
                                    TableCell(
                                      child: SizedBox(
                                        child: Text(
                                            invHislist[index].faCodefamille,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    ),
                                  ])
                                : TableRow(children: [
                                    TableCell(
                                      child: SizedBox.shrink(),
                                    ),
                                    TableCell(child: SizedBox.shrink())
                                  ]),
                          ],
                        ),
                      ),
                    ])));
                  }),
            ),
          )
        ],
      ),
    ));
  }
}

class Constants {
  static const String FirstItem = 'Sort by : date';
  static const String SecondItem = 'Second Item';
  static const String ThirdItem = 'Third Item';

  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
    ThirdItem,
  ];
}
