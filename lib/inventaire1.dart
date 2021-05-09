import 'package:axia_inventory/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'gestion3.dart';
import 'consultation1.dart';

class inventaire extends StatefulWidget {
  @override
  _inventaireState createState() => _inventaireState();
     final String aname;
  final String email;
  final String url;
inventaire({Key key, this.aname, this.email,this.url}) : super(key: key);
}

class _inventaireState extends State<inventaire> {
  FocusNode _focusnode;
  List<String> _locations = ['Msaken', 'Monastir', 'Sousse', 'Beja'];
  String _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  MaterialPageRoute(builder: (context) => Menu(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}")),
                );
              });
            },
          )
        ],
      ),
      drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}"),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Center(
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text('N° Inventaire :'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                        width: 200,
                        height: 35,
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                width: 10,
                                style: BorderStyle.solid,
                              ),
                            ),
                            labelText: 'N°inv',
                            labelStyle: TextStyle(
                                color: Color(0xFF8B8B8B), fontSize: 12),
                            hintText: 'Enter your  password',
                            hintStyle: TextStyle(
                                color: Color(0xFF8B8B8B), fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text('Entrepôt         :'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                        width: 200,
                        height: 35,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                                width: 0.6, style: BorderStyle.solid),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              hint: Text(
                                'selectioner un entrepôt',
                                style: TextStyle(
                                    color: Color(0xFF8B8B8B), fontSize: 12),
                              ),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 33,
                              value: _selectedLocation,
                              items: _locations.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal)),
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
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text('Réference inv:'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                        width: 200,
                        height: 35,
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                width: 10,
                                style: BorderStyle.solid,
                              ),
                            ),
                            labelText: 'N°inv',
                            labelStyle: TextStyle(
                                color: Color(0xFF8B8B8B), fontSize: 12),
                            hintText: 'Enter your  password',
                            hintStyle: TextStyle(
                                color: Color(0xFF8B8B8B), fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text('N° Inventaire :'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                        width: 200,
                        height: 35,
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                width: 10,
                                style: BorderStyle.solid,
                              ),
                            ),
                            labelText: 'N°inv',
                            labelStyle: TextStyle(
                                color: Color(0xFF8B8B8B), fontSize: 12),
                            hintText: 'Enter your  password',
                            hintStyle: TextStyle(
                                color: Color(0xFF8B8B8B), fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text('Comment      :'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                        width: 200,
                        child: new TextField(
                          autofocus: false,
                          focusNode: _focusnode,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          minLines: 1,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                width: 10,
                                style: BorderStyle.solid,
                              ),
                            ),
                            labelText: 'comment',
                            labelStyle: TextStyle(
                                color: Color(0xFF8B8B8B), fontSize: 12),
                            hintText: 'commentaire',
                            hintStyle: TextStyle(
                                color: Color(0xFF8B8B8B), fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Container(
                      child: FlatButton(
                        child: Text('Scanner code a barre'),
                        color: Color(0xffec524b),
                        textColor: Colors.white,
                        minWidth: 200,
                        height: 50,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
