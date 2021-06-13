import 'package:axia_inventory/inventaire0.dart';
import 'package:flutter/material.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';


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
  final bool entre;
  final bool sortie;
  final bool transfer;
  final bool consult;
  final bool gestionutil;
  final bool inventaires;
  final bool protvalidation;
  Menu({Key key, this.aname, this.email, this.url,this.entre,this.sortie,this.transfer,this.consult,this.gestionutil,this.inventaires,this.protvalidation}) : super(key: key);
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
                entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Wrap( 
direction: Axis.vertical,
  alignment: WrapAlignment.spaceEvenly,
  crossAxisAlignment: WrapCrossAlignment.center,
  runAlignment: WrapAlignment.spaceEvenly,
  spacing: 5.0,
  runSpacing: 50.0,
                       
                children: [
                  Visibility(visible: widget.entre,
                    child: SizedBox(height: 200,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Stack(
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
                                                     entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,

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
                             
                              ],
                            ),
                          ),
                       Center(
                       child: Text('Entrée en Stock',
                           style: TextStyle(
                             fontSize: 16,
                             fontFamily: 'Montserrat',
                             fontWeight: FontWeight.normal,
                           )))       ],
                      ),
                    ),
                  ),
                  Visibility(visible: widget.transfer,
                    child:SizedBox(height: 200,
                      child: Column( mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Stack(
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
                                                    url: "${widget.url}",
                                                      entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
                                                    
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
                              
                              ],
                            ),
                          ),
                                     
                                     
                       Center(
                           child: Text('Transfert de Stock',
                               style: TextStyle(
                                 fontSize: 16,
                                 fontFamily: 'Montserrat',
                                 fontWeight: FontWeight.normal,
                               )))
                        ],
                      ),
                    ),
                  ),
                     Visibility(visible: widget.consult,
                    child: SizedBox(height: 200,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Stack(
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
                                                    entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,   )),
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
                                
                              ],
                            ),
                          ),
                      Center(
                          child: Text('Consultation',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.normal,
                              )))  ],
                      ),
                    ),
                  ),
                  Visibility(visible:widget.sortie,
                    child: SizedBox(height: 200,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Stack(
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
                                                    url: "${widget.url}",
                                                     entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
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
                                
                              ],
                            ),
                          ),
                      
                      Center(
                          child: Text('Sortie de Stock',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.normal,
                              ))),
                        ],
                      ),
                    ),
                  ),
                  
                  Visibility(visible: widget.inventaires,
                    child: SizedBox(height: 200,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Stack(
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
                                                       entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,
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
                               
                              ],
                            ),
                          ),
                       Center(
                                  child: Text('Inventaire',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.normal,
                                      )))  ],
                      ),
                    ),
                  ),
               
                  Visibility(visible: widget.gestionutil,
                    child: SizedBox(height: 200,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Stack(
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
                                                  builder: (context) => HomeScreen(
                                                      aname: "${widget.aname}",
                                                      email: "${widget.email}",
                                                      url: "${widget.url}",
                                                         entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,
                                                  )));
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
                                
                              ],
                            ),
                          ),
                                     
                                     Center(
                         child: Text('Gestion des comptes',
                             style: TextStyle(
                               fontSize: 16,
                               fontFamily: 'Montserrat',
                               fontWeight: FontWeight.normal,
                             )))
                        ],
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
