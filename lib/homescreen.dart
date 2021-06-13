import 'package:axia_inventory/ajouterUtilisateur.dart';
import 'package:axia_inventory/constants.dart';
import 'package:axia_inventory/listedesdepotes.dart';
import 'package:axia_inventory/menu.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'modifierpwd.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
       final String aname;
  final String email;
  final String url;
    final bool entre;
  final bool sortie;
  final bool transfer;
  final bool consult;
  final bool gestionutil;
  final bool inventaires;
  final bool protvalidation;
HomeScreen({Key key, this.aname, this.email,this.url,this.entre,this.sortie,this.transfer,this.consult,this.gestionutil,this.inventaires,this.protvalidation}) : super(key: key);



  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
    List data = List();
    
     List filtredlist=List();
Future delete(user) async {
    var response = await http.get(
        Uri.parse('https://${widget.url}/api/depot/userrow/$user'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
   print(response.statusCode);

    return "success";
  }
   Future getAllName() async {
      var response = await http.get(
          Uri.parse(
              'https://${widget.url}/api/prot/${widget.aname}'),
          headers: {"Accept": "application/json"});
      var jsonBody = response.body;
      var jsonData = json.decode(jsonBody);
      setState(() {
        data = jsonData;
       
      });
      setState(() {
         filtredlist=data;
      });
      print(jsonData);
      return "success";
    }
    @override
    initState() {
      super.initState();
    getAllName();
      
    }


  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          SizedBox(width: 45,
            child: FloatingActionButton(heroTag: null, onPressed: () {
              setState(() {
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ajouterUtilisateur(
                                        aname: "${widget.aname}",
                                        email: "${widget.email}",
                                        url: "${widget.url}",
                                    )));
              });
            },
                  child: Icon(Icons.add,size: 40,), ),
          ),
      appBar: AppBar(shadowColor: Colors.transparent,
        backgroundColor: Color(0xff62959c),
        title: Text('Gestion des utilisateurs'),
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
       drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}"),resizeToAvoidBottomInset: false,
       body: Column(children: [ Container(decoration: BoxDecoration(color: Color(0xff62959c), borderRadius: BorderRadius.only(
                     bottomLeft: Radius.circular(80),
                     bottomRight: Radius.circular(80))),height: 80,
         child: Center(
           child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,children: [
          
             Container(width: 350,height: 55,
             child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,onChanged: (text){



               text=text.toLowerCase();
               setState(() {
                 filtredlist=data.where((element){
                var title= element["protmUser"].toString().toLowerCase();
                return title.contains(text);
                 }).toList();
               });
             },
          
             decoration: const InputDecoration(fillColor: Colors.white,filled: true,contentPadding: EdgeInsets.all(8),
            suffixIcon: Icon(Icons.search, color: Colors.black,),hintText: 'Recherche',
            border: OutlineInputBorder( borderRadius: const BorderRadius.all(
          const Radius.circular(30.0),
        ),),
             ),
           )),
            ],),
         ),
       ),
   Expanded(
     child: SizedBox(
       child: Container( 
         
         child: ListView.builder( 
             itemCount: filtredlist.length,
             scrollDirection: Axis.vertical,
             itemBuilder: (context, index) {
         return   Padding(
        padding: const EdgeInsets.only(bottom: 5,right:25.0,left:25),
        child: GestureDetector(onTap: (){
   showDialog(context: context, builder: (BuildContext context){
                         return  Center(
                           child: SingleChildScrollView(
                             child: Dialog(
                                backgroundColor: Colors.transparent,
                             insetPadding: EdgeInsets.all(2),
                             child: Stack(
                               overflow: Overflow.visible,
                               alignment: Alignment.center,
                               children: <Widget>[
                          
                                
                                 Container(
                                  width: 380,
                  
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(15),
                                     color: Colors.white
                                   ),
                                   padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                                 child: Column( mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     
                                     Padding(
                                     padding: const EdgeInsets.only(bottom:18.0),
                                     child: Text(filtredlist[index]["protmUser"],style:TextStyle(fontSize: 24,fontWeight: FontWeight.w600)),
                                   ), 
                     
                       
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                         child: Wrap( direction: Axis.horizontal, alignment: WrapAlignment.spaceAround,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top:3.0),
                               child: Text("Rôles et Autorisations ",textAlign: TextAlign.center,),
                             ),SizedBox(width: 10,),Icon(Icons.security_rounded)
                           ],
                         ),
                         color: Colors.blue,
                         textColor: Colors.white,
                         minWidth: 230,
                         height: 50,
                         onPressed: () {
                         setState(() {
                             Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DepotScreen(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}",prot2: filtredlist[index]["protmUser"],)),
                  );
                         });
                         },
                       ),
                                ),         
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                         child: Wrap( direction: Axis.horizontal, alignment: WrapAlignment.spaceAround,
                           children: [
                             Padding(
                                 padding: const EdgeInsets.only(top:3.0),
                                 child: Text('Paramètre de Sécurité',textAlign: TextAlign.center,),
                             ),SizedBox(width: 10,),Icon(Icons.settings)
                           ],
                         ),
                         color: Colors.grey[850],
                         textColor: Colors.white,
                         minWidth: 230,
                         height: 50,
                         onPressed: () {
                                      setState(() {
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => modifierPwd(
                                        aname: "${widget.aname}",
                                        email: "${widget.email}",
                                        url: "${widget.url}",
                                        prot2: filtredlist[index]["protmUser"], 
                                    )));
              });
                         },
                       ),
                              ),
                              
                                      Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                         child: Wrap( direction: Axis.horizontal, alignment: WrapAlignment.spaceAround,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top:3.0),
                               child: Text('Supprimer le compte ',textAlign: TextAlign.center,),
                             ),SizedBox(width: 11,),Icon(Icons.delete)
                           ],
                         ),
                         color: Colors.red,
                         textColor: Colors.white,
                         minWidth: 230,
                         height: 50,
                         onPressed: () {
                                confirmationDialog(context, "le compte "+filtredlist[index]['protmUser']+" sera supprimé définitivement,vous etes sur de le supprimer ?",neutralText: "Annuler",positiveText: "Valider", 
    positiveAction: ()async {   await delete(filtredlist[index]["protmUser"]); 
    setState(() {
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                        aname: "${widget.aname}",
                                        email: "${widget.email}",
                                        url: "${widget.url}",
                                       
                                    )));
          
    });
      
    
    } 
                         
                                );
                         },
                       ),
                                ),  ],
                                ),
                                 ),
                                
                                
                             
                           
                                 Positioned(
                                   top: -70,
                                   child: CircleAvatar(backgroundColor: Colors.grey[350],radius: 60,
                            
                            child: Icon(Icons.person,size:70,color: Colors.white,)),)
                                ],),
                                   ),
                                 
                                 
                               
                                
                               
                               
                         ));
                        });
                        
                     
          
             
        },
          child: Container(height: 70,
            decoration: BoxDecoration(
               border: Border(bottom: BorderSide(width: 0.2, color: Colors.grey.shade900),)  
          ),
          
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Align(alignment: Alignment.centerLeft,
                    child: CircleAvatar(backgroundColor: Colors.grey[350],radius: 25,
                            
                            child: Icon(Icons.person,size:40,color: Colors.white,)),
                  ),
                ),
                 
                Align(alignment: Alignment.center,
                  child: Text(filtredlist[index]['protmUser'],textAlign: TextAlign.center,style: TextStyle(color: Colors.black),)),
              ],
            )
           
                     
          ),
        ),
        );
            
             }),
       ),
     ),
   ),
  ],),
      
    );
  }
}
