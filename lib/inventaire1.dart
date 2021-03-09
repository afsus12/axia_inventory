import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';

class inventaire extends StatefulWidget {
  @override
  _inventaireState createState() => _inventaireState();
}

class _inventaireState extends State<inventaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Inventaire'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 75),
                    width: 200,
                    child: TextFormField(
                      cursorColor: Theme.of(context).cursorColor,
                      initialValue: '',
                      decoration: InputDecoration(
                        labelText: 'N°inventaire :',
                        labelStyle: TextStyle(
                          color: Color(0xFF6200EE),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF6200EE)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 75),
                width: 200,
                child: TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  initialValue: '',
                  decoration: InputDecoration(
                    labelText: 'Entrepôt',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 75),
                width: 200,
                child: TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  initialValue: '',
                  decoration: InputDecoration(
                    labelText: 'Réferance Inv :',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 75),
                width: 200,
                child: TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  initialValue: '',
                  decoration: InputDecoration(
                    labelText: 'Collaborateur :',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Container(
                child: FlatButton(
                  child: Text('Scanner code a barre'),
                  color: Color(0xffec524b),
                  textColor: Colors.white,
                  minWidth: 210,
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
    );
  }
}
