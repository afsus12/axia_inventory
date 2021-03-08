import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(Example());
}

class Example extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  List<String> _locations = ['Msaken', 'Monastir', 'Sousse', 'Beja'];
  List<String> _locations1 = ['Msaken', 'Monastir', 'Sousse', 'Beja'];
  String _selectedLocation;
  String _selectedLocation1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff62959c),
          title: Text('Transfert du Stock'),
          centerTitle: true,
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
            Container(
              margin: EdgeInsets.only(left: 10),
              width: 350.0,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(width: 1.0, style: BorderStyle.solid),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    hint: Text('Sélectionner un entrepôt'),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 42,
                    value: _selectedLocation,
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 20),
                  child: Text("Choix d'entrepôt (destination)"),
                ),
                SizedBox(width: 58),
                Icon(
                  Icons.reply,
                  color: Colors.green,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              width: 350.0,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(width: 1.0, style: BorderStyle.solid),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    hint: Text('Sélectionner un entrepôt'),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 42,
                    underline: SizedBox(),
                    value: _selectedLocation1,
                    items: _locations.map((location1) {
                      return DropdownMenuItem(
                        child: new Text(location1,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
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
            Container(
              child: Text(
                'Produit ajoutées',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
