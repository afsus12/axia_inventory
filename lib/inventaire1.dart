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
      ),
          );
  }
}
