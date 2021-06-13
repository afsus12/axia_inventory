 
 import 'dart:ffi';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:axia_inventory/PreferencesGlobales.dart';
import 'package:axia_inventory/homescreen.dart';
import 'package:axia_inventory/inventaire0.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'consultation1.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'classart.dart';
import 'package:commons/commons.dart';
 



    class ssd extends StatefulWidget {
      @override
      _ssdState createState() => _ssdState();
       final String aname;
  final String email;
  final String url;
    final bool entre;
  final bool sortie;
  final bool transfer;
  final bool consult;
  final bool gestionutil;
  final bool inventaires;
  final bool protvalidation;
  ssd({Key key, this.aname, this.email,this.url,this.entre,this.sortie,this.transfer,this.consult,this.gestionutil,this.inventaires,this.protvalidation}) : super(key: key);
    }
    
    class _ssdState extends State<ssd> {
      @override
      Widget sidemenu(context,a,b,c){
 return new Drawer(
            child: ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text(a),
                  accountEmail: new Text(b),
                  decoration: BoxDecoration(
                      color: const Color(0xFF00897b),
                      image: DecorationImage(
                          image: AssetImage("images/asd.jpg"),
                          fit: BoxFit.fill)),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: new AssetImage('images/ghhh.jpg'),
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
                          MaterialPageRoute(builder: (context) => Menu(aname: a,email:b ,url: c,    entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
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
                            child: Image.asset('images/in1.png',
                                fit: BoxFit.fill))),
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Entre(aname: a,email:b ,url: c,    entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
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
                          MaterialPageRoute(builder: (context) => Sortie(aname: a,email:b ,url: c,    entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
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
                          MaterialPageRoute(builder: (context) => Tran(aname: a,email:b ,url: c,    entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
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
                          MaterialPageRoute(builder: (context) => invacc(aname: a,email:b ,url: c,    entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
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
                          MaterialPageRoute(
                              builder: (context) => Consultation(aname: a,email:b ,url: c,    entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
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
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(aname: a,email:b ,url: c,    entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
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
                        child: Image.asset('images/parametre.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    onTap: () {
  setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrefGlob(aname: a,email:b ,url: c,    entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
                        );
                      });



                    }),
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
                        child:
                            Image.asset('images/IMg4.png', fit: BoxFit.cover),
                      ),
                    ),
                    onTap: () async{ var response = await http.get(
        Uri.parse(
            "https://$c/logout"));
            print(response);
                      setState(() { 
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login()),
                        );
                      });}),
              ],
            ),
          );}
      Widget build(BuildContext context) {
        return sidemenu(context, "${widget.aname}","${widget.email}", "${widget.url}");
          
        
      }
    }