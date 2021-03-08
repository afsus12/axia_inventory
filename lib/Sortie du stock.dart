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
          backgroundColor: Colors.blueGrey,
          title: Text('Sortie du stock'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    hint: Text('Selectionner depot'),
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Image.asset(
              'images/scan.png',
              cacheWidth: 270,
              cacheHeight: 200,
            ),
            Container(
              child: FlatButton(
                child: Text('Scanner code a barre'),
                color: Colors.amber,
                textColor: Colors.white,
                minWidth: 300,
                height: 50,
                onPressed: () {},
              ),
            ),
            Row(
              children: [
                Container(
                  child: Text(
                    'Produit ajoutées',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
