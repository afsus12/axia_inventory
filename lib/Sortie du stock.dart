import 'package:flutter/material.dart';

void main() {
  runApp(Example());
}

class Example extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  List<String> _locations = ['Mseken', 'monestir', 'Sousse', 'beja'];
  String _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff62959c),
          title: Text('Sortie du stock'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
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
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 15),
              child: Center(
                child: Image.asset(
                  'images/scan.png',
                  cacheWidth: 300,
                  cacheHeight: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
