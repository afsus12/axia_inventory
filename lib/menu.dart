import 'package:axia_inventory/inventaire0.dart';
import 'package:flutter/material.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'gestion3.dart';

import 'consultation1.dart';
import 'package:http/http.dart' as http;
import 'sidemenu.dart';
import 'homescreen.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
  final String aname;
  final String email;
  final String url;
  Menu({Key key, this.aname, this.email, this.url}) : super(key: key);
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color(0xffA7D3F1),
              Color(0xffFFFFFF),
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color(0xff62959C),
            title: Text('Acceuil'),
            centerTitle: true,
          ),
          drawer: ssd(
            aname: "${widget.aname}",
            email: "${widget.email}",
            url: "${widget.url}",
          ),
          body: GridView.count(
            crossAxisCount: 2,
            children: [
              Stack(
                children: [
                  Center(
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print('clicked');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Entre(
                                        aname: "${widget.aname}",
                                        email: "${widget.email}",
                                        url: "${widget.url}",
                                      )),
                            );
                          });
                        },
                        child: Container(
                          width: 135,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffDE6262),
                                Color(0xffFFB88C),
                              ],
                            ),
                          ),
                          child: Center(
                              child: Image(
                            image: AssetImage('images/in.png'),
                            width: 80,
                          )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Center(
                        child: Text('Entrée en Stock',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal,
                            ))),
                  )
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print('clicked');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Sortie(
                                      aname: "${widget.aname}",
                                      email: "${widget.email}",
                                      url: "${widget.url}")),
                            );
                          });
                        },
                        child: Container(
                          width: 135,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffDE6262),
                                Color(0xffFFB88C),
                              ],
                            ),
                          ),
                          child: Center(
                              child: Image(
                            image: AssetImage('images/out.png'),
                            width: 80,
                          )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Center(
                        child: Text('Sortie de Stock',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal,
                            ))),
                  ),
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print('clicked');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tran(
                                      aname: "${widget.aname}",
                                      email: "${widget.email}",
                                      url: "${widget.url}")),
                            );
                          });
                        },
                        child: Container(
                          width: 135,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffDE6262),
                                Color(0xffFFB88C),
                              ],
                            ),
                          ),
                          child: Center(
                              child: Image(
                            image: AssetImage('images/tran.png'),
                            width: 70,
                          )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Center(
                        child: Text('Transfert de Stock',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal,
                            ))),
                  )
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print('clicked');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => invacc(
                                        aname: "${widget.aname}",
                                        email: "${widget.email}",
                                        url: "${widget.url}",
                                      )),
                            );
                          });
                        },
                        child: Container(
                          width: 135,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffDE6262),
                                Color(0xffFFB88C),
                              ],
                            ),
                          ),
                          child: Center(
                              child: Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Image(
                              image: AssetImage('images/inv.png'),
                              width: 70,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Center(
                        child: Text('Inventaire',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal,
                            ))),
                  )
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print('clicked');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Consultation(
                                        aname: "${widget.aname}",
                                        email: "${widget.email}",
                                        url: "${widget.url}",
                                      )),
                            );
                          });
                        },
                        child: Container(
                          width: 135,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffDE6262),
                                Color(0xffFFB88C),
                              ],
                            ),
                          ),
                          child: Center(
                              child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Image(
                              image: AssetImage('images/his.png'),
                              width: 70,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Center(
                        child: Text('Consultation',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal,
                            ))),
                  )
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            print('clicked');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          });
                        },
                        child: Container(
                          width: 135,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffDE6262),
                                Color(0xffFFB88C),
                              ],
                            ),
                          ),
                          child: Center(
                              child: Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Image(
                              image: AssetImage('images/utilis.png'),
                              width: 70,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Center(
                        child: Text('Gestion des comptes',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal,
                            ))),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
