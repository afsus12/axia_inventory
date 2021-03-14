import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';

class Tran extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Tran();
}

class _Tran extends State<Tran> {
  List<String> _locations = ['Msaken', 'Monastir', 'Sousse', 'Beja'];
  List<String> _locations1 = ['Msaken', 'Monastir', 'Sousse', 'Beja'];
  String _selectedLocation;
  String _selectedLocation1;

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff62959c),
          title: Text('Transfert du Stock'),
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
          centerTitle: true,
        ), drawer: new Drawer(
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
                    onTap: () {  setState(() { 
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Menu()),
  );
          });}),
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
                          child: Image.asset('images/in1.png', fit: BoxFit.fill))),
                    onTap: () {setState(() { 
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Entre()),
  );
          });}),
                new ListTile(
                    title: new Text('Sortie du Stock'),
                    leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 24,
                          minHeight: 21,
                          maxWidth: 28,
                          maxHeight: 28,
                        ),
                        child:
                            Container(margin: EdgeInsets.only(left: 1),child: Image.asset('images/out2.png', fit: BoxFit.fill))),
                    onTap: () {setState(() { 
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Sortie()),
  );
          });}),
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
                          padding: const EdgeInsets.only(left:2),
                          child: Image.asset('images/exchange2.png',
                              fit: BoxFit.fill),
                        )),
                    onTap: () {setState(() { 
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Tran()),
  );
          });}),
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
                    onTap: () {setState(() { 
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => inventaire()),
  );
          });}),
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
                        padding: const EdgeInsets.only(left:2),
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
                        padding: const EdgeInsets.only(left:5),
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15),
                  child: Text("Choix d'entrepôt (origine)"),
                ),
                SizedBox(width: 90),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Icon(
                        Icons.reply,
                        color: Colors.red,
                      )),
                )
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: 350.0,
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
                      value: _selectedLocation,
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,)),
                          value: location,
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation = newValue;
                        });
                      },
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15),
                  child: Text("Choix d'entrepôt (destination)"),
                ),
                SizedBox(width: 58),
                Icon(
                  Icons.reply,
                  color: Colors.green,
                ),
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: 350.0,
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
                      underline: SizedBox(),
                      value: _selectedLocation1,
                      items: _locations.map((location1) {
                        return DropdownMenuItem(
                          child: new Text(location1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          value: location1,
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation1 = newValue;
                        });
                      },
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Image.asset(
                  'images/scan.png',
                  cacheWidth: 300,
                  cacheHeight: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
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
