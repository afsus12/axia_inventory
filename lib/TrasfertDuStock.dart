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
  List<String> _locations1 = ['Mseken', 'monestir', 'Sousse', 'beja'];
  String _selectedLocation;
  String _selectedLocation1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Entrée en stock'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Choisir l entrepôt origine '),
                  ),
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Text('Choisir l entrepôt destination ')),
                  ),
                  DropdownButton(
                    hint: Text('Selectionner depot'),
                    value: _selectedLocation1,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation1 = newValue;
                      });
                    },
                    items: _locations.map((location1) {
                      return DropdownMenuItem(
                        child: new Text(location1),
                        value: location1,
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
