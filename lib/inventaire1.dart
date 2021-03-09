import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Row(
            children: [
              Text('N°inventaire'),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        width: 10,
                        style: BorderStyle.solid,
                      ),
                    ),
                    labelText: 'Password',
                    hintText: 'Enter your secure password'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
