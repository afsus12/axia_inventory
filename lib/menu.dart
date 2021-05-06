import 'package:flutter/material.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'gestion3.dart';
import 'recherche2.dart';
import 'consultation1.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
  final String aname;
  final String email;
  Menu({Key key, this.aname, this.email}) : super(key: key);
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
          drawer: new Drawer(
            child: ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text("${widget.aname}"),
                  accountEmail: new Text("${widget.email}"),
                  decoration: BoxDecoration(
                      color: const Color(0xFF00897b),
                      image: DecorationImage(
                          image: AssetImage("images/asd.jpg"),
                          fit: BoxFit.fill)),
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
                            child: Image.asset('images/in1.png',
                                fit: BoxFit.fill))),
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
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Consultation()),
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
                              builder: (context) => DataFromAPI()),
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
                        child:
                            Image.asset('images/IMg4.png', fit: BoxFit.cover),
                      ),
                    ),
                    onTap: () {}),
              ],
            ),
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
                                  builder: (context) =>
                                      Entre(aname: "${widget.aname}")),
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
                              MaterialPageRoute(builder: (context) => Sortie()),
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
                              MaterialPageRoute(builder: (context) => Tran()),
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
                                  builder: (context) => inventaire()),
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
                                  builder: (context) => Consultation()),
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
                                  builder: (context) =>
                                      DataFromAPI(aname: "${widget.aname}")),
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
