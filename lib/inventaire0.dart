import 'package:axia_inventory/ajouterUtilisateur.dart';
import 'package:axia_inventory/inventaire1.dart';
import 'package:axia_inventory/onvalidationinventaire.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'package:flutter/src/rendering/box.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'menu.dart';
import 'inventairehistclass.dart';
import 'dart:ffi';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  //for date format
import 'package:intl/date_symbol_data_local.dart';  

import 'package:intl/intl.dart';



import 'package:auto_size_text/auto_size_text.dart';





import 'sidemenu.dart';


class invacc extends StatefulWidget {
  @override
  _invaccState createState() => _invaccState();

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

  invacc({Key key, this.aname, this.email,this.url,this.entre,this.sortie,this.transfer,this.consult,this.gestionutil,this.inventaires,this.protvalidation}) : super(key: key);
}

class _invaccState extends State<invacc> {
  @override
 List <dynamic>data= List();
final List<Hisinv> invHislist = <Hisinv>[];
int show=0;
bool fa=false;
String nominv;
bool isVisble=false;
  bool isloading=false;
   Future getAllName() async {
    var response = await http.get(
        Uri.parse('https://${widget.url}/api/inventaire/getstoklist/${widget.aname}'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    
    var n= jsonData.length;
    for(var index=0;index<n;index++){var dateFormat;
DateTime dateTime = DateTime.parse(jsonData[index]['is_date']);

  setState(() {
    invHislist..add(Hisinv(jsonData[index]['pi_intitule'], jsonData[index]['fa_codefamille'], jsonData[index]['de_code'],dateTime, jsonData[index]['is_remarques'], jsonData[index]['is_valide'], jsonData[index]['cbcreateur'],jsonData[index]['is_code']));

  }); 
    }

    print(jsonData);
    return "success";
  }
var  filtred=<Hisinv>[]; 
void choiceAction(String choice) {
  if (choice == '1') {
  setState(() {filtred=invHislist;
    filtred.sort((a,b) => a.isDate.compareTo(b.isDate));
  }); 
  } else if (choice == '2') {
    setState(() {filtred=invHislist;
       filtred.sort((a,b) => a.isValide.compareTo(b.isValide));
    });
    
  } else if (choice == '3') {
    setState(() {
      filtred=invHislist.where((element) => element.isValide==0).toList();
    });
  } else if (choice == '4') {
    var d = DateTime.now();
var weekDay = d.weekday;
var firstDayOfWeek = d.subtract(Duration(days: weekDay));
var now = new DateTime.now();
var now_1w = now.subtract(Duration(days: 7)); 
var now_1m = new DateTime(now.year, now.month-1, now.day);
    setState(() {
      filtred=invHislist.where((element) => element.isDate.isAfter(now_1w)).toList();
    });
  }
}

  @override
  initState() {
  
  
    super.initState();
 
    
  }
  Widget build(BuildContext context) {   initializeDateFormatting("fr");
    return MaterialApp( 
      home: Scaffold(resizeToAvoidBottomInset: false,
         floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton:
          Visibility(visible: isVisble,
            child: SizedBox(width: 45,
              child: FloatingActionButton(heroTag: null, onPressed: () {
                setState(() {
                  isVisble=false;
                });
              },
                    child: Icon(Icons.arrow_drop_up_sharp,size: 40,), ),
            ),
          ),
   
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
                    MaterialPageRoute(builder: (context) => Menu(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}"    ,   entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
                  );
                });
              },
            )
          ],
        ),drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}",       entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,),
        body:Column( 
          children: [


          show==0?   Container( height: 200,
           
               child: Column(mainAxisAlignment: MainAxisAlignment.end,
                 children: [ Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Creer un nouveau projet\n inventaire",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500
                   ),),
                 ),
                   SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: FloatingActionButton(
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          onPressed: () {setState(() {
                                            nominv = DateFormat('yyyyMMddkkmm').format(DateTime.now());           
                                            show=1; nominv= 'INV'+nominv;
                                          });},
                                      
                                  
                                          child: Icon(Icons.add),
                                            ),
                                          ),
             SizedBox(height:10)   ],
               ),
             ):show==1?Padding(
               padding: const EdgeInsets.all(20.0),
               child: Container( height: 200, width: 300,decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue,
                          Color(0xff6dd5ed),
                        ]),
                 borderRadius: BorderRadius.circular(30)
               ),
                 child: Center(
                   child: Padding(
                     padding: const EdgeInsets.only(top:20.0),
                     child: Column(children: [
                          
                           Container(
                       child: FlatButton(
                         child: Wrap( direction: Axis.horizontal, alignment: WrapAlignment.spaceAround,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top:3.0),
                               child: Text('Avec scan code a barre',textAlign: TextAlign.center,),
                             ),SizedBox(width: 10,),Icon(Icons.qr_code_scanner_sharp)
                           ],
                         ),
                         color: Colors.grey[850],
                         textColor: Colors.white,
                         minWidth: 230,
                         height: 50,
                         onPressed: () {
                           setState(() {show=3; fa=false;});
                         },
                       ),
                      
                     ),SizedBox(height: 50,child:Center(child: Text("OU",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600  ) ,textAlign: TextAlign.center,)) ,)
                     , Container(
                       child: FlatButton(
                         child:  Wrap( direction: Axis.horizontal, alignment: WrapAlignment.spaceAround,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top:3.0),
                               child: Text('Avec Code famille',textAlign: TextAlign.center,),
                             ),SizedBox(width: 40 ,),Icon(Icons.category)
                           ],
                         ),
                         color: Colors.grey[850],
                         textColor: Colors.white,
                         minWidth: 230,
                         height: 50,
                         onPressed: () {
                         setState(() {
                           show=3; 
                           fa=true;
                         });
                         }
                       ),
                     )],),
                   ),
                 ),
               ),
             ):show==3?inventaire(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}",fa: fa,nominv: nominv,  entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,):SizedBox.shrink(),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff2193b0),
                          Color(0xff6dd5ed),
                        ])),child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [SizedBox(width: 30,),
                            Text('Historiques des inventaires',style: TextStyle(fontSize: 20,color:Colors.white)),
                      SizedBox(width: 20,), GestureDetector(onTap:(){
                       Set<SimpleItem> set = Set<SimpleItem>()
               ..add(SimpleItem(3, "afficher seulement les inventaires en attente"))
                  ..add(SimpleItem(2, "sort par en attente"))
                 ..add(SimpleItem(4, "depuis la semaine derni??re"))
                  ..add(SimpleItem(1, "sort par valid??"));
                    
radioListDialog(
  context,
  "Select one",
  set,
  (item) {print(item.id);setState(() { 
    choiceAction(item.id.toString());
  });

    

     },
);
                      } ,child: Icon(Icons.filter_list_rounded)) ],
                        )),
        
        
         isVisble==true ? Expanded(
           child: SizedBox(height: 200.0,
             child: ListView.builder( itemCount: filtred.length,shrinkWrap: true,
                      scrollDirection: Axis.vertical,
               itemBuilder: (context, index) {
               
           double c_width = MediaQuery.of(context).size.width * 0.37; 
          String hhmm= DateFormat.Hm().format(filtred[index].isDate.toLocal());

   var formater= DateFormat("EEEE\ndd/MM/yyyy", 'fr');
  String dd=formater.format(filtred[index].isDate.toLocal());
                     return Container(
                       child: GestureDetector( onTap: (){      print(widget.protvalidation);
                         if(widget.protvalidation==true && filtred[index].isValide==0){
                                    
                                    setState(() {
                         Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => onvalidationInv(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}",pintitu: filtred[index].piIntitule,comment: filtred[index].isRemarques,decode: filtred[index].deCode, collab: filtred[index].cbcreateur,iscode: filtred[index].iscode,status: filtred[index].isValide,entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
                  );
                       });
                         }else if(widget.protvalidation==false && filtred[index].isValide==0){

                     return      errorDialog(context,"tu n'a pas le droit de validation");
                         }else if(widget.protvalidation==false ||widget.protvalidation==true && filtred[index].isValide==1 ){

                                         setState(() {
                         Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => onvalidationInv(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}",pintitu: filtred[index].piIntitule,comment: filtred[index].isRemarques,decode: filtred[index].deCode, collab: filtred[index].cbcreateur,iscode: filtred[index].iscode,status: filtred[index].isValide,entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
                  );
                       });
                         }
                         
                        
                        },
                         child: Card( child: Stack(children: [
                                           Padding(
                                             padding: const EdgeInsets.only(left:8.0,top:5),
                                             child: Align(alignment: Alignment.topLeft,child: Row(children: [Icon(
                                              Icons.fiber_manual_record,
                                              color: Colors.blue,
                                              size: 13,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ), Text(filtred[index].piIntitule,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)],) ,),
                                           ),
                                           
                                             Padding(
                          padding: const EdgeInsets.only(top:20.0 ,right: 5),
                          child: Align(alignment:Alignment.centerRight,child: IntrinsicHeight(
                            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [ VerticalDivider(),
                                Column( 
                                  children: [
                                    Text(dd+'\n'+hhmm ,textAlign:TextAlign.center,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700,fontSize: 15),),
                                    SizedBox(height: 8,),
                                   filtred[index].isValide==1?  Text('Valider',style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600,color:Colors.green,),):Text('en attente',textAlign:TextAlign.center,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600,color:Colors.yellow[700],)),
                                    filtred[index].isValide==1?   Icon(Icons.done_outline_rounded,color: Colors.green,size: 25,):Icon(Icons.pending,color:Colors.yellow[700])
                                
                                       ,
                                  
                                   
                                  ],
                                ),
                              ],
                            ),
                          )),
                                             ),
                                           Padding(
                                             padding: const EdgeInsets.only(top:30.0,left: 25),
                                             child: 
                         
                            Table( 
                                                        defaultColumnWidth: FixedColumnWidth(130) ,
                                                      children: [ 
                                                   TableRow(children: [TableCell(
                                                     child: SizedBox(child:  Text('Code Depot:',style: TextStyle(color: Colors.grey,)))
                                                    
                                                     
                                                        ),
                                                        TableCell(
                                                     child: SizedBox(child:  Text(filtred[index].deCode),),
                                                  ),
                                                    
                                                   ]),
                                                    TableRow(children: [TableCell(
                                                     child:filtred[index].isRemarques!=''? SizedBox(child:  Text('Commentaire:',style: TextStyle(color: Colors.grey,))):SizedBox.shrink()
                                                    
                                                     
                                                        ),
                                                        TableCell(
                                                     child: filtred[index].isRemarques!=''?SizedBox(child:  AutoSizeText(
                               filtred[index].isRemarques,
                               
                               minFontSize: 15,
                               maxLines: 3,
                               
                                                    ),):SizedBox.shrink(),),
                                                 
                                                    
                                                   ]),
                                                     TableRow(children: [TableCell(
                                                     child: SizedBox(child:  Text('Collaborateur:',style: TextStyle(color: Colors.grey,)))
                                                    
                                                     
                                                        ),
                                                        TableCell(
                                                     child: SizedBox(child:  Text(filtred[index].cbcreateur,),),
                                                  ),
                                                    
                                                   ]),
                                                  filtred[index].faCodefamille !=''?  TableRow(children: [TableCell(
                                                     child: SizedBox(child:  Text('Famille Code:',style: TextStyle(color: Colors.grey,)))
                                                    
                                                     
                                                        ),
                                                        TableCell(
                                                     child: SizedBox(child:  Text(filtred[index].faCodefamille,style:TextStyle(color: Colors.black)),),
                                                  ),
                                                    
                                                   ]):TableRow(children:[TableCell(child: SizedBox.shrink(),),TableCell(child: SizedBox.shrink())] ),
                                                    
                                                      
                                      
                                                
                                                      ],
                                                    ),
                                           
                                           ),
                                             
                                
                       
                       
                         ]
                                            )),
                       ));
           
           
           
           
               }),
           ),
         ):Container(height: 250,
           child: Center(
           child: Column(mainAxisAlignment: MainAxisAlignment.center,

             children:[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.hide_source_rounded ,size: 90,),
              ),
            Container(
               child:  !isloading
                 ?FlatButton(
                 child: Text("Afficher l'Historique d'Inventaire"),
                 color: Color(0xffec524b),
                 textColor: Colors.white,
                 minWidth: 200,
                 height: 50,
                 onPressed: () async {setState(() {
                   isloading=true;
                   invHislist.clear();
                 });
                   await   getAllName();

                   setState(() {
               
                   isloading=false;
                
                     isVisble=true;filtred=invHislist;
                
                   });
                 }
               ):CircularProgressIndicator(),
             ),


             ]
           ),
         ),)
          ],
              


        ),
        
        
        
        ));
  }
}



