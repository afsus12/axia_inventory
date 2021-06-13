import 'dart:ffi';
import 'package:axia_inventory/sidemenu.dart';
import 'package:flutter/material.dart';

import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';

import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'consultation1.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'api.dart';

class DepotScreen extends StatefulWidget {
  @override
  _DepotScreenState createState() => _DepotScreenState();
  final String aname;
  final String email;
  final String url;
  final String prot2;

  DepotScreen({Key key, this.aname,this.email,this.url,this.prot2}) : super(key: key);
}

class _DepotScreenState extends State<DepotScreen> {
  TextEditingController protmUserController = TextEditingController();
  TextEditingController protmPwdController = TextEditingController();
  TextEditingController decodeController = TextEditingController();
  TextEditingController protmDescriptionController = TextEditingController();
  TextEditingController protmRightController = TextEditingController();
  TextEditingController protmEmailController = TextEditingController();
  TextEditingController protmUserprofilController = TextEditingController();
  TextEditingController protmAdministratorController = TextEditingController();
  TextEditingController cbcreateurController = TextEditingController();
  bool _isDisabled = false;
      String selectedName;
      String selectedNameadd;
      bool  imagevalid=false;
      bool transfere=false;
      bool entree=false;
      bool sortie=false;
      bool inv=false;
      bool consult=false;
      bool _iscolored6=false;
    List data = List();
    List data2= List();
    List depAdd=List();
    bool isloading=false;
    bool   validinv=false;
    List<bool> boollist=List();
    List<bool> _switchValues = List.generate(7, (_) => false);
  int admin;
  List pre=List();
   Future getAllName() async {
    var response = await http.get(
        Uri.parse(
            "https://${widget.url}/api/Depot/selection/${widget.aname}"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      data = jsonData;
    });
   
    print(jsonData);
   await getadminrights();
   await getAllName2();
       

 await getaccess();

   
    return "success";
  }


Future delete(dep) async {
    var response = await http.get(
        Uri.parse('https://${widget.url}/api/depot/deleterow/$dep/${widget.prot2}'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
   print(response.statusCode);

    return "success";
  }


   Future<http.Response> adddepot(dep) async {
  var url = 'https://${widget.url}/api/depot/adddepedit/$dep/${widget.prot2}/${widget.aname}';

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"});

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}

  
   Future getaccess() async {
    var response = await http.get(
        Uri.parse(
            "https://${widget.url}/api/users/getusers/${widget.prot2}"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    
   
    print(jsonData);
       
setState(() {
  entree=jsonData["maAccessentree"];
  sortie=jsonData["maAccesssortie"];
    transfere=jsonData["maAccesstransfert"];
     inv=jsonData["maAccessinventaire"];
     consult=jsonData["maAccessconsultaiton"];

});


   
    return "success";
  }

  findit(borga){
    if(borga!=null){
      for (var i = 0; i < data.length; i++) {
      for(var j=0;j< borga.length;j++){
         if(data[i]['deIntitule']==borga[j]['deIntitule']){
            setState(() {
              _switchValues[i]=true;
            });
         }
      }
        
      }
   }   
  }

   Future<http.Response> adminRights(bint) async {
  var url = 'https://${widget.url}/api/users/protright/${widget.prot2}/${widget.aname}';

  Map data = {
 "protmAdministrator":bint,
 "protmRight":validinv
};
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
   Future<http.Response> editRights() async {
  var url = 'https://${widget.url}/api/users/editroles';

  Map data = {
    
    "protmUser": "${widget.prot2}",
  "cbcreateur":"${widget.aname}",
  "maAccessentree":entree,
  "maAccesssortie":sortie,
  "maAccesstransfert":transfere,
  "maAccessinventaire":inv,
  "maAccessconsultaiton":consult,
  "maAccessgestionutil":false,
  };
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
  Future getAllName2() async {
    var response = await http.get(
        Uri.parse(
            "https://${widget.url}/api/Depot/selection/${widget.prot2}"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);




findit(jsonData);

   
    return "success";
  }
  Future getAllName3() async {
    var response = await http.get(
        Uri.parse(
            "https://${widget.url}/api/Depot/"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      
      depAdd.clear();
    });     var j=0;
          for(var i=0;i<jsonData.length;i++){
            
              var j=0;
               while(j<data.length && jsonData[i]['de_intitule']!=data[j]['deIntitule']){
                j++;
                }

                if(j==data.length){
                  setState(() {
                    depAdd..add(jsonData[i]);
                  });
                }
                }
          
   
    return "success";
  }

    Future getadminrights() async {
    var response = await http.get(
        Uri.parse(
            "https://${widget.url}/api/users/getright/${widget.prot2}"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

 if(jsonData["protmAdministrator"]==1){

 setState(() {
   _isDisabled=true;

 });

 } else{setState(() {
    _isDisabled=false;
 });
  
 }

    setState(() {
     validinv=jsonData["protmRight"];
   });
    return "success";
  }
 @override
  initState() {
  
  getAllName();
    super.initState();

   
    
  }
  @override
  Widget build(BuildContext context) {


    

   

    return Scaffold(
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
    '${widget.aname}'== '${widget.prot2}'     ? SizedBox(width: 45,
            child: FloatingActionButton(heroTag: null, onPressed: () async{
              
              
              await getAllName3();
            showDialog(context: context, builder: (BuildContext context){
                         return 
                           StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                               return Center(
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
                                           padding: const EdgeInsets.only(top:8.0,bottom:18),
                                           child: Text("Ajout Depot",style: TextStyle(fontSize:22,fontWeight: FontWeight.bold),),
                                         ),
                                        
                                   Padding(
                                             padding: const EdgeInsets.only(left:8.0,bottom: 8),
                                             child: Container(
                                             width: 320,
                                             height: 35,
                                             decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(30),
                                             side:  _iscolored6==false? BorderSide(
                                           width: 0.6, style: BorderStyle.solid):BorderSide(
                                           width: 2, style: BorderStyle.solid,color: Colors.red),
                                              ),
                                             ),
                                             child: DropdownButtonHideUnderline(
                                              child: ButtonTheme(
                                             alignedDropdown: true,
                                             child: DropdownButton(
                                               hint: _iscolored6==false?Text(
                                             'selectioner un entrepôt',
                                             style: TextStyle(
                                               color: Color(0xFF8B8B8B), fontSize: 12)
                                               ):Text(
                                             'selectioner un entrepôt',
                                             style: TextStyle(
                                               color: Colors.red, fontSize: 12)
                                               ),
                                               icon: Icon(Icons.arrow_drop_down),
                                               iconSize: 20,
                                                value: selectedNameadd,
                                                   
                                                
                                               items: depAdd.map((list) {
                                             return DropdownMenuItem(
                                             child: new Text(list['de_intitule'],
                                             style: TextStyle(
                                                 color: Colors.black,
                                                 fontSize: 15,
                                                 fontWeight: FontWeight.normal)),
                                            value: list['de_intitule'],
                                             );
                                               }).toList(),
                                               onChanged: (value){
                                
                                         
                                     
                                             setState(() {
                                               
                                               _iscolored6=false;
                                             selectedNameadd = value;
                                               print(selectedNameadd);
                                             });
                                           
                                             var b=value;
                                            
                                           
                                   
                                             },
                                               style: Theme.of(context).textTheme.title,
                                             ),
                                              ),
                                             ),
                                              ),
                                           ),
                                                  
                                         
                                                Container(  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.blue[500]),
                                       child: FlatButton(
                                           onPressed: () async{
                                        if(selectedNameadd!=null){
                                         for(var i=0;i<depAdd.length;i++){
                           
                                        if(selectedNameadd==depAdd[i]['de_intitule']){
                           
                                              await adddepot(depAdd[i]['de_code']);
                                        }
                                           
                                         }
                                         setState((){

                                           selectedNameadd=null;
                                         });
                                         setState(() {
                                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DepotScreen(
                                          aname: "${widget.aname}",
                                          email: "${widget.email}",
                                          url: "${widget.url}"
                                          ,prot2: "${widget.prot2}")),

 

                                );
                                                  
                                         });
                                         }else{
                                           setState((){
                                         _iscolored6=true;
                                           });
                                         }
                                         
                                          
                                       
                                         
                           
                                             },
                                           
                                           child: Text("Ajouter",style: TextStyle(fontSize: 18,color: Colors.white),)),
                                     ),      
                                  
                                         ],
                                    ),
                                     ),
                                    
                                    
                                 
                               
                                     Positioned(
                                       top: -70,
                                       child: CircleAvatar(backgroundColor: Colors.grey[350],radius: 60,
                                
                                child: Icon(Icons.maps_home_work_rounded,size:70,color: Colors.white,)),)
                                    ],),
                                       ),
                                     
                                     
                                   
                                    
                                   
                                   
                                                    ));
                             }
                           );
                        });
            },
                  child: Icon(Icons.add,size: 40,), ),
          ):SizedBox.shrink(),
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Rôles et Autorisations'),
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
      drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}"),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            child: Column(
              
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:18.0),
                  child: CircleAvatar(backgroundColor: Colors.grey[350],radius: 58,
                              
                              child: Icon(Icons.person,size:80,color: Colors.white,)),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${widget.prot2}",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
                ),    
         
       Padding(
                  padding: const EdgeInsets.only(left:80.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Administrateur :'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 23, top: 20),
                        child: Container(
                          width: 70,
                          height: 35,
                          child: Switch(
                              value: _isDisabled,
                              onChanged: (check) {
                                setState(() { 
                                  _isDisabled = check; 
                                  print(check);
                                  if (_isDisabled == true) {
                                    admin = 1;
                                  } else {
                                    admin = 0;
                                  }
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
       
                
    
              Container(height: 50,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only( bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)))
                ,child: Center(child: Text("Liste des depots",style: TextStyle(fontSize: 18,color: Colors.white)))),
              Padding(
                padding: const EdgeInsets.only(left:35.0,right: 28),
                child: SizedBox(height: 250,
                   child: ListView.builder( shrinkWrap: true,
                              itemCount: data.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                          return  ListTile(
                            leading:Icon(Icons.home_work_sharp),
                            title: Text(data[index]['deIntitule']),
                            trailing:             Switch(value:  _switchValues[index], onChanged:(value){
                          setState(() {
                      _switchValues[index]= value;
                        print( _switchValues[index]);
                               });
                        } ),
                          );
                             
                              }),
                 ),
              ), 
  
                  _isDisabled==false ?      Container(height: 50,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only( bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100)))
                ,child: Center(child: Text("Les Droits D'utilisateur",style: TextStyle(fontSize: 18,color: Colors.white)))):SizedBox.shrink(),
               _isDisabled==false ? Container(child: Row(
                 children: [  
                   Padding(
                     padding: const EdgeInsets.only(left:48.0),
                     child: Column(children:[
             SizedBox(height: 47,child: Center(child: Image.asset(
              'images/in1.png',
              height: 35,
              width: 35,
            ),),),
                SizedBox(height: 47,child: Center(child: Image.asset(
              'images/out2.png',
              height: 35,
              width: 35,
            ),),),
                SizedBox(height: 47,child: Center(child: Image.asset(
              'images/exchange2.png',
              height: 35,
              width: 35,
            ),),),
                SizedBox(height: 47,child: Center(child: Image.asset(
              'images/inventory2.png',
              height: 35,
              width: 35,
            ),),),
                SizedBox(height: 47,child: Center(child: Image.asset(
              'images/his2.png',
              height: 35,
              width: 35,
            ),),),
            SizedBox(height: 47,child: Center(child: Icon(
              Icons.verified,size: 35,color: Colors.grey
            ),),),
            



                     ]),
                   ),
                   
                   SizedBox(width: 25,),
                   Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     
                    SizedBox(height: 47,child: Center(child: Text('Entrée en Stock')),),
                    SizedBox(height: 47,child: Center(child: Text('Sortie du stock')),),
                    SizedBox(height: 47,child: Center(child: Text('Transfert du stock')),),
                    SizedBox(height: 47,child: Center(child: Text('Inventaire')),),
                    SizedBox(height: 47,child: Center(child: Text('Consultation historiques')),),
                     SizedBox(height: 47,child: Center(child: Text('Validation des inventaires')),),
                   ],
               ),
              SizedBox(width: 33,),
                Column(mainAxisAlignment: MainAxisAlignment.center,children:[ 
                   Switch(value: entree, onChanged:(value){
                      setState(() {
                    entree= value;
                    print(entree);
              });
                    } ),
                      Switch(value: sortie, onChanged:(value){
                      setState(() {
                    sortie= value;
                    print(sortie);
              });
                    } ),
                     Switch(value: transfere, onChanged:(value){
                      setState(() {
                   transfere= value;
                    print(transfere);
              });
                    } ),
                     Switch(value: inv, onChanged:(value){
                      setState(() {
                    inv= value;
                    print(inv);
              });
                    } ),
                     Switch(value: consult, onChanged:(value){
                      setState(() {
                   consult= value;
                    print(consult);
              });
                    } ),
                      Switch(value:   validinv, onChanged:(value){
                      setState(() {
                   validinv= value;
                    print(  validinv);
              });
                    } ),
                ],)
                
                
                ],)):SizedBox.shrink(),
                 
             
                Padding(
                  padding: const EdgeInsets.only(top: 20.0,bottom: 50),
                  child: Center(
                    child: Container(
                      child: isloading==false?FlatButton(
                        child: Text('Enregistrer'),
                        color: Color(0xffec524b),
                        textColor: Colors.white,
                        minWidth: 100,
                        height: 50,
                        onPressed: () async { 
                          setState(() {
                            isloading=true;
                          });
                         for(var i=0 ;i<data.length;i++){
                        if(_switchValues[i]==true){

                    await   adddepot(data[i]['deCode']);

                        } else{

                       await    delete(data[i]['deCode']);
                        }
                           
                         }
                      if(_isDisabled==false){ 
                        await adminRights(0);
                         await editRights();   
                      }else{

                            await adminRights(1);
                      }
                    
                        setState(() {
                          isloading=false;
                        });
                          }
                        ,
                      ):CircularProgressIndicator(),
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
