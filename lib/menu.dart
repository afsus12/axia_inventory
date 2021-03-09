import 'package:flutter/material.dart';

void main() {
  runApp(Menu());
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
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
          body: GridView.count(
            crossAxisCount: 2,
            children: [Stack(children: [

            Center(
              child: ClipOval(
                
                child: Container(
                  width:150,
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
                                   
            child:Center(child: Image(image: AssetImage('images/in.png'),width: 100,)) ,      ),
                ),
            ),
       Padding(
        padding: const EdgeInsets.only(top:180.0),
        child: Center(child: Text('Entrée en Stock')),
      )],),



      
Stack(children: [

            Center(
              child: ClipOval(
                
                child: Container(
                  width:150,
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
                                   
            child:Center(child: Image(image: AssetImage('images/out.png'),width: 100,)) ,      ),
                ),
            ),
       Padding(
        padding: const EdgeInsets.only(top:180.0),
        child: Center(child: Text('Sortie de Stock')),
      )],),
       Stack(children: [

            Center(
              child: ClipOval(
                
                child: Container(
                  width:150,
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
                                   
            child:Center(child: Image(image: AssetImage('images/tran.png'),width: 100,)) ,      ),
                ),
            ),
       Padding(
        padding: const EdgeInsets.only(top:180.0),
        child: Center(child: Text('Transfert de Stock')),
      )],),
       Stack(children: [

            Center(
              child: ClipOval(
                
                child: Container(
                  width:150,
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
                                   
            child:Center(child: Image(image: AssetImage('images/inv.png'),width: 100,)) ,      ),
                ),
            ),
       Padding(
        padding: const EdgeInsets.only(top:180.0),
        child: Center(child: Text('Inventaire')),
      )],),
       Stack(children: [

            Center(
              child: ClipOval(
                
                child: Container(
                  width:150,
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
                                   
            child:Center(child: Image(image: AssetImage('images/his.png'),width: 100,)) ,      ),
                ),
            ),
       
       Padding(
        padding: const EdgeInsets.only(top:180.0),
        child: Center(child: Text('Consultation'),)
      )
       
       ],),
       Stack(children: [

            Center(
              child: ClipOval(
                
                child: Container(
                  width:150,
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
                                   
            child:Center(child: Image(image: AssetImage('images/utilis.png'),width: 100,)) ,      ),
                ),
            ),
      Padding(
        padding: const EdgeInsets.only(top:180.0),
        child: Center(child: Text('Gestion des utilisateurs')),
      ) 
      ],),










            ],
          ),
        ),
      ),
    );
  }
}
