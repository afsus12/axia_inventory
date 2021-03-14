import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';

class inventaire extends StatefulWidget {
  @override
  _inventaireState createState() => _inventaireState();
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
    MaterialPageRoute(builder: (context) => Menu()),
  );
          });
      },
    )
  ],
      ),
       drawer: new Drawer(
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
      body: SingleChildScrollView( physics: NeverScrollableScrollPhysics(),
        child: Center(
          child: IntrinsicWidth(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [Padding(
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
                            decoration: InputDecoration( isDense: true, contentPadding: EdgeInsets.all(8),
                            

                            
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                                  
                                  borderSide: BorderSide(
                                      width: 10, 
                                      style: BorderStyle.solid,
                                  ),),
                             labelText: 'N°inv',
                             labelStyle:TextStyle(color: Color(0xFF8B8B8B),fontSize: 12),
                            
                            hintText: 'Enter your  password',
                            hintStyle: TextStyle(color: Color(0xFF8B8B8B),fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ) 
  ,




                
                 Row(
                   children: [Padding(
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
                             side: BorderSide(width:0.6, style: BorderStyle.solid),
                           ),
                         ),
                         child: DropdownButtonHideUnderline(  
                           child: ButtonTheme(
                             alignedDropdown: true,
                             child: DropdownButton( 
                               hint:  Text('selectioner un entrepôt',style: TextStyle(color: Color(0xFF8B8B8B),fontSize: 12),),
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
                      children: [Padding(
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
                            decoration: InputDecoration( isDense: true, contentPadding: EdgeInsets.all(8),
                            

                            
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                                  
                                  borderSide: BorderSide(
                                      width: 10, 
                                      style: BorderStyle.solid,
                                  ),),
                             labelText: 'N°inv',
                             labelStyle:TextStyle(color: Color(0xFF8B8B8B),fontSize: 12),
                            
                            hintText: 'Enter your  password',
                            hintStyle: TextStyle(color: Color(0xFF8B8B8B),fontSize: 12),
                          ),
                        ),
                  ),
                ),
                      ],
                    ) 
  ,     Row(
    children: [Padding(
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
                            decoration: InputDecoration( isDense: true, contentPadding: EdgeInsets.all(8),
                            

                            
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                                  
                                  borderSide: BorderSide(
                                      width: 10, 
                                      style: BorderStyle.solid,
                                  ),),
                             labelText: 'N°inv',
                             labelStyle:TextStyle(color: Color(0xFF8B8B8B),fontSize: 12),
                            
                            hintText: 'Enter your  password',
                            hintStyle: TextStyle(color: Color(0xFF8B8B8B),fontSize: 12),
                          ),
                        ),
                      ),
                    ),
    ],
  ) 
  ,  Row(
    children: [Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text('Comment      :'),
                  ),
      Padding(
                         padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Container( 
                                width: 200,
                             
                        child: new TextField(autofocus: false,
      focusNode: _focusnode,
      maxLines: 3,
 
      keyboardType: TextInputType.text,
                           minLines: 1, 
                            
                            obscureText: false,
                            decoration: InputDecoration( isDense: true, contentPadding: EdgeInsets.all(8),
                            

                            
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                                  
                                  borderSide: BorderSide(
                                      width: 10, 
                                      style: BorderStyle.solid,
                                  ),),
                             labelText: 'comment',
                             labelStyle:TextStyle(color: Color(0xFF8B8B8B),fontSize: 12),
                            
                            hintText: 'commentaire',
                            hintStyle: TextStyle(color: Color(0xFF8B8B8B),fontSize: 12),
                          ),
                        ),
                        ),
                    ),
    ],
  ) 
  ,
  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Center(
                      child: Container( 
     
                        child: FlatButton(
                          child: Text('Scanner code a barre'),
                          color: Color(0xffec524b),
                          textColor: Colors.white,
                          
                          minWidth: 200,
                          height: 50,
                          onPressed: (){  setState(() {
                                                
                          


                                                
                                              });
                             



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
