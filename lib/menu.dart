import 'package:flutter/material.dart';
import 'EntréEnStock.dart';
import 'login.dart';



class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                  accountName: new Text('yassine'),
                  accountEmail: new Text('afsayassine@gmail.com'),
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
                          minHeight: 24,
                          maxWidth: 25,
                          maxHeight: 28,
                        ),
                        child: Image.asset('images/homeicon.png',
                            fit: BoxFit.fill)),
                    title: new Text('Acceuil'),
                    onTap: () {}),
                new ListTile(
                    title: new Text('Entrée en stock'),
                    leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                          maxWidth: 30,
                          maxHeight: 30,
                        ),
                        child: Image.asset('images/in1.png', fit: BoxFit.fill)),
                    onTap: () {}),
                new ListTile(
                    title: new Text('Sortie du Stock'),
                    leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                          maxWidth: 30,
                          maxHeight: 30,
                        ),
                        child:
                            Image.asset('images/out2.png', fit: BoxFit.fill)),
                    onTap: () {}),
                new ListTile(
                    title: new Text('Transfert du Stock'),
                    leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                          maxWidth: 28,
                          maxHeight: 30,
                        ),
                        child: Image.asset('images/exchange2.png',
                            fit: BoxFit.fill)),
                    onTap: () {}),
                new ListTile(
                    title: new Text('Inventaire'),
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                        maxWidth: 28,
                        maxHeight: 30,
                      ),
                      child: Image.asset('images/inventory2.png',
                          fit: BoxFit.cover),
                    ),
                    onTap: () {}),
                new ListTile(
                    title: new Text("Consultation d'historique"),
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                        maxWidth: 30,
                        maxHeight: 30,
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
                        minWidth: 24,
                        minHeight: 24,
                        maxWidth: 30,
                        maxHeight: 28,
                      ),
                      child: Image.asset('images/usr.png', fit: BoxFit.cover),
                    ),
                    onTap: () {}),
                new ListTile(
                    title: new Text('Parametre'),
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                        maxWidth: 30,
                        maxHeight: 28,
                      ),
                      child: Image.asset('images/parametre.png',
                          fit: BoxFit.cover),
                    ),
                    onTap: () {}),
                new ListTile(
                    title: new Text('log out'),
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                        maxWidth: 30,
                        maxHeight: 28,
                      ),
                      child: Image.asset('images/IMg4.png', fit: BoxFit.cover),
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
                      child: GestureDetector(  onTap: () {
          setState(() { print('clicked');
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Example()),
  );
          });
        },
                        child: Container(
                          width: 150,
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
                            width: 100,
                          )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Center(child: Text('Entrée en Stock')),
                  )
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: ClipOval(
                      child: Container(
                        width: 150,
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
                          width: 100,
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Center(child: Text('Sortie de Stock')),
                  )
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: ClipOval(
                      child: Container(
                        width: 150,
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
                          width: 100,
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Center(child: Text('Transfert de Stock')),
                  )
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: ClipOval(
                      child: Container(
                        width: 150,
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
                          image: AssetImage('images/inv.png'),
                          width: 100,
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Center(child: Text('Inventaire')),
                  )
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: ClipOval(
                      child: Container(
                        width: 150,
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
                          image: AssetImage('images/his.png'),
                          width: 100,
                        )),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 180.0),
                      child: Center(
                        child: Text('Consultation'),
                      ))
                ],
              ),
              FlatButton(
                child: Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: Container(
                          width: 150,
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
                            image: AssetImage('images/utilis.png'),
                            width: 100,
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 180.0),
                      child: Center(child: Text('Gestion des utilisateurs')),
                    )
                  ],
                ),
                onPressed: () {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      
    );
  }
}
